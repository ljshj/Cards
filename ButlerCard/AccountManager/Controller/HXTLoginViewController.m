//
//  HXTLoginViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTLoginViewController.h"
#import "HXTCheckBox.h"
#import "HXTAccountManager.h"

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
    _rememberUserNameCheckBox.selected = YES;
    _rememberPasswordCheckBox.selected = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_userNameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

#pragma -- RegisterAccountViewController Delegate

- (void)registerAccountViewController:(UIViewController *)registerAccountViewController registerDidSucessed:(BOOL)sucessed {
    NSLog(@"%s %s %d register account sucessed = %@", __FILE__, __FUNCTION__, __LINE__, sucessed? @"YES": @"NO");
}
- (IBAction)forgetPassordButtonPressed:(UIButton *)sender {
    [self dismissKeyboard];
}


- (IBAction)loginButtonPressed:(UIButton *)sender {
    BOOL loginDidSucessed = [[HXTAccountManager sharedInstance] loginWithUsername:_userNameTextField.text password:_passwordTextField.text];
    
    if (loginDidSucessed) {
        if (_delegate && [_delegate respondsToSelector:@selector(loginViewController:loginDidSucessed:)]) {
            [_delegate loginViewController:self loginDidSucessed:loginDidSucessed];
        }
        [self.navigationController popToRootViewControllerAnimated:NO];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                            message:@"无效用户名或密码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (void)dismissKeyboard {
    if ( [_userNameTextField isEditing] ) {
        [_userNameTextField resignFirstResponder];
    } else if ([_passwordTextField isEditing]) {
        [_passwordTextField resignFirstResponder];
    }
}

#pragma mark - Navigation

- (IBAction)backButtonPressed:(id)sender {
    
    if (self.navigationController.viewControllers.count == 1) { //使用的模态方式进入改页面
        [self dismissViewControllerAnimated:YES completion:^{}];
    } else { //其他Controller通过导航控制器进入该页面
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
