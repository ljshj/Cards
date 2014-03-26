//
//  HXTAppleyOpenPropertyViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTAppleyOpenPropertyViewController.h"
#import "HXTLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface HXTAppleyOpenPropertyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;

@end

@implementation HXTAppleyOpenPropertyViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Actions

- (IBAction)locationButtonPressed:(id)sender {
    __block __weak HXTAppleyOpenPropertyViewController *appleyOpenPropertyViewController = self;
    [[HXTLocationManager sharedLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        appleyOpenPropertyViewController.latitudeLabel.text  = [NSString stringWithFormat:@"%f", locationCorrrdinate.latitude];
        appleyOpenPropertyViewController.longitudeLabel.text = [NSString stringWithFormat:@"%f", locationCorrrdinate.longitude];
    } withAddress:^(NSString *addressString) {
        appleyOpenPropertyViewController.addrLabel.text = addressString;
    }];
    
    [[HXTLocationManager sharedLocation] getCity:^(NSString *addressString) {
        appleyOpenPropertyViewController.cityLabel.text = addressString;
    }];
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
