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
    
    [[HXTAccountManager sharedInstance] addObserver:self forKeyPath:@"logged" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"logged"] && object == [HXTAccountManager sharedInstance] && [HXTAccountManager sharedInstance].logged) {
//        UIViewController *userBillViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"UserBillStoryboardID"];
//        
//        [self.navigationController pushViewController:userBillViewController animated:YES];
    }
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
