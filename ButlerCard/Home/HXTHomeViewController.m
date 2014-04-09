//
//  HXTHomeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTHomeViewController.h"
#import "UIDevice+Resolutions.h"
#import "HXTAccountManager.h"

@interface HXTHomeViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *propertyServiceButton;
@property (weak, nonatomic) IBOutlet UIButton *propertyFeeButton;
@property (weak, nonatomic) IBOutlet UIButton *myFinancesButton;
@property (weak, nonatomic) IBOutlet UIButton *ecologicalDistributionButton;
@property (weak, nonatomic) IBOutlet UIButton *surroundingLifeButton;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@end

@implementation HXTHomeViewController

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
    
    self.navigationController.delegate = self;
    //    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _propertyServiceButton.selected = NO;
    _propertyFeeButton.selected = NO;
    _myFinancesButton.selected = NO;
    _ecologicalDistributionButton.selected = NO;
    _surroundingLifeButton.selected = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self) {
        //        self.navigationController.navigationBarHidden = YES;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *messageGreenCellIdentifier = @"MessageGreenCellIdentifier";
    static NSString *messageRedCellIdentifier = @"MessageRedCellIdentifier";
    
    if (indexPath.row % 2 ) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageRedCellIdentifier forIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageGreenCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - Table view delegate



#pragma mark -- UI actions
- (IBAction)chooseHouseEstateButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"选择小区");
}

//物管服务
- (IBAction)propertyServiceButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"物业服务 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

//物业缴费
- (IBAction)propertyFeeButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"物业缴费 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    
    if ([[HXTAccountManager sharedInstance] isLogged]) { //已登录，进入用户账单界面
        UITableViewController *myPropertyViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"MyPropertiesStoryboardID"];
        
        [self.navigationController pushViewController:myPropertyViewController animated:YES];
    } else { //没有登录，进入浏览小区界面
        
        UIViewController * browseHouseEstateViewController = [[UIStoryboard storyboardWithName:@"BrowseHouseEstate" bundle:nil] instantiateViewControllerWithIdentifier:@"BrowseHouseEstateStoryboardID"];
        
        [self.navigationController pushViewController:browseHouseEstateViewController animated:YES];
    }
}

//我的理财
- (IBAction)myFinancesButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"我的理财 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

//生态配送
- (IBAction)ecologicalDistributionButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"生态配送 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *ecologicalDistributionViewcontroller = [[UIStoryboard storyboardWithName:@"EcologicalDistribution" bundle:nil] instantiateViewControllerWithIdentifier:@"EcologicalDistributionStoryboardID"];
    [self.navigationController pushViewController:ecologicalDistributionViewcontroller animated:YES];
}

//周边生活
- (IBAction)surroundingLifeButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"周边生活 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *surroundingLifeViewcontroller = [[UIStoryboard storyboardWithName:@"SurroundingLife" bundle:nil] instantiateViewControllerWithIdentifier:@"SurroundingLifeStoryboardID"];
    //    [self presentViewController:surroundingLifeViewcontroller animated:YES completion:^{}];
    [self.navigationController pushViewController:surroundingLifeViewcontroller animated:YES];
}



@end
