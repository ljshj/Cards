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
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark -- UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (viewController == self) {
//        self.tabBarController.tabBar.hidden = NO;
//    }
}

- (IBAction)myPropertyButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    //没有登录，进入小区浏览界面
    if ([[HXTAccountManager sharedInstance] isLogged]) {
        UIViewController *userBillViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"UserBillStoryboardID"];
        
        [self.navigationController pushViewController:userBillViewController animated:YES];
    } else { //已登录，进入用户账单界面
        UIViewController *browseHousingEstateViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"BrowseHousingEstateStoryboardID"];
        
        [self.navigationController pushViewController:browseHousingEstateViewController animated:YES];
    }
}

- (IBAction)iWantButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *iWantViewcontroller = [[UIStoryboard storyboardWithName:@"IWant" bundle:nil] instantiateViewControllerWithIdentifier:@"IwantStoryboardID"];
    [self.navigationController pushViewController:iWantViewcontroller animated:YES];
}

- (IBAction)myButlerButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

- (IBAction)electricitySuppliersButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

@end
