//
//  HXTMyPropertyViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTMyPropertyViewController.h"
#import "HXTPropertyTableViewHeaderFooterView.h"
#import "HXTMyProperties.h"

#define kHeaderFooterViewReuseIdentifier @"HeaderFooterViewReuseIdentifier"

@interface HXTMyPropertyViewController () <HXTPropertyTableViewHeaderFooterViewDelegate>

@property (assign, nonatomic) NSInteger expandedSection;
@property (strong, nonatomic) NSArray *freeNames;

@end

@implementation HXTMyPropertyViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPropertyTableViewHeaderFooterView" bundle:[NSBundle mainBundle]]forHeaderFooterViewReuseIdentifier:kHeaderFooterViewReuseIdentifier];
    
    _expandedSection = -1;
    _freeNames = @[@"未知费用", @"物管费", @"停车费", @"水费", @"电费", @"气费",];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [HXTMyProperties sharedInstance].properties.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_expandedSection == section) {
        HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[section];
        return property.fees.count + 1; //计算功能行
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ProtertyItemDetailCellIdentifier = @"ProtertyItemDetailCellIdentifier"; //详情单元
    static NSString *FunctionCellIdentifier           = @"FunctionCellIdentifier";           //功能单元
    
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[indexPath.section];
    if (indexPath.row < property.fees.count) { //详情单元
        HXTPropertyFeeCell *feeCell = property.fees[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
        ((UILabel *)[cell viewWithTag:101]).text = _freeNames[feeCell.freeType];
        
        NSDateFormatter *df  = [[NSDateFormatter alloc] init];
        [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [df setDateFormat:@"YYYY年MM月d日"];
        ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"截止%@", [df stringFromDate:feeCell.deadline]];
        ((UILabel *)[cell viewWithTag:103]).text = [NSString stringWithFormat:@"%.2f", feeCell.money];
        return cell;
    } else if (indexPath.row == property.fees.count) { //功能单元
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FunctionCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        NSLog(@"Error##############%s %s %d Wrong indexPath!!!", __FILE__, __FUNCTION__, __LINE__);
        return nil;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    HXTPropertyTableViewHeaderFooterView *tableViewHeaderFooterView = (HXTPropertyTableViewHeaderFooterView *)[tableView headerViewForSection:section];
    tableViewHeaderFooterView.tag = section;
    
    //设置Header显示小区地址
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[section];
    UILabel *label = (UILabel *)[tableViewHeaderFooterView viewWithTag:103];
    label.text = [NSString stringWithFormat:@"%@ %li栋%li单元%li", property.house.housingEstatename, (long)property.house.buildingNo, (long)property.house.unitNo, (long)property.house.roomNo];
    
    if (_expandedSection == tableViewHeaderFooterView.tag) {
        tableViewHeaderFooterView.expanded = YES;
    } else {
        tableViewHeaderFooterView.expanded = NO;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HXTPropertyTableViewHeaderFooterView *tableViewHeaderFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderFooterViewReuseIdentifier];
    tableViewHeaderFooterView.delegate = self;
    tableViewHeaderFooterView.tag = section;
    
    //设置Header显示小区地址
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[section];
    UILabel *label = (UILabel *)[tableViewHeaderFooterView viewWithTag:103];
    label.text = [NSString stringWithFormat:@"%@ %li栋%li单元%li", property.house.housingEstatename, (long)property.house.buildingNo, (long)property.house.unitNo, (long)property.house.roomNo];
    
    if (_expandedSection == tableViewHeaderFooterView.tag) {
        tableViewHeaderFooterView.expanded = YES;
    } else {
        tableViewHeaderFooterView.expanded = NO;
    }
    
    return tableViewHeaderFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 5) {
        return 44;
    } else {
        return 148;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - HXTPropertyTableViewHeaderFooterView Delegate

-(void)HXTPropertyTableViewHeaderFooterView:(HXTPropertyTableViewHeaderFooterView *)tableViewHeaderFooterView expanded:(BOOL)expanded{
    
    if (expanded) {
        NSInteger lastExpandedSection = _expandedSection;
        _expandedSection = tableViewHeaderFooterView.tag;
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
        if (lastExpandedSection != -1) {
            [indexSet addIndex:lastExpandedSection];
        }
        [indexSet addIndex:_expandedSection];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        _expandedSection = -1;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tableViewHeaderFooterView.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(void)HXTPropertyTableViewHeaderFooterView:(HXTPropertyTableViewHeaderFooterView *)tableViewHeaderFooterView ApplyPropertyService:(BOOL)apply {
    UIViewController *propertyServiceViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertyServiceStoryboardID"];
    [self.navigationController pushViewController:propertyServiceViewController animated:YES];
}

#pragma mark - UI actions


@end
