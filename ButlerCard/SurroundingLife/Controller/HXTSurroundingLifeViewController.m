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

typedef NS_ENUM(NSUInteger, DisplayGroup) {
    DisplayGroupIsNone = 0,
    DisplayGroupIsShowYouCome = 1,
    DisplayGroupIsIGo,
    DisplayGroupIsGroupTogether,
    DisplayGroupIsGoYou,
};

@interface HXTSurroundingLifeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *chooseCityLabel;
@property (weak, nonatomic) IBOutlet UIView *doorServiceAndBookedConsumptionView;
@property (weak, nonatomic) IBOutlet UIView *houseEstateInteractionAndsecondHandGoodsView;
@property (weak, nonatomic) IBOutlet UIView *extraFunctionsView;
@property (weak, nonatomic) IBOutlet HXTViewWithArrow *arrowView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (assign, nonatomic) DisplayGroup groupNeedDisplay;
@property (strong, nonatomic) NSArray *DisplayGroupItems;

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
    
    _DisplayGroupItems = @[@[@"杂货铺", @"外卖", @"维修",
                               @"家政", @"送水", @"开锁",
                               @"缝补", @"洗衣", @"鞋子",
                               @"快递", @"废品回收"],
                             @[@"餐饮", @"美容美发", @"宠物"],
                             @[@"拼车", @"拼饭", @"拼住",
                               @"三缺一", @"出游", @"其他"],
                             @[@"手机", @"小家电", @"家居",
                               @"书籍", @"电器", @"饰品",
                               @"二手车", @"其他"]];
    
    
    _groupNeedDisplay = DisplayGroupIsNone;
    
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
    return [_DisplayGroupItems[_groupNeedDisplay] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionViewCellIdentifier= @"CollectionViewCellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
    //    UIButton *cellButton = (UIButton *)[cell viewWithTag:100];
    UILabel  *cellLabel  = (UILabel *)[cell viewWithTag:100];
    cellLabel.text = _DisplayGroupItems[_groupNeedDisplay][indexPath.row];
    
    return cell;
}

#pragma -- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath indexPath.section = %li, indexPath.row = %li", (long)indexPath.section, (long)indexPath.row);
    switch (_groupNeedDisplay) {
        case DisplayGroupIsShowYouCome: {
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
- (IBAction)doorServiceButtonPressed:(id)sender {
    if (_groupNeedDisplay != DisplayGroupIsShowYouCome) {
        _groupNeedDisplay = DisplayGroupIsShowYouCome;
        UIButton *button = (UIButton *)sender;
        
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_collectionView reloadData];
        
        _arrowView.frame = CGRectMake(CGRectGetMinX(_arrowView.frame),
                                      CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                      CGRectGetWidth(_arrowView.frame),
                                      CGRectGetHeight(_arrowView.frame));
        _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                         CGRectGetMaxY(_arrowView.frame),
                                                                         CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                         CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
        _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                               CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                               CGRectGetWidth(_extraFunctionsView.frame),
                                               CGRectGetHeight(_extraFunctionsView.frame));
        
    }
}

//预定消费
- (IBAction)bookedConsumptionPressed:(id)sender {
    if (_groupNeedDisplay != DisplayGroupIsIGo) {
        _groupNeedDisplay = DisplayGroupIsIGo;
        UIButton *button = (UIButton *)sender;
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_collectionView reloadData];
        
        _arrowView.frame = CGRectMake(CGRectGetMinX(_arrowView.frame),
                                      CGRectGetMaxY(_doorServiceAndBookedConsumptionView.frame) ,
                                      CGRectGetWidth(_arrowView.frame),
                                      CGRectGetHeight(_arrowView.frame));
        _houseEstateInteractionAndsecondHandGoodsView.frame = CGRectMake(CGRectGetMinX(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                         CGRectGetMaxY(_arrowView.frame),
                                                                         CGRectGetWidth(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                                                         CGRectGetHeight(_houseEstateInteractionAndsecondHandGoodsView.frame));
        _extraFunctionsView.frame = CGRectMake(CGRectGetMinX(_extraFunctionsView.frame),
                                               CGRectGetMaxY(_houseEstateInteractionAndsecondHandGoodsView.frame),
                                               CGRectGetWidth(_extraFunctionsView.frame),
                                               CGRectGetHeight(_extraFunctionsView.frame));
    }
}

//小区互动
- (IBAction)houseEstateInteractionButtonPressed:(id)sender {
    if (_groupNeedDisplay != DisplayGroupIsGroupTogether) {
        _groupNeedDisplay = DisplayGroupIsGroupTogether;
        UIButton *button = (UIButton *)sender;
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_collectionView reloadData];
    }
}

//二手物品
- (IBAction)secondHandGoodsButtonPressed:(id)sender {
    if (_groupNeedDisplay != DisplayGroupIsGoYou) {
        _groupNeedDisplay = DisplayGroupIsGoYou;
        UIButton *button = (UIButton *)sender;
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_collectionView reloadData];
    }
}



@end
