//
//  HXTAccountManager.m
//  ButlerCard
//
//  Created by johnny tang on 2/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTAccountManager.h"

@implementation HXTAccountManager


+ (HXTAccountManager *)sharedInstance {
    static HXTAccountManager *accountManager;
    if (accountManager == nil) {
        accountManager = [[HXTAccountManager alloc] init];
        [accountManager LoadDataFromUserDefault];
    }
    if (!accountManager.currentCity ||!accountManager.username || !accountManager.password) {
        accountManager.currentCity = @"成都";
        accountManager.username = @"username";
        accountManager.password = @"password";
        [accountManager writeDataToUserDefault];
        [accountManager LoadDataFromUserDefault];
    }
    NSLog(@"username = #%@#, password = #%@#", accountManager.username, accountManager.password);
    return accountManager;
}

#pragma mark -
#pragma mark load and write data to userDefault methods
- (BOOL)LoadDataFromUserDefault
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    _sessionID   = [accountDefaults objectForKey:kSessionID];
    _userID      = [accountDefaults objectForKey:kUserID];
    _groupID     = [accountDefaults objectForKey:kGroupID];
    _username    = [accountDefaults objectForKey:kUserName];
    _nickName    = [accountDefaults objectForKey:kNickName];
    _schemeName  = [accountDefaults objectForKey:kSchemeName];
    _password    = [accountDefaults objectForKey:kPassword];
    _phoneNumber = [accountDefaults objectForKey:kPhoneNumber];
    _emailAddr   = [accountDefaults objectForKey:kEmailAddr];
    _sex         = [accountDefaults objectForKey:kSex];
    _currentCity = [accountDefaults objectForKey:kCurrentCity];
    _logged      = [accountDefaults boolForKey:kLogged];
    _firstRun    = [accountDefaults boolForKey:kFirstRun];
    _enablePush  = [accountDefaults boolForKey:kEnablePush];
    _rememberdUsernameAtLogin = [accountDefaults boolForKey:kRememberdUsernameAtLogin];
    _rememberdPasswordAtLogin = [accountDefaults boolForKey:kRememberdPasswordAtLogin];
    
    return YES;
}

- (BOOL)writeDataToUserDefault {
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
    [accountDefaults setObject:_sessionID forKey:kSessionID];
    [accountDefaults setObject:_userID forKey:kUserID];
    [accountDefaults setObject:_groupID forKey:kGroupID];
    [accountDefaults setObject:_username forKey:kUserName];
    [accountDefaults setObject:_nickName forKey:kNickName];
    [accountDefaults setObject:_schemeName forKey:kSchemeName];
    [accountDefaults setObject:_password forKey:kPassword];
    [accountDefaults setObject:_phoneNumber forKey:kPhoneNumber];
    [accountDefaults setObject:_emailAddr forKey:kEmailAddr];
    [accountDefaults setObject:_sex forKey:kSex];
    [accountDefaults setObject:_currentCity forKey:kCurrentCity];
    [accountDefaults setBool:_logged forKey:kLogged];
    [accountDefaults setBool:_firstRun forKey:kFirstRun];
    [accountDefaults setBool:_enablePush forKey:kEnablePush];
    [accountDefaults setBool:_rememberdUsernameAtLogin forKey:kRememberdUsernameAtLogin];
    [accountDefaults setBool:_rememberdPasswordAtLogin forKey:kRememberdPasswordAtLogin];
    [accountDefaults synchronize];
    return YES;
}

- (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && [username isEqualToString:_username] && [password isEqualToString:_password]) {
        _logged = YES;
        return YES;
    }
    
    return NO;
}

- (BOOL)registerAccountWithUsername:(NSString *)username password:(NSString *)password {
    _username = username;
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:_username forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setObject:_password forKey:kPassword];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

@end
