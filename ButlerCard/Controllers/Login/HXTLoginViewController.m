//
//  HXTLoginViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTLoginViewController.h"
#import "HXTCheckBox.h"

@interface HXTLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet HXTCheckBox *rememberUserNameCheckBox;
@property (weak, nonatomic) IBOutlet HXTCheckBox *rememberPasswordCheckBox;

@end

@implementation HXTLoginViewController

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
    _userNameTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --
#pragma -- UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _userNameTextField) {
        [_passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }

    return YES;
}

- (IBAction)backgroundTouchUpInside:(id)sender {
    [self dismissKeyboard];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UserRegisterStoryboardSegueIdentifier"]) {
        [self dismissKeyboard];
        [segue.destinationViewController setValue:self forKey:@"delegate"];
    }
}

#pragma --
#pragma -- RegisterAccountViewController Delegate
- (void)registerAccountViewController:(UIViewController *)registerAccountViewController registerDidSucessed:(BOOL)sucessed {
    NSLog(@"%s %s %d register account sucessed = %@", __FILE__, __FUNCTION__, __LINE__, sucessed? @"YES": @"NO");
}
- (IBAction)forgetPassordButtonPressed:(UIButton *)sender {
    [self dismissKeyboard];
}

- (IBAction)regesterAccountButtonPressed:(UIButton *)sender {
    
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(loginViewController:loginDidSucessed:)]) {
        [_delegate loginViewController:self loginDidSucessed:YES];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dismissKeyboard {
    if ( [_userNameTextField isEditing] ) {
        [_userNameTextField resignFirstResponder];
    } else if ([_passwordTextField isEditing]) {
        [_passwordTextField resignFirstResponder];
    }
}
@end
