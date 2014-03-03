//
//  HXTIWantViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTIWantViewController.h"
#import "ComboBoxView.h"
#import "HXTViewWithArrow.h"

@interface HXTIWantViewController ()

//@property (strong, nonatomic) FPPopoverView *popoverView;
@property (weak, nonatomic) IBOutlet ComboBoxView *dropDownComboBoxView;
@property (weak, nonatomic) IBOutlet UIButton *youComeButton;
@property (weak, nonatomic) IBOutlet UIButton *iGoButton;
@property (weak, nonatomic) IBOutlet UIButton *groupTogetherButton;
@property (weak, nonatomic) IBOutlet UIButton *secondHandButton;
@property (weak, nonatomic) IBOutlet HXTViewWithArrow *popoverView;

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
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"test";
    label.backgroundColor = [UIColor blueColor];
    _popoverView.contentView = label;
    _popoverView.relativeOrigin = CGPointMake(_youComeButton.frame.origin.x + _youComeButton.frame.size.width / 2, _youComeButton.frame.origin.y + _youComeButton.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)youComeButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIButton *button = (UIButton *)sender;
    _popoverView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
    [_popoverView setNeedsDisplay];
}

- (IBAction)iGoButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIButton *button = (UIButton *)sender;
    _popoverView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
    [_popoverView setNeedsDisplay];
}

- (IBAction)groupTogetherButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIButton *button = (UIButton *)sender;
    _popoverView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
    [_popoverView setNeedsDisplay];
}

- (IBAction)secondHandButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIButton *button = (UIButton *)sender;
    _popoverView.relativeOrigin = CGPointMake(button.frame.origin.x + button.frame.size.width / 2, button.frame.origin.y + button.frame.size.height);
    [_popoverView setNeedsDisplay];
}

@end
