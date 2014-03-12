//
//  HXTMyPropertyViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTMyPropertyViewController.h"
#import "HXTMyProperties.h"

@interface HXTMyPropertyViewController ()

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
    for (NSNumber *index in _expandedIndexs) {
        if (index.intValue ==  section) {
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
            
            ((UILabel *)[cell viewWithTag:103]).text = [NSString stringWithFormat:@"%@ %li栋%li单元%li", property.house.housingEstatename, property.house.buildingNo, property.house.unitNo, property.house.roomNo];
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
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case 3: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case 4: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case 5: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case 6: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PaymentCellIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
            
        default:
            NSLog(@"Error##############%s %s %d Wrong indexPath!!!", __FILE__, __FUNCTION__, __LINE__);
            return nil;
            break;
    }
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 60;
    } else {
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

#pragma mark - UI actions

- (IBAction)showDetailButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    UIView *view = sender;
    while (view != nil && ![view isKindOfClass:[UITableViewCell class]]) {
        view = view.superview;
    }
    UITableViewCell *cell = (UITableViewCell *)view;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (sender.selected) {
        [_expandedIndexs addObject:@(indexPath.section)];
    } else {
        
        for (NSNumber *index in _expandedIndexs) {
            if (index.intValue ==  indexPath.section) {
                [_expandedIndexs removeObject:index];
                break;
            }
        }
    }
    
    [self.tableView reloadData];
}


@end
