//
//  HXTAccountManager.h
//  ButlerCard
//
//  Created by johnny tang on 2/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSessionID				@"SessionID"
#define kUserID                 @"UserID"
#define kGroupID                @"GroupID"
#define kUserName				@"UserName"
#define kNickName				@"NickName"
#define kSchemeName             @"SchemeName"
#define kPassword				@"Password"
#define kPhoneNumber            @"PhoneNumber"
#define kEmailAddr              @"EmailAddr"
#define kSex                    @"Sex"
#define kFirstRun               @"FirstRun"
#define kRememberLoginInfo      @"RememberLoginInfo"
#define kEnablePush             @"EnablePush"

@class HXTAccountManager;

@protocol AccountManagerDelegate <NSObject>

@optional
- (void)accountManager:(HXTAccountManager *)accountManager loginDidSucessed:(BOOL)sucessed;
- (void)accountManager:(HXTAccountManager *)accountManager registerAccountDidSucessed:(BOOL)sucessed;

@end

@interface HXTAccountManager : NSObject

@property (assign, nonatomic) id<AccountManagerDelegate> delegate;

@property (assign, nonatomic, getter = isLogged) BOOL logged;
@property (copy,   nonatomic) NSString *sessionID;
@property (copy,   nonatomic) NSString *userID;
@property (copy,   nonatomic) NSString *groupID;
@property (copy,   nonatomic) NSString *username;
@property (copy,   nonatomic) NSString *nickName;
@property (copy,   nonatomic) NSString *schemeName;
@property (copy,   nonatomic) NSString *password;
@property (copy,   nonatomic) NSString *phoneNumber;
@property (copy,   nonatomic) NSString *emailAddr;
@property (copy,   nonatomic) NSString *sex;

@property (assign, nonatomic, getter = isLoginRememberdUsername) BOOL loginRememberdUsername;
@property (assign, nonatomic, getter = isLoginRememberdPassword) BOOL loginRememberdPassword;
@property (assign, nonatomic, getter = isFirstRun) BOOL firstRun;

+ (HXTAccountManager *)sharedInstance;
- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)registerAccountWithUsername:(NSString *)username password:(NSString *)password;
@end
