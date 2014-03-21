//
//  HXTSurroundingLifeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTSurroundingLifeViewController.h"
#import "HXTAccountManager.h"
#import "HXTViewWithArrow.h"

#define kDurationTime 0.5f

typedef NS_ENUM(NSUInteger, FunctionsGroup) {
    
    FunctionsGroupIsDoorService = 0,
    FunctionsGroupIsBookedConsumption,
    FunctionsGroupIsHouseEstateInteraction,
    FunctionsGroupIsSecondHandGoods,
    FunctionsGroupIsNone = -1
};

@interface HXTSurroundingLifeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *chooseCityLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *doorServiceAndBookedConsumptionView;
@property (weak, nonatomic) IBOutlet UIView *houseEstateInteractionAndsecondHandGoodsView;
@property (weak, nonatomic) IBOutlet UIView *extraFunctionsView;
@property (weak, nonatomic) IBOutlet HXTViewWithArrow *subFunctionsArrowView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (assign, nonatomic) FunctionsGroup functionsGroupNeedDisplay;
@property (strong, nonatomic) NSArray *FunctionsGroupItems;

@end

@implementation HXTSurroundingLifeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    
    _FunctionsGroupItems = @[@[@"杂货铺", @"外卖", @"维修",
                               @"家政", @"送水", @"开锁",
                               @"缝补", @"洗衣", @"鞋子",
                               @"快递", @"废品回收"],
                             @[@"餐饮", @"美容美发", @"宠物"],
                             @[@"拼车", @"拼饭", @"拼住",
                               @"三缺一", @"出游", @"其他"],
                             @[@"手机", @"小家电", @"家居",
                               @"书籍", @"电器", @"饰品",
                               @"二手车", @"其他"]];
    
    
    _functionsGroupNeedDisplay = FunctionsGroupIsNone;
    _subFunctionsArrowView.hidden = YES;
    
    [[HXTAccountManager sharedInstance] addObserver:self
                                         forKeyPath:@"defaultHouseingEstate"
                                            options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                            context:NULL];
    if ([HXTAccountManager sharedInstance].defaultHouseingEstate) {
        _chooseCityLabel.text = [HXTAccountManager sharedInstance].defaultHouseingEstate;
    } else {
        _chooseCityLabel.text = @"选择小区";
    }
}

#pragma -- key value abserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"defaultHouseingEstate"] && object == [HXTAccountManager sharedInstance]) {
        if ([HXTAccountManager sharedInstance].defaultHouseingEstate) {
            _chooseCityLabel.text = [HXTAccountManager sharedInstance].defaultHouseingEstate;
        } else {
            _chooseCityLabel.text = @"选择小区";
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_functionsGroupNeedDisplay != FunctionsGroupIsNone) {
        return [_FunctionsGroupItems[_functionsGroupNeedDisplay] count];
    } else {
        return 0;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionViewCellIdentifier= @"CollectionViewCellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
    //    UIButton *cellButton = (UIButton *)[cell viewWithTag:100];
    UILabel  *cellLabel  = (UILabel *)[cell viewWithTag:100];
    cellLabel.text = _FunctionsGroupItems[_functionsGroupNeedDisplay][indexPath.row];
    
    return cell;
}

#pragma -- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath indexPath.section = %li, indexPath.row = %li", (long)indexPath.section, (long)indexPath.row);
    switch (_functionsGroupNeedDisplay) {
        case FunctionsGroupIsDoorService: {
            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TheGroceryStoreStoryboardID"];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -- UI Actions

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



//上门服务
- (IBAction)doorServiceButtonPressed:(UIButton *)sender {
    if (_functionsGroupNeedDisplay != FunctionsGroupIsDoorService) {
        
        _subFunctionsArrowView.hidden = NO;
        CGPoint lastRelativeOriginPoint = _subFunctionsArrowView.relativeOrigin;
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsDoorService];
        
        if (_functionsGroupNeedDisplay == FunctionsGroupIsBookedConsumption) {
            
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) + subFunctionsArrowViewHeight,
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 
                                 [_subFunctionsArrowView horizonMoveArrowFromX:lastRelativeOriginPoint.x toX:_subFunctionsArrowView.relativeOrigin.x];
                             }completion:^(BOOL finished){ }];

        } else {
            
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           12.0f);
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             }completion:^(BOOL finished){ }];
        }
        
         _functionsGroupNeedDisplay = FunctionsGroupIsDoorService;
        
    } else {
        
        _functionsGroupNeedDisplay = FunctionsGroupIsNone;
        [UIView animateWithDuration:kDurationTime
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       CGRectGetHeight(_subFunctionsArrowView.frame));
                             
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       0);
                             _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                              CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                             _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                    CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                    CGRectGetWidth(_extraFunctionsView.frame),
                                                                    CGRectGetHeight(_extraFunctionsView.frame));
                         }completion:^(BOOL finished){
                             _subFunctionsArrowView.hidden = YES;
                         }];
    }
}

