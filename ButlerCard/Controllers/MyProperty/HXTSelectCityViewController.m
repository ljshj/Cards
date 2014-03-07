//
//  HXTSelectCityViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/6/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTSelectCityViewController.h"
#import "HXTAccountManager.h"

typedef NS_ENUM(NSUInteger, sectionType) {
    sectionTypeCurrentCity = 0,
    sectionTypeTopCities,
    sectionTypeProvinces
};

@interface HXTSelectCityViewController ()
@property (copy  , nonatomic) NSString     *currentCity;
@property (strong, nonatomic) NSArray      *topCities;
@property (strong, nonatomic) NSDictionary *provinces;

@property (strong, nonatomic) NSDictionary *selectedProvince;
@property (weak  , nonatomic) UITableViewController *selectCitySecondLevelViewController;
@end

@implementation HXTSelectCityViewController

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
    
    _currentCity = [HXTAccountManager sharedInstance].currentCity;
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
    if (tableView == self.tableView) {
        return 3;
    } else { // _selectCitySecondLevelViewController.tableView
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.tableView) {
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
    } else { // _selectCitySecondLevelViewController.tableView
        return _selectedProvince.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (section == sectionTypeCurrentCity) {
            return @"当前位置";
        } else if (section == sectionTypeTopCities) {
            return @"热门城市";
        } else if (section == sectionTypeProvinces) {
            return @"按省份选择城市";
        } else {
            NSLog(@"####Error%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, @"Wrong section");
            return nil;
        }
    } else { // _selectCitySecondLevelViewController.tableView
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
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
    } else { // _selectCitySecondLevelViewController.tableView
        static NSString *CellIdentifier = @"CityCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        NSString *key = [NSString stringWithFormat:@"%d", indexPath.row];
        NSDictionary *city = _selectedProvince[key];
        cell.textLabel.text = city.allKeys[0];
        return cell;
    }
}

#pragma mark --
#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 35;
    } else { // _selectCitySecondLevelViewController.tableView
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == self.tableView) {
        if (indexPath.section == sectionTypeCurrentCity) {
            [HXTAccountManager sharedInstance].currentCity = _currentCity;
            [self.navigationController popViewControllerAnimated:YES];
        } else if (indexPath.section == sectionTypeTopCities) {
            [HXTAccountManager sharedInstance].currentCity = _topCities[indexPath.row];
            [self.navigationController popViewControllerAnimated:YES];
        } else if (indexPath.section == sectionTypeProvinces) {
           ;
        } else {
            NSLog(@"####Error%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, @"Wrong indexPath.section");
        }
    } else { // _selectCitySecondLevelViewController.tableView
        if (_selectCitySecondLevelViewController) {
            NSString *key = [NSString stringWithFormat:@"%d", indexPath.row];
            NSDictionary *city = _selectedProvince[key];
            [HXTAccountManager sharedInstance].currentCity = city.allKeys[0];;
            
            [_selectCitySecondLevelViewController.navigationController popViewControllerAnimated:NO];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark --
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SelectARegionSecondLevelIdentifier"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        if (selectedIndexPath.section == sectionTypeProvinces) {
            _selectCitySecondLevelViewController = segue.destinationViewController;
            NSString *key = [NSString stringWithFormat:@"%d", selectedIndexPath.row];
            NSDictionary *provinceWithIndex = _provinces[key];
            _selectedProvince = provinceWithIndex[provinceWithIndex.allKeys[0]];
            
            // Set _selectCitySecondLevelViewController.tableView.delegate to self
            [segue.destinationViewController setValue:self forKeyPath:@"self.tableView.delegate"];
            
            // Set _selectCitySecondLevelViewController.tableView.dataSource to self
            [segue.destinationViewController setValue:self forKeyPath:@"self.tableView.dataSource"];
        }
    }
}


@end
