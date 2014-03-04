//
//  HXTBrowseHousingEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTBrowseHousingEstateViewController.h"

@interface HXTBrowseHousingEstateViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *housingEstatesCollectionView;
@property (weak, nonatomic) IBOutlet UIView *applyOpenPropertyView;
@property (strong, nonatomic) NSArray *housingEstateNames;
@end

@implementation HXTBrowseHousingEstateViewController

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
    
    _housingEstateNames = @[@"中铁八局", @"万科A小区", @"置信A区", @"华润AA",
                            @"保利别墅A", @"恒大宅院", @"万达高层", @"置信B区",
                            @"华润凤凰城", @"万科V地", @"保利商业", @"中铁Q区",
                            @"小区13", @"小区14", @"小区15", @"小区16"];
    
    _applyOpenPropertyView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --
#pragma UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _housingEstateNames.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionViewCellIdentifier= @"CollectionViewCellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
//    UIButton *cellButton = (UIButton *)[cell viewWithTag:100];
    UILabel  *cellLabel  = (UILabel *)[cell viewWithTag:101];
    cellLabel.text = _housingEstateNames[indexPath.row];
    
    return cell;
}

#pragma --
#pragma -- UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath indexPath.section = %i, indexPath.row = %d", indexPath.section, indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)houseingEstateButtonPressed:(UIButton *)sender {
    NSIndexPath *indexPath = [_housingEstatesCollectionView indexPathForCell:(UICollectionViewCell *)sender.superview.superview];
    NSLog(@"ButtonPressedAtIndexPath indexPath.section = %i, indexPath.row = %d", indexPath.section, indexPath.row);
    UIViewController *loginViewcontroller = [[UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginStoryboardID"];
    
    //模态显示
    //    loginViewcontroller.modalPresentationStyle = UIModalPresentationFullScreen;
    //    loginViewcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:loginViewcontroller animated:YES completion:nil];
    
    [loginViewcontroller setValue:self forKey:@"delegate"];
    [self.navigationController pushViewController:loginViewcontroller animated:YES];
}

#pragma mark --
#pragma mark -- LoginViewController delegate
-(void)loginViewController:(UIViewController *)loginViewController loginDidSucessed:(BOOL)sucessed {
    NSLog(@"%s %s %d Login sucessed = %@", __FILE__, __FUNCTION__, __LINE__, sucessed? @"YES": @"NO");
}

- (IBAction)appleyOpenPropertyButtonPressed:(id)sender {
    _applyOpenPropertyView.hidden = NO;
}

- (IBAction)applyOpenPropertySubmitButtonPressed:(id)sender {
    _applyOpenPropertyView.hidden = YES;
}
@end
