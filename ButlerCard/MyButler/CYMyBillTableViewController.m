//
//  CYMyBillTableViewController.m
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYMyBillTableViewController.h"
#import "CYMyBillMonthCell.h"
#import "CYMyBillDetailCell.h"

@interface CYMyBillTableViewController ()

@end

@implementation CYMyBillTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _dataDic = [[NSMutableDictionary alloc]initWithObjects:@[@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"]]forKeys:@[@"1月",@"2月"]];
//    NSLog(@"_dataDic = %@",_dataDic);
    _dataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],nil];
    NSLog(@"_dataArray == %@",_dataArray);

    NSLog(@"_dataArray.count == %d",_dataArray.count);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSMutableArray *tempArray = _dataArray[section];
    return tempArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView registerClass:[CYMyBillMonthCell class] forCellReuseIdentifier:@"CYMyBillMonthCell"];
    [self.tableView registerClass:[CYMyBillDetailCell class] forCellReuseIdentifier:@"CYMyBillDetailCell"];
    
    CYMyBillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyBillDetailCell" forIndexPath:indexPath];

    // Configure the cell...
    if (indexPath.section == 0)
    {
        cell.backgroundColor = [UIColor greenColor];
        if (indexPath.row == 0)
        {
            CYMyBillMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyBillMonthCell" forIndexPath:indexPath];
            NSString *tempString = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][indexPath.row]];
            [cell.timeLable setText:tempString];
            return cell;
        }
        else
        {
            CYMyBillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyBillDetailCell" forIndexPath:indexPath];
            [cell.titleLable setText:@"123"];
            return cell;
        }
    }
    else
    {
        cell.backgroundColor = [UIColor redColor];

    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
