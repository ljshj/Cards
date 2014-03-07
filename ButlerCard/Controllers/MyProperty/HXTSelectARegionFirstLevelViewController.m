//
//  HXTSelectARegionFirstLevelViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/6/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTSelectARegionFirstLevelViewController.h"

typedef NS_ENUM(NSUInteger, sectionType) {
    sectionTypeCurrentCity = 0,
    sectionTypeTopCities,
    sectionTypeProvinces
};

@interface HXTSelectARegionFirstLevelViewController ()
@property (strong, nonatomic) NSString     *currentCity;
@property (strong, nonatomic) NSArray      *topCities;
@property (strong, nonatomic) NSDictionary *provinces;
@end

@implementation HXTSelectARegionFirstLevelViewController

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
    
    _currentCity = @"成都";
    _topCities   = [[NSArray alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"hotCities" ofType:@"plist"]];
    _provinces   = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"provinces" ofType:@"plist"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
    [super viewWillDisappear:animated];
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
    if (section == sectionTypeCurrentCity) {
        return 1;
    } else if (section == sectionTypeTopCities) {
        return _topCities.count;
    } else if (section == sectionTypeProvinces) {
        return _provinces.allKeys.count;
    } else {
        NSLog(@"####Error%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, @"Wrong section");
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == sectionTypeCurrentCity) {
        return @"当前位置";
    } else if (section == sectionTypeTopCities) {
        return @"热门城市";
    } else if (section == sectionTypeProvinces) {
        return @"按省份选择城市";
    } else {
        NSLog(@"####Error%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, @"Wrong section");
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == sectionTypeCurrentCity) {
        static NSString *CellIdentifier = @"CurrentCityCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        cell.textLabel.text = _currentCity;
        return cell;
    } else if (indexPath.section == sectionTypeTopCities) {
        static NSString *CellIdentifier = @"TopCityCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        cell.textLabel.text = _topCities[indexPath.row];
        return cell;
    } else if (indexPath.section == sectionTypeProvinces) {
        static NSString *CellIdentifier = @"ProvinceCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        NSString *key = [NSString stringWithFormat:@"%d", indexPath.row];
        NSDictionary *province = _provinces[key];
        cell.textLabel.text = province.allKeys[0];
        return cell;
    } else {
        NSLog(@"####Error%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, @"Wrong indexPath.section");
        return nil;
    }
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 50;
//}

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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SelectARegionSecondLevelIdentifier"]) {
        NSLog(@"############# segue SelectARegionSecondLevelIdentifier");
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        if (selectedIndexPath.section == sectionTypeProvinces) {
            UIViewController *selectARegionSecondLevelViewController = segue.destinationViewController;
            NSString *key = [NSString stringWithFormat:@"%d", selectedIndexPath.row];
            NSDictionary *provinceWithIndex = _provinces[key];
            [selectARegionSecondLevelViewController setValue:provinceWithIndex[provinceWithIndex.allKeys[0]] forKey:@"province"];
        }
    }
}


@end
