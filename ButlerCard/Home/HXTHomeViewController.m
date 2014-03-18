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
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

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
    self.navigationController.navigationBarHidden = YES;
    
//    UITabBarItem *tabBarItem = [self.tabBarController] ;
    
//    UIImage *unselectedImage = [UIImage imageNamed:@"zy_home"];
//    UIImage *selectedImage = [UIImage imageNamed:@"zy_home_p"];
    
    
    UITabBarItem *updatesItem = [[UITabBarItem alloc] initWithTitle:@"Label 1" image:[UIImage imageNamed:@"zy_home"] tag:0];
    
    [updatesItem setFinishedSelectedImage:[UIImage imageNamed:@"zy_home_p"] withFinishedUnselectedImage:[UIImage imageNamed:@"zy_home"]];
    self.tabBarItem = updatesItem;
    
    if ([UIDevice isRunningOniPhone5]) {
        _backgroundImageView.image = [UIImage imageNamed:@"background_1136X640"];
    } else {
        _backgroundImageView.image = [UIImage imageNamed:@"background_960X640"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self) {
        self.navigationController.navigationBarHidden = YES;
        self.tabBarController.tabBar.hidden = NO;
    }
}
- (IBAction)propertyServiceButtonPressed:(UIButton *)sender {
//    sender.selected = !sender.selected;
    NSLog(@"物业服务");
}


- (IBAction)propertyFeePressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    
    if ([[HXTAccountManager sharedInstance] isLogged]) { //已登录，进入用户账单界面
        UITableViewController *myPropertyViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"MyPropertiesStoryboardID"];
        
        [self.navigationController pushViewController:myPropertyViewController animated:YES];
    } else { //没有登录，进入小区浏览界面
        UIViewController *browseHousingEstateViewController = [[UIStoryboard storyboardWithName:@"ChooseHouse" bundle:nil] instantiateViewControllerWithIdentifier:@"ChooseHouseEstateStoryboardID"];
        
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