//预定消费
- (IBAction)bookedConsumptionPressed:(UIButton *)sender {
    if (_functionsGroupNeedDisplay != FunctionsGroupIsBookedConsumption) {
        _subFunctionsArrowView.hidden = NO;
        CGPoint lastRelativeOriginPoint = _subFunctionsArrowView.relativeOrigin;
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsBookedConsumption];
        
        if (_functionsGroupNeedDisplay == FunctionsGroupIsDoorService) {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 
                                 [_subFunctionsArrowView horizonMoveArrowFromX:lastRelativeOriginPoint.x toX:_subFunctionsArrowView.relativeOrigin.x];
                                 
                             }completion:^(BOOL finished){ }];
        } else {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_subFunctionsArrowView setNeedsDisplay];
                                 [_collectionView reloadData];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           12.0f);
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             }completion:^(BOOL finished){ }];
        }
        _functionsGroupNeedDisplay = FunctionsGroupIsBookedConsumption;
    }else {
        _functionsGroupNeedDisplay = FunctionsGroupIsNone;
        [UIView animateWithDuration:kDurationTime
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       CGRectGetHeight(_subFunctionsArrowView.frame));
                             
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       0);
                             _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                                              CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                             _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                    CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                    CGRectGetWidth(_extraFunctionsView.frame),
                                                                    CGRectGetHeight(_extraFunctionsView.frame));
                         }completion:^(BOOL finished){
                             _subFunctionsArrowView.hidden = YES;
                         }];
    }
}

//小区互动
- (IBAction)houseEstateInteractionButtonPressed:(UIButton *)sender {
    if (_functionsGroupNeedDisplay != FunctionsGroupIsHouseEstateInteraction) {
        _subFunctionsArrowView.hidden = NO;
        CGPoint lastRelativeOriginPoint = _subFunctionsArrowView.relativeOrigin;
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsHouseEstateInteraction];
        if (_functionsGroupNeedDisplay == FunctionsGroupIsSecondHandGoods) {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 [_subFunctionsArrowView horizonMoveArrowFromX:lastRelativeOriginPoint.x toX:_subFunctionsArrowView.relativeOrigin.x];
                             } completion:^(BOOL finished){ }];
        } else {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 [_subFunctionsArrowView setNeedsDisplay];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           0.0f);
                                 
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             } completion:^(BOOL finished){ }];
        }
        _functionsGroupNeedDisplay = FunctionsGroupIsHouseEstateInteraction;
    }else {
        _functionsGroupNeedDisplay = FunctionsGroupIsNone;
        [UIView animateWithDuration:kDurationTime
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       CGRectGetHeight(_subFunctionsArrowView.frame));
                             
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       0);
                             _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame),
                                                                                              CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                             _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                    CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                    CGRectGetWidth(_extraFunctionsView.frame),
                                                                    CGRectGetHeight(_extraFunctionsView.frame));
                         }completion:^(BOOL finished){
                             _subFunctionsArrowView.hidden = YES;
                         }];
    }
}

//二手物品
- (IBAction)secondHandGoodsButtonPressed:(UIButton *)sender {
    if (_functionsGroupNeedDisplay != FunctionsGroupIsSecondHandGoods) {
        _subFunctionsArrowView.hidden = NO;
        CGPoint lastRelativeOriginPoint = _subFunctionsArrowView.relativeOrigin;
        _subFunctionsArrowView.relativeOrigin = [sender convertPoint:CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame)) toView:self.view];
        NSUInteger subFunctionsArrowViewHeight = [self caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:FunctionsGroupIsSecondHandGoods];
        if (_functionsGroupNeedDisplay == FunctionsGroupIsHouseEstateInteraction) {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                                 [_subFunctionsArrowView horizonMoveArrowFromX:lastRelativeOriginPoint.x toX:_subFunctionsArrowView.relativeOrigin.x];
                             } completion:^(BOOL finished){
                             }];
        } else {
            [UIView animateWithDuration:kDurationTime
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_collectionView reloadData];
                                 [_subFunctionsArrowView setNeedsDisplay];
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                           0.0f);
                                 
                                 _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame),
                                                                                                  CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                                  CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                                 
                                 _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                           CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                           CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                          subFunctionsArrowViewHeight);
                                 _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                        CGRectGetMaxY(_subFunctionsArrowView.frame),
                                                                        CGRectGetWidth(_extraFunctionsView.frame),
                                                                        CGRectGetHeight(_extraFunctionsView.frame));
                             } completion:^(BOOL finished){ }];
        }
        _functionsGroupNeedDisplay = FunctionsGroupIsSecondHandGoods;
    }else {
        _functionsGroupNeedDisplay = FunctionsGroupIsNone;
        [UIView animateWithDuration:kDurationTime
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       CGRectGetHeight(_subFunctionsArrowView.frame));
                             
                             _subFunctionsArrowView.frame = CGRectMake(CGRectGetMinX(_subFunctionsArrowView.frame),
                                                                       CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame) ,
                                                                       CGRectGetWidth(_subFunctionsArrowView.frame),
                                                                       0);
                             _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame),
                                                                                              CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                                              CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
                             _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                                                    CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                    CGRectGetWidth(_extraFunctionsView.frame),
                                                                    CGRectGetHeight(_extraFunctionsView.frame));
                         }completion:^(BOOL finished){
                             _subFunctionsArrowView.hidden = YES;
                         }];
    }
}

#pragma mark -- local functions

- (NSUInteger)caculateSubFunctionsArrowViewHeightThroughFunctionsGroup:(FunctionsGroup)group {
    
    NSUInteger numberOfItems = [_FunctionsGroupItems[group] count];
    
    float rowTemp = numberOfItems / 3.0;
    NSUInteger row = (fabs(rowTemp - (NSUInteger)rowTemp) < 0.001) ? rowTemp : (NSUInteger)rowTemp + 1;
    
    return row * 40 + 12;;
}

@end
