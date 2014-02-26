//
//  HXTIWantViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTIWantViewController.h"
#import "ComboBoxView.h"

@interface HXTIWantViewController ()

@property (weak, nonatomic) IBOutlet ComboBoxView *dropDownComboBoxView;

@end

@implementation HXTIWantViewController

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
    NSArray *comboBoxDatasource = @[@"小区1", @"小区2", @"小区3", @"小区4", @"小区5"];
    _dropDownComboBoxView.comboBoxDatasource = comboBoxDatasource;
	_dropDownComboBoxView.backgroundColor = [UIColor clearColor];
	[_dropDownComboBoxView setContent:[comboBoxDatasource objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)youComeButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

- (IBAction)iGoButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

- (IBAction)groupTogetherButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

- (IBAction)secondHandButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

@end
