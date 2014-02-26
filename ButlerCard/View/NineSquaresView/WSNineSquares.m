//
//  WSNineSquares.m
//  FlyingCodes WifiSwitch
//
//  Created by johnny tang on 8/19/13.
//  Copyright (c) 2013 GZTech Electronics (Shenzhen) Company Limited. All rights reserved.
//

#import "WSNineSquares.h"
#import "WSNineSquaresCell.h"
#import "WSNineSquaresUpdateItem.h"

#define kMarginWidth            6
#define kMarginHeight           0
#define kSideMargin             19
#define kTopMargin              30
#define kCellWidth              90
#define kCellHeight             98
#define kNumOfCellsInRow        3
#define kMaxCells               22

@interface WSNineSquares () <WSNineSquaresCellDelegate>

@property (assign, nonatomic) NSInteger optCellIndex;
@property (strong, nonatomic) WSNineSquaresCell *touchedCell;
@property (strong, nonatomic) NSMutableArray *cells;
@property (assign, nonatomic) CGPoint offsetPt;
@property (strong, nonatomic) NSMutableArray *updateItems;
@property (strong, nonatomic) NSMutableArray *cellsRects;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UITapGestureRecognizer *backgroundSingleTap;
@property (assign, nonatomic) BOOL isDeletedMode;
@property (assign, nonatomic) BOOL layoutEnable;
@end

@implementation WSNineSquares


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _layoutEnable = YES;
        
        _cells = [NSMutableArray array];
        _cellsRects  =  [NSMutableArray array];
        _updateItems =  [NSMutableArray array];
        
        // 添加长按  使所有按钮进入编辑状态
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveActionGestureRecognizerStateChanged:)];
        [self addGestureRecognizer: longPressGesture];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = [self calculateAddButtonRect];
        [_addButton setImage:[UIImage imageNamed:@"btn添加房间开关.png"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_addButton];
        
        _backgroundSingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundSingleTapedHandle:)];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
        self.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _layoutEnable = YES;
        
        _cells = [NSMutableArray array];
        _cellsRects  =  [NSMutableArray array];
        _updateItems =  [NSMutableArray array];
        
        // 添加长按  使所有按钮进入编辑状态
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveActionGestureRecognizerStateChanged:)];
        [self addGestureRecognizer: longPressGesture];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = [self calculateAddButtonRect];
        [_addButton setImage:[UIImage imageNamed:@"btn添加房间开关.png"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_addButton];
        
        _backgroundSingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundSingleTapedHandle:)];
    }
    
    return  self;
}

- (void)backgroundSingleTapedHandle:(UITapGestureRecognizer *)gestureRecognizer {
    [self hideDeleteBtns:YES];
}

- (void)layoutSubviews {
    
    if (_layoutEnable) {
        _layoutEnable = NO;
        _isDeletedMode = NO;
        
        UIView *view;
        for(int i = 0; i < [_cells count]; i++) {
            view = _cells[i];
            [view removeFromSuperview];
        }
        [_cells removeAllObjects];
        [_cellsRects removeAllObjects];
        
        CGRect rect;
        WSNineSquaresCell *cell;
        for(int i = 0; i < [_nineSquaresDateSource numberOfCellsInNineSquares:self]; i++) {
            int rowNum = i / kNumOfCellsInRow;
            int column = i % kNumOfCellsInRow;
            rect = CGRectMake(kSideMargin  + column * (kMarginWidth + kCellWidth), kTopMargin + rowNum * (kMarginHeight + kCellHeight), kCellWidth, kCellHeight);
            cell = [[WSNineSquaresCell alloc] initWithFrame:rect];
            cell.delegate  = self;
            cell.index = i;
            cell.oldIndex = cell.index;
            cell = [_nineSquaresDateSource nineSquares:self initCell:cell atIndex:cell.index];
            [self addSubview:cell];
            NSValue *value = [NSValue valueWithCGRect:rect];
            [_cellsRects addObject:value];
            [_cells addObject:cell];
        }
        
        [self adjustScrollViewContentSize];
        _addButton.frame = [self calculateAddButtonRect];
    }
}

- (NSUInteger)cellsCount {
    return _cells.count;
}

- (void)reloadData {
    _layoutEnable = YES;
    [self setNeedsLayout];
}

- (BOOL)pointInRect:(CGRect)rect point:(CGPoint)point {
    if((rect.origin.x <= point.x) && (rect.origin.y <= point.y) &&
       (point.x <= rect.origin.x + rect.size.width) && (point.y <= rect.origin.y + rect.size.height)) {
        
        return YES;
    } else {
        return NO;
    }
}

