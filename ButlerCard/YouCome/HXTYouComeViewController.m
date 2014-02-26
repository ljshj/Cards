//
//  HXTYouComeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTYouComeViewController.h"

#define kGroceryStoreStoryboardSegue @"GroceryStoreStoryboardSegue"
#define kTakeawayStoryboardSegue     @"TakeawayStoryboardSegue"
#define kRepairStoryboardSegue       @"RepairStoryboardSegue"
#define kDomesticServiceStoryboardSegue @"DomesticServiceStoryboardSegue"
#define kSendWaterStoryboardSegue    @"SendWaterStoryboardSegue"
#define kUnlockingStoryboardSegue    @"UnlockingStoryboardSegue"
#define kDarnStoryboadSegue          @"DarnStoryboadSegue"
#define kWashClothesStoryboardSegue  @"WashClothesStoryboardSegue"
#define kShoesStoryboardSegue        @"ShoesStoryboardSegue"
#define kExpressStoryboardSegue      @"ExpressStoryboardSegue"
#define kWasteRecyclingStoryboardSegue @"WasteRecyclingStoryboardSegue"

@interface HXTYouComeViewController ()
@property (strong, nonatomic) NSDictionary* segueType;
@end

@implementation HXTYouComeViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _segueType = @{kGroceryStoreStoryboardSegue:    @"杂货铺",
                   kTakeawayStoryboardSegue:        @"外卖",
                   kRepairStoryboardSegue:          @"维修",
                   kDomesticServiceStoryboardSegue: @"家政",
                   kSendWaterStoryboardSegue:       @"送水",
                   kUnlockingStoryboardSegue:       @"开锁",
                   kDarnStoryboadSegue:             @"缝补",
                   kWashClothesStoryboardSegue:     @"洗衣",
                   kShoesStoryboardSegue:           @"鞋",
                   kExpressStoryboardSegue:         @"快递",
                   kWasteRecyclingStoryboardSegue:  @"废品回收"};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destViewController = segue.destinationViewController;
    destViewController.navigationItem.title = _segueType[segue.identifier];
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
