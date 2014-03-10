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

#pragma mark --
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
            return cell;
            break;
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemDetailCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProtertyItemBindCellIdentifier forIndexPath:indexPath];
            return cell;
            break;
        }
        default:
            break;
    }
    
    return nil;
}

#pragma mark --
#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 5;
}

@end