- (int)findPressedCell:(CGPoint)point {
    for(int i = 0; i < [_cellsRects count]; i++) {
        NSValue *value = (NSValue *)_cellsRects[i];
        CGRect rect = [value CGRectValue];
        if([self pointInRect:rect point:point]) {
            return i;
        }
    }
    
    return -1;
}

- (void)adjustScrollViewContentSize {
    //caculate total row
    int count = [_nineSquaresDateSource numberOfCellsInNineSquares:self] + 1; //count需要算添加按钮，所以加1
    int total = count / kNumOfCellsInRow;
    int totalRows = (count % kNumOfCellsInRow == 0)? total:(total + 1);
    
    CGSize size = self.frame.size;
    self.contentSize = CGSizeMake(size.width, totalRows*(kCellHeight+kMarginHeight)+kTopMargin);
}

- (void)hideDeleteBtns:(BOOL)hidden; {
    if (hidden == YES) {
        _isDeletedMode = NO;
    } else {
        _isDeletedMode = YES;
    }
    
    for(int i = 0; i < [_cells count]; i++) {
        WSNineSquaresCell *cell = _cells[i];
        [cell hideDeleteBtn:hidden];
    }
    
}

- (CGRect)calculateAddButtonRect {
    int totalCells = [_cells count];
    int rowNum = totalCells / kNumOfCellsInRow;
    int column = totalCells % kNumOfCellsInRow;
    
    return CGRectMake(kSideMargin + column * (kMarginWidth + kCellWidth) + 10, kTopMargin + rowNum * (kMarginHeight + kCellHeight) + 10, kCellWidth - 20, kCellHeight - 20 - 10);
}

- (void)moveActionGestureRecognizerStateChanged: (UIGestureRecognizer *) recognizer {
    //if no repond to delegate nineSquares:targetIndexForMoveFromCellAtIndex:toProposedIndex: or nineSquares:willDeleteCell:, return
    if( !([_nineSquaresDelegate respondsToSelector:@selector(nineSquares:targetIndexForMoveFromCellAtIndex:toProposedIndex:)]
          || [_nineSquaresDelegate respondsToSelector:@selector(nineSquares:willDeleteCell:)]) ) {
        
        return;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            [self addGestureRecognizer:_backgroundSingleTap];
            [self hideDeleteBtns:NO];
            
            CGPoint location = [recognizer locationInView:self];
            _optCellIndex = [self findPressedCell:location];
            if(_optCellIndex != -1)
            {
                _touchedCell = _cells[_optCellIndex];
                _offsetPt = CGPointMake(location.x - _touchedCell.frame.origin.x, location.y - _touchedCell.frame.origin.y);
                [self bringSubviewToFront:_touchedCell];
                _touchedCell.oldIndex = _touchedCell.index;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            NSValue *value = _cellsRects[_touchedCell.index];
            CGRect rect = [value CGRectValue];
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                             animations:^(void) {
                                 _touchedCell.frame = rect;
                                 if (_touchedCell.oldIndex != _touchedCell.index) {
                                     [_nineSquaresDelegate nineSquares:self targetIndexForMoveFromCellAtIndex:_touchedCell.oldIndex toProposedIndex:_touchedCell.index];
                                 }
                             }
                             completion:^(BOOL finished) {
                                 if (_touchedCell.oldIndex != _touchedCell.index) {
                                     [self reloadData];
                                 }
                             }];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if( ![_nineSquaresDelegate respondsToSelector:@selector(nineSquares:targetIndexForMoveFromCellAtIndex:toProposedIndex:)]) {
                return;
            }
            
            CGPoint location = [recognizer locationInView:self];
            if(_optCellIndex != -1)
            {
                _touchedCell.frame = CGRectMake(location.x - _offsetPt.x, location.y - _offsetPt.y, kCellWidth, kCellHeight);
                
                CGPoint centerPoint = CGPointMake(location.x + (_offsetPt.x - kCellWidth / 2), location.y + (_offsetPt.y - kCellHeight / 2));
                for(int i = 0; i < [_cellsRects count]; i++)
                {
                    WSNineSquaresCell *cell = _cells[i];
                    NSValue *value = _cellsRects[i];
                    CGRect rect = [value CGRectValue];
                    if(cell != _touchedCell)
                    {
                        [_updateItems removeAllObjects];
                        if([self pointInRect:rect point:centerPoint])
                        {
                            if(_touchedCell.index < cell.index)
                            {
                                for(int j = _touchedCell.index; j <= cell.index; j++)
                                {
                                    WSNineSquaresUpdateItem *item = [[WSNineSquaresUpdateItem alloc] init];
                                    item.oldIndex = j;
                                    if(j == _touchedCell.index)
                                    {
                                        item.newIndex = cell.index;
                                        value = _cellsRects[cell.index];
                                    }
                                    else
                                    {
                                        item.newIndex = j - 1;
                                        value = _cellsRects[j - 1];
                                    }
                                    rect = [value CGRectValue];
                                    item.movedRect = rect;
                                    [_updateItems addObject:item];
                                }
                            } else if(_touchedCell.index > cell.index) {
                                for(int j = _touchedCell.index; cell.index <= j; j--) {
                                    WSNineSquaresUpdateItem *item = [[WSNineSquaresUpdateItem alloc] init];
                                    item.oldIndex = j;
                                    if(j == _touchedCell.index) {
                                        item.newIndex = cell.index;
                                        value = _cellsRects[cell.index];
                                    } else {
                                        item.newIndex = j + 1;
                                        value = _cellsRects[j + 1];
                                    }
                                    rect = [value CGRectValue];
                                    item.movedRect = rect;
                                    [_updateItems addObject:item];
                                }
                            }
                            
                            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                             animations:^(void) {
                                                 NSMutableArray *mutableCopy = [_cells mutableCopy];
                                                 for(int j = 0; j < [_updateItems count]; j++)
                                                 {
                                                     WSNineSquaresUpdateItem *item = _updateItems[j];
                                                     WSNineSquaresCell *tmpCell = _cells[item.oldIndex];
                                                     tmpCell.index = item.newIndex;
                                                     tmpCell.frame = item.movedRect;
                                                     
                                                     mutableCopy[item.newIndex] = tmpCell;
                                                 }
                                                 _cells = mutableCopy;
                                             }
                                             completion:^(BOOL finished) {
                                                 [_updateItems removeAllObjects];
                                             }];
                            break;
                        }
                    }
                }
            }
            break;
        default:
            break;
        }
    }
}

