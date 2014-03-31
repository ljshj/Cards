//
//  HXTRegisterAddHouseEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterAddHouseEstateViewController.h"

@interface HXTRegisterAddHouseEstateViewController () <UITableViewDelegate, UITableViewDataSource>

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
    _willAddedhouseEstates = [NSMutableArray arrayWithArray:@[@"中铁小区 1栋2单元302"]];
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
    
    static NSString *houseEstateCellIdentifier = @"houseEstateCellIdentifier";
    static NSString *RegisterCellIdentifer = @"RegisterCellIdentifer";
    
    if (indexPath.row < _willAddedhouseEstates.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:houseEstateCellIdentifier forIndexPath:indexPath];
        
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
        return 44;
    } else {
        return 84;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320.0f, 20.0f)];
    label.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    label.text = @"添加小区后可以使用物业社区服务及相关配送功能";
    
    return label;
}

#pragma mark - UI Actions

- (IBAction)addMoreHouseEstateButtonPressed:(id)sender {
    
}

- (IBAction)registerButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
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

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
