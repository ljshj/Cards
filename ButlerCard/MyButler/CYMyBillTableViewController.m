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
    _allDataArray = [[NSMutableArray alloc]initWithObjects:@[@"1月",@"香皂",@"洗面奶"],@[@"2月",@"杀虫剂"],nil];

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
    if (indexPath.row == 0)
    {
        //月份cell高度
        return 30.0;

    }
    else
    {
        //消费清单cell高度
        return 80.0;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView registerClass:[CYMyBillMonthCell class] forCellReuseIdentifier:@"CYMyBillMonthCell"];
    [self.tableView registerClass:[CYMyBillDetailCell class] forCellReuseIdentifier:@"CYMyBillDetailCell"];
    // Configure the cell...
    if (indexPath.row == 0)
    {
        CYMyBillMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyBillMonthCell" forIndexPath:indexPath];
        NSString *tempString = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][indexPath.row]];
        [cell.timeLable setText:tempString];
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    }
    else
    {
        CYMyBillDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyBillDetailCell" forIndexPath:indexPath];
        NSString *tempString = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][indexPath.row]];
        [cell.titleLable setText:tempString];
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //点击的如果是月份cell  row == 0  则触发折叠功能
    if (indexPath.row == 0)
    {
        NSArray *dataArrayAtSection = _dataArray[indexPath.section];
        NSArray *allDataArrayAtSection = _allDataArray[indexPath.section];
//        NSLog(@"section == %d",indexPath.section);
//        NSLog(@"dataArrayAtSection.count == %d",dataArrayAtSection.count);
//        NSLog(@"allDataArrayAtSection.count == %d",allDataArrayAtSection.count);
        //折叠的情况
        if (dataArrayAtSection.count == allDataArrayAtSection.count)
        {
//            NSLog(@"折叠！");
            NSMutableArray *tempArray = [[NSMutableArray alloc]initWithObjects:_dataArray[indexPath.section][indexPath.row], nil];
            _dataArray[indexPath.section] = tempArray;
//            NSLog(@"_dataArray == %@",_dataArray);
//            NSLog(@"_dataArray.count == %d",_dataArray.count);
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
        //展开的情况
        else
        {
//            NSLog(@"展开！");
            _dataArray[indexPath.section] = _allDataArray[indexPath.section];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }
    }

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
