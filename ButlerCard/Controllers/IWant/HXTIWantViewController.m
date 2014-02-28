//
//  HXTIWantViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/20/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTIWantViewController.h"
#import "ComboBoxView.h"
#import "FPPopoverController.h"
#import "FPPopoverView.h"

@interface HXTIWantViewController ()

@property (strong, nonatomic) FPPopoverView *popoverView;
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

-(void)popover:(id)sender
{
    //the controller we want to present as a popover
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverContentControllerStoryboardID"];
    
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(320, 260);
    }
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    
    //sender is the UIButton view
    [popover presentPopoverFromView:sender];
}

- (IBAction)youComeButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PopoverContentControllerStoryboardID"];
    if (!_popoverView) {
        _popoverView = [[FPPopoverView alloc] initWithFrame:CGRectMake(0, ((UIButton *)sender).frame.origin.y + ((UIButton *)sender).frame.size.height, 320, 260)];
        [self.view addSubview:_popoverView];
        [_popoverView setArrowDirection:FPPopoverArrowDirectionUp];
        [_popoverView addContentView:controller.view];
        _popoverView.relativeOrigin = CGPointMake(((UIButton *)sender).frame.origin.x + ((UIButton *)sender).frame.size.width / 2, ((UIButton *)sender).frame.origin.y + ((UIButton *)sender).frame.size.height);
        _popoverView.title = controller.title;
        _popoverView.clipsToBounds = NO;
    }
}

- (IBAction)iGoButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    [self popover:sender];
}

- (IBAction)groupTogetherButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    [self popover:sender];
}

- (IBAction)secondHandButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
    [self popover:sender];
}

@end
