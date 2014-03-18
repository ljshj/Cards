//
//  ComboBoxView.m
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ComboBoxView.h"

@interface ComboBoxView () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UILabel      *selectContentLabel;
@property (strong, nonatomic) UIButton	   *pulldownButton;
@property (strong, nonatomic) UIButton     *hiddenButton;
@property (strong, nonatomic) UITableView  *comboBoxTableView;
@property (assign, nonatomic) BOOL         needShowComboBox;
@property (assign, nonatomic) NSUInteger   defaultCellHeight;

@end

@implementation ComboBoxView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _defaultCellHeight = self.frame.size.height;
		[self initCompentWithFrame:frame];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.clipsToBounds = YES;
        _defaultCellHeight = self.frame.size.height;
        [self initCompentWithFrame:self.frame];
    }
    
    return self;
}

- (void) layoutSubviews {
    _selectContentLabel.text = _comboBoxDatasource[_selectedItemIndex];
}

#pragma mark -
#pragma mark custom methods
- (void)initCompentWithFrame:(CGRect)frame {
	_selectContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 45, _defaultCellHeight)];
	_selectContentLabel.font = [UIFont systemFontOfSize:14.0f];
	_selectContentLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:_selectContentLabel];
	
	_pulldownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _pulldownButton.frame = CGRectMake(frame.size.width - _defaultCellHeight, 0, _defaultCellHeight, _defaultCellHeight);
	[_pulldownButton setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [_pulldownButton setBackgroundImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
	[_pulldownButton addTarget:self action:@selector(pulldownButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_pulldownButton];
	
	_hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _hiddenButton.frame = CGRectMake(0, 0, frame.size.width - _defaultCellHeight, _defaultCellHeight);
	_hiddenButton.backgroundColor = [UIColor clearColor];
	[_hiddenButton addTarget:self action:@selector(pulldownButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_hiddenButton];
	
	_comboBoxTableView = [[UITableView alloc] initWithFrame:CGRectMake(2 , _defaultCellHeight, frame.size.width - 4, _defaultCellHeight * 5)];
	_comboBoxTableView.dataSource = self;
	_comboBoxTableView.delegate = self;
	_comboBoxTableView.backgroundColor = [UIColor clearColor];
	_comboBoxTableView.separatorColor = [UIColor blackColor];
	[self addSubview:_comboBoxTableView];
}

- (void)showComboBox {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), _defaultCellHeight * 6);
	_needShowComboBox = YES;
    _pulldownButton.selected = YES;
	[self setNeedsDisplay];
}

- (void)hideComboBox {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), _defaultCellHeight);
	_needShowComboBox = NO;
    _pulldownButton.selected = NO;
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark custom event methods

- (void)pulldownButtonWasClicked:(UIButton *)sender {
    _needShowComboBox = !_needShowComboBox;
	if (_needShowComboBox) {
        [self showComboBox];
	}else {
		[self hideComboBox];
	}
}

#pragma mark --
#pragma mark -- UITableViewDatasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_comboBoxDatasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ListCellIdentifier";
	UITableViewCell *cell = [_comboBoxTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
                
	cell.textLabel.text = (NSString *)[_comboBoxDatasource objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return _defaultCellHeight;
}

#pragma mark --
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedItemIndex = indexPath.row;
    [self hideComboBox];
}

#pragma mark -
#pragma mark drawRect methods
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);
	CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 0.0f, 1.0f);
	if (_needShowComboBox ) {
		CGContextAddRect(context, CGRectMake(0.0f, 0.0f, self.frame.size.width, _defaultCellHeight * 6));
		
	}else {
		CGContextAddRect(context, CGRectMake(0.0f, 0.0f, self.frame.size.width, _defaultCellHeight));
	}
	CGContextDrawPath(context, kCGPathStroke);
	CGContextMoveToPoint(context, 0.0f, _defaultCellHeight);
	CGContextAddLineToPoint(context, self.frame.size.width, _defaultCellHeight);
	CGContextMoveToPoint(context, self.frame.size.width - _defaultCellHeight, 0);
	CGContextAddLineToPoint(context, self.frame.size.width - _defaultCellHeight, _defaultCellHeight);
	
	CGContextStrokePath(context);
}

@end
