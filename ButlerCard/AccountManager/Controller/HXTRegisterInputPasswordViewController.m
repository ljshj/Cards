//
//  HXTRegisterInputPasswordViewController.m
//  ButlerCard
//
//  Created by johnny tang on 3/31/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterInputPasswordViewController.h"

@interface HXTRegisterInputPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTestField;
@property (weak, nonatomic) IBOutlet UITextField *reInputPasswordTestField;

@end

@implementation HXTRegisterInputPasswordViewController

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
    
    [_inputPasswordTestField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Actions

- (IBAction)backgroundTouchUpInside:(id)sender {
    if ([_inputPasswordTestField isFirstResponder]) {
        [_inputPasswordTestField resignFirstResponder];
    }
    
    if ([_reInputPasswordTestField isFirstResponder]) {
        [_reInputPasswordTestField resignFirstResponder];
    }
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
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UI Actions

@end
