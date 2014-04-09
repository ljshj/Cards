//
//  HXTAccountManager.m
//  ButlerCard
//
//  Created by johnny tang on 2/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTAccountManager.h"
#import "AFNetworking.h"

@implementation HXTAccountManager


+ (HXTAccountManager *)sharedInstance {
    static HXTAccountManager *accountManager;
    if (!accountManager) {
        accountManager = [[HXTAccountManager alloc] init];
        [accountManager LoadDataFromUserDefault];
        
        if (!accountManager.currentCity ||!accountManager.username || !accountManager.password) {
            accountManager.currentCity = @"重庆";
            [accountManager writeDataToUserDefault];
        }
        
        
    }
    
    return accountManager;
}

#pragma mark -
#pragma mark load and write data to userDefault methods
- (BOOL)LoadDataFromUserDefault
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    _deposit                  = [accountDefaults doubleForKey:kDeposit];
    _sessionID                = [accountDefaults objectForKey:kSessionID];
    _userID                   = [accountDefaults integerForKey:kUserID];
    _groupID                  = [accountDefaults objectForKey:kGroupID];
    _username                 = [accountDefaults objectForKey:kUserName];
    _nickName                 = [accountDefaults objectForKey:kNickName];
    _schemeName               = [accountDefaults objectForKey:kSchemeName];
    _password                 = [accountDefaults objectForKey:kPassword];
    _phoneNumber              = [accountDefaults objectForKey:kPhoneNumber];
    _emailAddr                = [accountDefaults objectForKey:kEmailAddr];
    _sex                      = [accountDefaults objectForKey:kSex];
    _currentCity              = [accountDefaults objectForKey:kCurrentCity];
    _defaultHouseingEstate    = [accountDefaults objectForKey:kDefaultHouseingEstate];
    _logged                   = [accountDefaults boolForKey:kLogged];
    _firstRun                 = [accountDefaults boolForKey:kFirstRun];
    _enablePush               = [accountDefaults boolForKey:kEnablePush];
    _rememberdUsernameAtLogin = [accountDefaults boolForKey:kRememberdUsernameAtLogin];
    _rememberdPasswordAtLogin = [accountDefaults boolForKey:kRememberdPasswordAtLogin];
    
    return YES;
}

- (BOOL)writeDataToUserDefault {
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    [accountDefaults setDouble:_deposit forKey:kDeposit];
    [accountDefaults setObject:_sessionID forKey:kSessionID];
    [accountDefaults setInteger:_userID forKey:kUserID];
    [accountDefaults setObject:_groupID forKey:kGroupID];
    [accountDefaults setObject:_username forKey:kUserName];
    [accountDefaults setObject:_nickName forKey:kNickName];
    [accountDefaults setObject:_schemeName forKey:kSchemeName];
    [accountDefaults setObject:_password forKey:kPassword];
    [accountDefaults setObject:_phoneNumber forKey:kPhoneNumber];
    [accountDefaults setObject:_emailAddr forKey:kEmailAddr];
    [accountDefaults setObject:_sex forKey:kSex];
    [accountDefaults setObject:_currentCity forKey:kCurrentCity];
    [accountDefaults setObject:_defaultHouseingEstate forKey:kDefaultHouseingEstate];
    [accountDefaults setBool:_logged forKey:kLogged];
    [accountDefaults setBool:_firstRun forKey:kFirstRun];
    [accountDefaults setBool:_enablePush forKey:kEnablePush];
    [accountDefaults setBool:_rememberdUsernameAtLogin forKey:kRememberdUsernameAtLogin];
    [accountDefaults setBool:_rememberdPasswordAtLogin forKey:kRememberdPasswordAtLogin];
    [accountDefaults synchronize];
    return YES;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    
    NSDictionary *parameters = @{@"tel": username, @"password": password};
    [[AFHTTPRequestOperationManager manager] POST:@"http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/user/login"
                                       parameters:parameters
                                          success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                              NSLog(@"JSON: %@", responseObject);
                                              
                                              if ([responseObject[@"success"] integerValue] == 1) {
                                                  self.logged = YES;
                                                  _username = username;
                                                  _password = password;
                                                  _nickName = responseObject[@"results"][@"nickname"];
                                                  _userID = [responseObject[@"results"][@"uid"] integerValue];
                                                  _emailAddr = responseObject[@"results"][@"email"];
                                                  _deposit = [responseObject[@"results"][@"deposit"] doubleValue];
                                              } else {
                                                  self.logged = NO;
                                              }
                                              
                                              [self writeDataToUserDefault];
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"Error: %@", error);
                                              self.logged = NO;
                                              [self writeDataToUserDefault];
                                          }];
    
}

- (void)getUserInfo {
    NSURL *baseURL = [NSURL URLWithString:@"http://bbs.enveesoft.com:1602"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    NSDictionary *parameters = @{@"uid": @"1", @"sid": @"66d804a0bb4c0a06"};
    [manager POST:@"/htx/hexinpassserver/appserver/public/user/info" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)registerAccountWithUsername:(NSString *)username password:(NSString *)password {
    _username = username;
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:_username forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setObject:_password forKey:kPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end
