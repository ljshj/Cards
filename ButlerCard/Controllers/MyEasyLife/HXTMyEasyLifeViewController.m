//
//  HXTMyEasyLifeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTMyEasyLifeViewController.h"
#import "ComboBoxView.h"
#import "HXTViewWithArrow.h"

typedef NS_ENUM(NSUInteger, DisplayGroup) {
    DisplayGroupIsShowYouCome = 0,
    DisplayGroupIsIGo,
    DisplayGroupIsGroupTogether,
    DisplayGroupIsGoYou,
};

@interface HXTMyEasyLifeViewController ()

@property (weak, nonatomic) IBOutlet ComboBoxView *dropDownComboBoxView;
@property (weak, nonatomic) IBOutlet UIButton *youComeButton;
@property (weak, nonatomic) IBOutlet UIButton *iGoButton;
@property (weak, nonatomic) IBOutlet UIButton *groupTogetherButton;
@property (weak, nonatomic) IBOutlet UIButton *secondHandButton;
@property (weak, nonatomic) IBOutlet HXTViewWithArrow *arrowView;
@property (weak, nonatomic) IBOutlet UICollectionView *iWantCollectionView;

@property (assign, nonatomic) DisplayGroup groupNeedDisplay;
@property (strong, nonatomic) NSArray *DisplayGroupItems;

@end

@implementation HXTMyEasyLifeViewController

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
    
    NSArray *comboBoxDatasource = @[@"中铁八局", @"万科A小区", @"置信A区", @"华润AA"];
    _dropDownComboBoxView.comboBoxDatasource = comboBoxDatasource;
	_dropDownComboBoxView.backgroundColor = [UIColor whiteColor];
    _dropDownComboBoxView.selectedItemIndex = 0;
    
    _groupNeedDisplay = DisplayGroupIsShowYouCome;
    _arrowView.relativeOrigin = CGPointMake(_youComeButton.frame.origin.x + _youComeButton.frame.size.width / 2,
                                            _youComeButton.frame.origin.y + _youComeButton.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --
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

#pragma --
#pragma -- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath indexPath.section = %i, indexPath.row = %d", indexPath.section, indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma --
#pragma -- Button presssed methords
- (IBAction)youComeButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    if (_groupNeedDisplay != DisplayGroupIsShowYouCome) {
        _groupNeedDisplay = DisplayGroupIsShowYouCome;
        UIButton *button = (UIButton *)sender;
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_iWantCollectionView reloadData];
    }
}

- (IBAction)iGoButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    if (_groupNeedDisplay != DisplayGroupIsIGo) {
        _groupNeedDisplay = DisplayGroupIsIGo;
        UIButton *button = (UIButton *)sender;
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_iWantCollectionView reloadData];
    }
}

- (IBAction)groupTogetherButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    if (_groupNeedDisplay != DisplayGroupIsGroupTogether) {
        _groupNeedDisplay = DisplayGroupIsGroupTogether;
        UIButton *button = (UIButton *)sender;
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_iWantCollectionView reloadData];
    }
}

- (IBAction)goYouButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    if (_groupNeedDisplay != DisplayGroupIsGoYou) {
        _groupNeedDisplay = DisplayGroupIsGoYou;
        UIButton *button = (UIButton *)sender;
        _arrowView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
        [_arrowView setNeedsDisplay];
        [_iWantCollectionView reloadData];
    }
}

@end
