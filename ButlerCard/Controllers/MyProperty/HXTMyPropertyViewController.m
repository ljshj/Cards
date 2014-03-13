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

@property (strong, nonatomic) NSMutableArray  *expandedIndexs;

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
    _expandedIndexs = [[NSMutableArray alloc] initWithCapacity:0];
    
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
    // Return the number of sections.
    return [HXTMyProperties sharedInstance].properties.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    for (NSNumber *expandedIndex in _expandedIndexs) {
        if (expandedIndex.intValue ==  section) {
            return 7;
        }
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PropertyServiceCellIdentifier    = @"PropertyServiceCellIdentifier";    //物业服务单元
    static NSString *ProtertyItemDetailCellIdentifier = @"ProtertyItemDetailCellIdentifier"; //详情单元
    static NSString *ProtertyItemBindCellIdentifier   = @"ProtertyItemBindCellIdentifier";   //绑定单元
    static NSString *PaymentCellIdentifier            = @"PaymentCellIdentifier";            //缴费单元
    
    HXTPropertyCell *property = [HXTMyProperties sharedInstance].properties[indexPath.section];
    
    switch (indexPath.row) {
        case 0: { //物业服务
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PropertyServiceCellIdentifier forIndexPath:indexPath];
            cell.contentView.tag = indexPath.section;
            
            BOOL isExpanded = NO;
            for (NSNumber *expandedIndex in _expandedIndexs) {
                if (expandedIndex.intValue ==  indexPath.section) {
                    isExpanded = YES;
                    break;
                }
            }
            
            UIView *button = [cell viewWithTag:104];
            if ([button isKindOfClass:[UIButton class]]) {
                ((UIButton *)button).selected = isExpanded ? YES : NO;
            }

            ((UILabel *)[cell viewWithTag:103]).text = [NSString stringWithFormat:@"%@ %li栋%li单元%li", property.house.housingEstatename, (long)property.house.buildingNo, (long)property.house.unitNo, (long)property.house.roomNo];
            return cell;
        }
            break;
        case 1: { //物管费
            if (property.propertyManagementFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"物管费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.propertyManagementFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"物管费";
                return cell;
            }
        }
            break;
        case 2: { //停车费
            if (property.parkingFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"停车费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.parkingFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"停车费";
                return cell;
            }
        }
            break;
        case 3: { //水费
            if (property.waterFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"水费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.waterFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"水费";
                return cell;
            }
        }
            break;
        case 4: { //电费
            if (property.electricityFees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"电费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.electricityFees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"电费";
                return cell;
            }
        }
            break;
        case 5: { //气费
            if (property.gasFrees.bindCard) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"气费";
                ((UILabel *)[cell viewWithTag:102]).text = [NSString stringWithFormat:@"%.2f", property.gasFrees.money];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                ((UILabel *)[cell viewWithTag:101]).text = @"气费";
                return cell;
            }
        }
            break;
        case 6: { //缴费按钮
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PaymentCellIdentifier forIndexPath:indexPath];
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
    
    BOOL needExpand = NO;
    for (NSNumber *expandedIndex in _expandedIndexs) {
        if (expandedIndex.intValue ==  tableViewHeaderFooterView.tag) {
            needExpand = YES;
            break;
        }
    }
    
    if (needExpand) {
        tableViewHeaderFooterView.expanded = YES;
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
    
    BOOL needExpand = NO;
    for (NSNumber *expandedIndex in _expandedIndexs) {
        if (expandedIndex.intValue ==  tableViewHeaderFooterView.tag) {
            needExpand = YES;
            break;
        }
    }
    
    if (needExpand) {
        tableViewHeaderFooterView.expanded = YES;
    }
    
    return tableViewHeaderFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 60;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - HXTPropertyTableViewHeaderFooterView Delegate

-(void)HXTPropertyTableViewHeaderFooterView:(HXTPropertyTableViewHeaderFooterView *)tableViewHeaderFooterView expanded:(BOOL)expanded{
    if (expanded) {
        NSLog(@"expanded! tableViewHeaderFooterView.tag = %ld", (long)tableViewHeaderFooterView.tag);
        [_expandedIndexs addObject:@(tableViewHeaderFooterView.tag)];
    }else {
        NSLog(@"not expanded! tableViewHeaderFooterView.tag = %ld", (long)tableViewHeaderFooterView.tag);
        for (NSNumber *expandedIndex in _expandedIndexs) {
            if (expandedIndex.intValue ==  tableViewHeaderFooterView.tag) {
                [_expandedIndexs removeObject:expandedIndex];
                break;
            }
        }
    }
    
    [self.tableView reloadData];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - UI actions

- (IBAction)showDetailButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    
//    UIView *view = sender;
//    while (view && ![view isKindOfClass:[UITableViewCell class]]) {
//        view = view.superview;
//    }
//    UITableViewCell *cell = (UITableViewCell *)view;
//    
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    
//    if (sender.selected) {
//        [_expandedIndexs addObject:@(indexPath.section)];
//    } else {
//        
//        for (NSNumber *expandedIndex in _expandedIndexs) {
//            if (expandedIndex.intValue ==  indexPath.section) {
//                [_expandedIndexs removeObject:expandedIndex];
//                break;
//            }
//        }
//    }
//    
//    [self.tableView reloadData];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


@end
