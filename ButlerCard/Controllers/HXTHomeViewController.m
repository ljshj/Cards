//
//  HXTHomeViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTHomeViewController.h"
#import "HXTAccountManager.h"

@interface HXTHomeViewController () <UINavigationControllerDelegate>

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
    
    //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"arrow_left"] forBarMetrics:UIBarMetricsDefault];
    //Not suppot iOS 6
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"arrow_left"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"arrow_left"]];
    
    self.navigationController.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (viewController == self) {
//        self.tabBarController.tabBar.hidden = NO;
//    }
}

- (IBAction)myAccountButtonPressed:(id)sender {
    self.tabBarController.selectedIndex = 3;
}

- (IBAction)myPropertyButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    
    if ([[HXTAccountManager sharedInstance] isLogged]) { //已登录，进入用户账单界面
        UITableViewController *myPropertyViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"MyPropertiesStoryboardID"];
        
        [self.navigationController pushViewController:myPropertyViewController animated:YES];
    } else { //没有登录，进入小区浏览界面
        UIViewController *browseHousingEstateViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"BrowseHousingEstateStoryboardID"];
        
//        [self presentViewController:browseHousingEstateViewController animated:YES completion:nil];
        [self.navigationController pushViewController:browseHousingEstateViewController animated:YES];
    }
}

- (IBAction)myEasyLifeButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *myEasyLifeViewcontroller = [[UIStoryboard storyboardWithName:@"MyEasyLife" bundle:nil] instantiateViewControllerWithIdentifier:@"MyEasyLifeStoryboardID"];
    [self.navigationController pushViewController:myEasyLifeViewcontroller animated:YES];
}

- (IBAction)myFarmButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *myFarmViewcontroller = [[UIStoryboard storyboardWithName:@"MyFarm" bundle:nil] instantiateViewControllerWithIdentifier:@"MyFarmStoryboardID"];
    [self.navigationController pushViewController:myFarmViewcontroller animated:YES];
}

- (IBAction)myPiggyBankButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

@end
