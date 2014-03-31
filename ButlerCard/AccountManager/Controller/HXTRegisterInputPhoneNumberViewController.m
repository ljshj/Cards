//
//  HXTRegisterInputPhoneNumberViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterInputPhoneNumberViewController.h"

@interface HXTRegisterInputPhoneNumberViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNuberTestField;
@property (weak, nonatomic) IBOutlet UIButton *chockBox;

@end

@implementation HXTRegisterInputPhoneNumberViewController

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_phoneNuberTestField becomeFirstResponder];
    _chockBox.selected = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Actions
- (IBAction)checkBoxButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

- (IBAction)backgoundTouchUpInside:(id)sender {
    [_phoneNuberTestField resignFirstResponder];
}


/*
#pragma mark - Navigation

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
