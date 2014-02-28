//
//  HXTRegisterAccountViewController.m
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTRegisterAccountViewController.h"
#import "HXTCheckBox.h"
#import "ComboBoxView.h"
#import "HXTAccountManager.h"

@interface HXTRegisterAccountViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet HXTCheckBox *chooseHousingEstateCheckBox;
@property (weak, nonatomic) IBOutlet HXTCheckBox *approveUserAgreementCheckBox;
@property (weak, nonatomic) IBOutlet ComboBoxView *dropDownComboBoxView;

@end

@implementation HXTRegisterAccountViewController

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
    
    _userNameTextField.delegate = self;
    _passwordTextField.delegate = self;
    _confirmPasswordTextField.delegate = self;
    _verificationCodeTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --
#pragma -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _userNameTextField) {
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [_confirmPasswordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)backgroundTouchUpInside:(id)sender {
    //点击背景，键盘消失
    if ([_userNameTextField isEditing]) {
        [_userNameTextField resignFirstResponder];
    } else if ([_passwordTextField isEditing]) {
        [_passwordTextField resignFirstResponder];
    } else if ([_confirmPasswordTextField isEditing]) {
        [_confirmPasswordTextField resignFirstResponder];
    } else if ([_verificationCodeTextField isEditing]) {
        [_verificationCodeTextField resignFirstResponder];
    }
}

- (IBAction)sendVerificationCodeButtonPressed:(id)sender {
    NSLog(@"%s %s %d", __FILE__, __FUNCTION__, __LINE__);
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    if (!_userNameTextField.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"用户名不能为空！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (!_passwordTextField.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"密码不能为空！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (!_confirmPasswordTextField.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入确认密码！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"两次输入米啊吗不匹配！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (!_verificationCodeTextField.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入验证码！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    BOOL registerDidSucessed = [[HXTAccountManager sharedInstance] registerAccountWithUsername:_userNameTextField.text password:_passwordTextField.text];
    
    if (registerDidSucessed) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注册成功"
                                                            message:@"注册成功提示信息，请登录！"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        //将用户名，密码传回登录界面
        [(UIViewController *)_delegate setValue:_userNameTextField.text forKeyPath:@"userNameTextField.text"];
        [(UIViewController *)_delegate setValue:_passwordTextField.text forKeyPath:@"passwordTextField.text"];
        
        if (_delegate && [_delegate respondsToSelector:@selector(registerAccountViewController:registerDidSucessed:)]) {
            [_delegate registerAccountViewController:self registerDidSucessed:registerDidSucessed];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注册失败"
                                                            message:@"注册失败原因"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

@end