- (void)addButtonClicked:(id)sender {
    if (_cells.count >= kMaxCells) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Warning",@"InfoPlist", nil)
                                                            message:NSLocalizedStringFromTable(@"Reach max switchs,\ncan't add more switchs",@"InfoPlist", nil)
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedStringFromTable(@"OK", @"InfoPlist", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if([_nineSquaresDelegate respondsToSelector:@selector(nineSquaresWillAddCell:)] && [_nineSquaresDelegate nineSquaresWillAddCell:self]) {
        [self reloadData];
    }
}

#pragma mark --
#pragma mark - WSNineSquaresCell delegate method
- (void)WSNineSquaresCellClicked:(WSNineSquaresCell *)cell {
    [self removeGestureRecognizer:_backgroundSingleTap];
    if (_isDeletedMode == YES) {
        [self hideDeleteBtns:YES];
        return;
    }
    
    if (_nineSquaresDelegate && [_nineSquaresDelegate respondsToSelector:@selector(nineSquares:cellClicked:)]) {
        [_nineSquaresDelegate nineSquares:self cellClicked:cell];
    }
}

- (void)WSNineSquaresCellDeleteButtonClicked:(WSNineSquaresCell *)cell {
    [self removeGestureRecognizer:_backgroundSingleTap];
    
    //if delegate not deleted any data, return
    if(![_nineSquaresDelegate respondsToSelector:@selector(nineSquares:willDeleteCell:)]
       || ![_nineSquaresDelegate nineSquares:self willDeleteCell:cell])
    {   //没有删除开关，返回
        return;
    }
    
    [_updateItems removeAllObjects];
    for(int i = cell.index; i < [_cells count] - 1; i++) {
        WSNineSquaresUpdateItem *item = [[WSNineSquaresUpdateItem alloc] init];
        item.oldIndex = i + 1;
        item.newIndex = i;
        NSValue *value = (NSValue *)_cellsRects[i];
        
        CGRect rect = [value CGRectValue];
        item.movedRect = rect;
        [_updateItems addObject:item];
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         for(int j = 0; j < [_updateItems count]; j++)
                         {
                             WSNineSquaresUpdateItem *item = _updateItems[j];
                             WSNineSquaresCell *tmpCell = _cells[item.oldIndex];
                             tmpCell.index = item.newIndex;
                             tmpCell.frame = item.movedRect;
                         }
                         
                         [_cells removeObjectAtIndex:cell.index];
                         [cell removeFromSuperview];
                     }
                     completion:^(BOOL finished) {
                         [_updateItems removeAllObjects];
                         [self reloadData];
                     }];
}

@end
