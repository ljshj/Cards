//
//  HXTMyPropertyBillViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTMyPropertyBillViewController.h"

@interface HXTMyPropertyBillViewController ()

@end

@implementation HXTMyPropertyBillViewController

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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 3;
            break;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PropertyServiceCellIdentifier    = @"PropertyServiceCellIdentifier";
    static NSString *ProtertyItemDetailCellIdentifier = @"ProtertyItemDetailCellIdentifier";
    static NSString *ProtertyItemBindCellIdentifier   = @"ProtertyItemBindCellIdentifier";
    
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PropertyServiceCellIdentifier forIndexPath:indexPath];
            
            //显示小区名称及地址
            UILabel *label = (UILabel *)[cell viewWithTag:102];
            label.text = [NSString stringWithFormat:@"%@ %ld栋%ld单元%ld", _propertyCell.house.housingEstatename, (unsigned long)_propertyCell.house.buildingNo, (unsigned long)_propertyCell.house.unitNo, (unsigned long)_propertyCell.house.roomNo];
            return cell;
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: { // 物管费
                    if (_propertyCell.propertyManagementFees.bindCard) {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:201];
                        feesNameLabel.text = @"物管费";
                        
                        UILabel *moneyLabel = (UILabel *)[cell viewWithTag:202];
                        moneyLabel.text = [NSString stringWithFormat:@"%.2f", _propertyCell.propertyManagementFees.money];
                        return cell;
                    } else {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:301];
                        feesNameLabel.text = @"物管费";
                        return cell;
                    }
                    break;
                }
                case 1: { //停车费
                    if (_propertyCell.parkingFees.bindCard) {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:201];
                        feesNameLabel.text = @"停车费";
                        
                        UILabel *moneyLabel = (UILabel *)[cell viewWithTag:202];
                        moneyLabel.text = [NSString stringWithFormat:@"%.2f", _propertyCell.parkingFees.money];
                        return cell;
                    } else {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:301];
                        feesNameLabel.text = @"停车费";
                        return cell;
                    }
                    break;
                }
                default:
                    return nil;
                    break;
            }
            break;
        }
        case 2:{
            switch (indexPath.row) {
                case 0: { // 水费
                    if (_propertyCell.waterFees.bindCard) {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:201];
                        feesNameLabel.text = @"水费";
                        
                        UILabel *moneyLabel = (UILabel *)[cell viewWithTag:202];
                        moneyLabel.text = [NSString stringWithFormat:@"%.2f", _propertyCell.waterFees.money];
                        return cell;
                    } else {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:301];
                        feesNameLabel.text = @"水费";
                        return cell;
                    }
                    break;
                }
                case 1: { //电费
                    if (_propertyCell.electricityFees.bindCard) {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:201];
                        feesNameLabel.text = @"电费";
                        
                        UILabel *moneyLabel = (UILabel *)[cell viewWithTag:202];
                        moneyLabel.text = [NSString stringWithFormat:@"%.2f", _propertyCell.electricityFees.money];
                        return cell;
                    } else {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:301];
                        feesNameLabel.text = @"电费";
                        return cell;
                    }
                    break;
                }
                case 2: { //气费
                    if (_propertyCell.gasFrees.bindCard) {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:201];
                        feesNameLabel.text = @"气费";
                        
                        UILabel *moneyLabel = (UILabel *)[cell viewWithTag:202];
                        moneyLabel.text = [NSString stringWithFormat:@"%.2f", _propertyCell.gasFrees.money];
                        return cell;
                    } else {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
                        UILabel *feesNameLabel = (UILabel *)[cell viewWithTag:301];
                        feesNameLabel.text = @"气费";
                        return cell;
                    }
                    break;
                }
                default:
                    return nil;
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 5;
}

@end
