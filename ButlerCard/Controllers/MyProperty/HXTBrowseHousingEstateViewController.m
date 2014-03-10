//
//  HXTBrowseHousingEstateViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTBrowseHousingEstateViewController.h"
#import "HXTAccountManager.h"
#import "HXTMyProperties.h"

@interface HXTBrowseHousingEstateViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *propertySearchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *housingEstatesCollectionView;
@property (weak, nonatomic) IBOutlet UIView *applyOpenPropertyView;
@property (copy, nonatomic) NSMutableArray *housingEstateNamesToShow;
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
    
    _housingEstateNamesToShow = [[NSMutableArray alloc] initWithArray:[HXTMyProperties sharedInstance].housingEstateNames];
    
    _applyOpenPropertyView.hidden = YES;
    
    [[HXTAccountManager sharedInstance] addObserver:self forKeyPath:@"currentCity" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    self.navigationItem.rightBarButtonItem.title = [HXTAccountManager sharedInstance].currentCity;
}

#pragma --
#pragma -- key value abserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentCity"] && object == [HXTAccountManager sharedInstance]) {
        self.navigationItem.rightBarButtonItem.title = [HXTAccountManager sharedInstance].currentCity;
    } 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    _propertySearchBar.text = nil;
    [_propertySearchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -- mark
#pragma -- UISearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"1searchBar.text = %@ searchText = %@", searchBar.text, searchText);
    [self startSearch:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"3searchBar.text = %@", searchBar.text);
    [self startSearch:searchBar.text];
}

- (void)startSearch:(NSString *)searchString {
    if (searchString == nil || (id)searchString==[NSNull null] ||
        searchString.length <= 0 || [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<=0) {
        [_housingEstateNamesToShow addObjectsFromArray:[HXTMyProperties sharedInstance].housingEstateNames];
    } else {
        [_housingEstateNamesToShow removeAllObjects];
        for (NSUInteger i = 0; i < [HXTMyProperties sharedInstance].housingEstateNames.count; i++) {
            NSRange range = [[HXTMyProperties sharedInstance].housingEstateNames[i] rangeOfString:searchString];
            if (range.location != NSNotFound) {
                [_housingEstateNamesToShow addObject:[HXTMyProperties sharedInstance].housingEstateNames[i]];
            }
        }
    }
    
    [_housingEstatesCollectionView reloadData];
}

#pragma -- mark
#pragma -- UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _housingEstateNamesToShow.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collectionViewCellIdentifier= @"CollectionViewCellIdentifier";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    
//    UIButton *cellButton = (UIButton *)[cell viewWithTag:100];
    UILabel  *cellLabel  = (UILabel *)[cell viewWithTag:101];
    cellLabel.text = _housingEstateNamesToShow[indexPath.row];
    
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
