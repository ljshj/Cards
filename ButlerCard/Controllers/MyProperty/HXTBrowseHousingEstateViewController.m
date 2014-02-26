//
//  HXTBrowseHousingEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTBrowseHousingEstateViewController.h"
#import "WSNineSquares.h"

@interface HXTBrowseHousingEstateViewController ()
<
WSNineSquaresDelegate, WSNineSquaresDataSource
>

@property (weak, nonatomic) IBOutlet WSNineSquares *nineSquaresView;
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
    
//    self.tabBarController.tabBar.hidden = YES;
    
    _housingEstateNames = @[@"南阳盛世", @"向阳小区", @"音乐花园", @"小区4",
                            @"小区5", @"小区6", @"小区7", @"小区8",
                            @"小区9", @"小区10", @"小区11", @"小区12",
                            @"小区13", @"小区14", @"小区15", @"小区16"];
    _nineSquaresView.nineSquaresDelegate = self;
    _nineSquaresView.nineSquaresDateSource = self;
    
    _applyOpenPropertyView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark -- MultiNineSquares delegate
- (BOOL)nineSquaresWillAddCell:(WSNineSquares *)nineSquares{
    return YES;
}

- (BOOL)nineSquares:(WSNineSquares *)nineSquares willDeleteCell:(WSNineSquaresCell *)cell {
    return NO;
}

- (void)nineSquares:(WSNineSquares *)nineSquares cellClicked:(WSNineSquaresCell *)cell {
    NSLog(@"%s %s %d _housingEstateName = %@", __FILE__, __FUNCTION__, __LINE__, _housingEstateNames[cell.index]);
    
    UIViewController *loginViewcontroller = [[UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginStoryboardID"];
 
//模态显示
//    loginViewcontroller.modalPresentationStyle = UIModalPresentationFullScreen;
//    loginViewcontroller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:loginViewcontroller animated:YES completion:nil];
    
    [loginViewcontroller setValue:self forKey:@"delegate"];
    [self.navigationController pushViewController:loginViewcontroller animated:YES];
}

#pragma mark --
#pragma mark -- nineSquaresView dataSource
- (NSInteger)numberOfCellsInNineSquares:(WSNineSquares *)nineSquares {
    return _housingEstateNames.count;
}


#pragma mark --
#pragma mark -- LoginViewController delegate
-(void)loginViewController:(UIViewController *)loginViewController loginDidSucessed:(BOOL)sucessed {
    NSLog(@"%s %s %d Login sucessed = %@", __FILE__, __FUNCTION__, __LINE__, sucessed? @"YES": @"NO");
}

- (WSNineSquaresCell *)nineSquares:(WSNineSquares *)nineSquares initCell:(WSNineSquaresCell *)cell atIndex:(NSInteger)index {
    cell.title = _housingEstateNames[index];
    cell.image = [UIImage imageNamed:@"housingEstate.jpg"];
    
    return cell;
}

- (IBAction)appleyOpenPropertyButtonPressed:(id)sender {
    _applyOpenPropertyView.hidden = NO;
}

- (IBAction)applyOpenPropertySubmitButtonPressed:(id)sender {
    _applyOpenPropertyView.hidden = YES;
}
@end
