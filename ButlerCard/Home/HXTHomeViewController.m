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
<<<<<<< HEAD

@property (weak, nonatomic) IBOutlet UIButton *propertyServiceButton;
@property (weak, nonatomic) IBOutlet UIButton *propertyFeeButton;
@property (weak, nonatomic) IBOutlet UIButton *myFinancesButton;
@property (weak, nonatomic) IBOutlet UIButton *ecologicalDistributionButton;
@property (weak, nonatomic) IBOutlet UIButton *surroundingLifeButton;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
=======
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
>>>>>>> FETCH_HEAD

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
<<<<<<< HEAD
    //    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _propertyServiceButton.selected = NO;
    _propertyFeeButton.selected = NO;
    _myFinancesButton.selected = NO;
    _ecologicalDistributionButton.selected = NO;
    _surroundingLifeButton.selected = NO;
    
=======
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
>>>>>>> FETCH_HEAD
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UINavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self) {
<<<<<<< HEAD
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
    UIViewController *propertyServiceViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"PropertyServiceStoryboardID"];
    [self.navigationController pushViewController:propertyServiceViewController animated:YES];
}

//物业缴费
- (IBAction)propertyFeeButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"物业缴费 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    
    if ([[HXTAccountManager sharedInstance] isLogged]) { //已登录，进入用户账单界面
        UITableViewController *myPropertyViewController = [[UIStoryboard storyboardWithName:@"MyProperty" bundle:nil] instantiateViewControllerWithIdentifier:@"PropertyFeeStoryboardID"];
        
        [self.navigationController pushViewController:myPropertyViewController animated:YES];
    } else { //没有登录，进入浏览小区界面
        
        UIViewController * browseHouseEstateViewController = [[UIStoryboard storyboardWithName:@"BrowseHouseEstate" bundle:nil] instantiateViewControllerWithIdentifier:@"BrowseHouseEstateStoryboardID"];
        
        [self.navigationController pushViewController:browseHouseEstateViewController animated:YES];
    }
}

//周边生活
- (IBAction)surroundingLifeButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"周边生活 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *surroundingLifeViewcontroller = [[UIStoryboard storyboardWithName:@"SurroundingLife" bundle:nil] instantiateViewControllerWithIdentifier:@"SurroundingLifeStoryboardID"];
    //    [self presentViewController:surroundingLifeViewcontroller animated:YES completion:^{}];
    [self.navigationController pushViewController:surroundingLifeViewcontroller animated:YES];
}


//小区互动
- (IBAction)houseEstateInteractionButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"小区互动 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

//商家登录
- (IBAction)sellerButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"商家登录 %s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *ecologicalDistributionViewcontroller = [[UIStoryboard storyboardWithName:@"EcologicalDistribution" bundle:nil] instantiateViewControllerWithIdentifier:@"EcologicalDistributionStoryboardID"];
    [self.navigationController pushViewController:ecologicalDistributionViewcontroller animated:YES];
}



=======
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

>>>>>>> FETCH_HEAD
@end
