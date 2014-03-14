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
    
    _expandedSection = -1;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPropertyTableViewHeaderFooterView" bundle:[NSBundle mainBundle]]forHeaderFooterViewReuseIdentifier:kHeaderFooterViewReuseIdentifier];
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
        return 6;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ProtertyItemDetailCellIdentifier = @"ProtertyItemDetailCellIdentifier"; //详情单元
    static NSString *FunctionCellIdentifier            = @"FunctionCellIdentifier";           //缴费单元
    
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[indexPath.section];
    
    switch (indexPath.row) {
        case 0: { //物管费
            if (property.propertyManagementFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"物管费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.propertyManagementFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"物管费";
                return cell;
            }
        }
            break;
        case 1: { //停车费
            if (property.parkingFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"停车费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.parkingFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"停车费";
                return cell;
            }
        }
            break;
        case 2: { //水费
            if (property.waterFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"水费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.waterFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"水费";
                return cell;
            }
        }
            break;
        case 3: { //电费
            if (property.electricityFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"电费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.electricityFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"电费";
                return cell;
            }
        }
            break;
        case 4: { //气费
            if (property.gasFrees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"气费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.gasFrees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"气费";
                return cell;
            }
        }
            break;
        case 5: { //缴费按钮
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FunctionCellIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
            
        default:
            NSLog(@"Error##############%s %s %d Wrong indexPath!!!", __FILE__, __FUNCTION__, __LINE__);
            return nil;
            break;
    }
    
    return  nil;
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
