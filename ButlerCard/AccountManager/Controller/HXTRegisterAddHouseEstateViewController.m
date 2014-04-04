//
//  HXTRegisterAddHouseEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterAddHouseEstateViewController.h"
#import "HXTAddHouseViewController.h"

@interface HXTRegisterAddHouseEstateViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *houseEstateTableView;

@property (strong, nonatomic) NSMutableArray *willAddedhouseEstates;
@end

@implementation HXTRegisterAddHouseEstateViewController

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
    _willAddedhouseEstates = [NSMutableArray arrayWithArray:@[@"中铁小区 1栋2单元302", @"广都小区 1栋2单元302"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSelector:) name:kAddHouseNotification object:nil];
}

- (void)notificationSelector:(NSNotification *)notification {
    
    if (notification.object != self && [notification.name isEqualToString:kAddHouseNotification]) {
        NSLog(@"22notification.userInfo = %@", notification.userInfo);
        NSString *houseEetateName = notification.userInfo[kHouseEstateName];
        NSUInteger buildingNo = [notification.userInfo[kBuildingNo] unsignedIntegerValue];
        NSUInteger unitNo = [notification.userInfo[kUnitNo] unsignedIntegerValue];
        NSUInteger houseNo = [notification.userInfo[kHouseNo] unsignedIntegerValue];
        NSString *houseString = [NSString stringWithFormat:@"%@ %lu栋%lu单元%lu", houseEetateName, (long)buildingNo, (long)unitNo, (long)houseNo];
        [_willAddedhouseEstates  addObject:houseString];
        
        [_houseEstateTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table View dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _willAddedhouseEstates.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *houseEstateCellIdentifier = @"HouseEstateCellIdentifier";
    static NSString *RegisterCellIdentifer = @"RegisterCellIdentifer";
    
    if (indexPath.row < _willAddedhouseEstates.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:houseEstateCellIdentifier forIndexPath:indexPath];
        //        cell.textLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1];
        //        cell.textLabel.font = [UIFont systemFontOfSize:15];
        //        cell.textLabel.text = _willAddedhouseEstates[indexPath.row];
        
        ((UILabel *)[cell viewWithTag:101]).text = _willAddedhouseEstates[indexPath.row];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RegisterCellIdentifer forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}


#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _willAddedhouseEstates.count) {
        return 40;
    } else {
        return 84;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 40.0f)];
    headerView.backgroundColor = [UIColor colorWithWhite:241.0f / 255.0f alpha:1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300.0f, 20.0f)];
    [headerView addSubview:label];
    
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithWhite:156.0f / 255 alpha:1];
    label.text = @"添加小区后可以使用物业社区服务及相关配送功能";
    
    return headerView;
}

#pragma mark - UI Actions

- (IBAction)registerButtonPressed:(id)sender {
    NSLog(@"注册 navigationController.viewControllers.count = %lu", (long)self.navigationController.viewControllers.count);
    
    if (self.navigationController.viewControllers.count > 5) { //其他Controller通过导航控制器进入该页面
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else { //使用的模态方式进入改页面
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (IBAction)addHouseEstateButtonPressed:(id)sender {
    NSLog(@"添加小区");
    
    UIViewController * addHouseEstateNavViewController = [[UIStoryboard storyboardWithName:@"AddHouseEstate" bundle:nil] instantiateViewControllerWithIdentifier:@"AddHouseEstateNavStoryboardID"];
    [self presentViewController:addHouseEstateNavViewController animated:YES completion:^{}];
    
}

- (IBAction)delHouseEstateButtonPressed:(UIButton *)sender {
    
    UIView *view = sender.superview;
    
    while (view && view.superview) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [_houseEstateTableView indexPathForCell:(UITableViewCell *)view];
            [_willAddedhouseEstates removeObjectAtIndex:indexPath.row];
            [_houseEstateTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            return;
        }
        
        view = view.superview;
    }
}

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
