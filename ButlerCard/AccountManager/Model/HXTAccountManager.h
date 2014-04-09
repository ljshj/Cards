//
//  HXTAccountManager.h
//  ButlerCard
//
//  Created by johnny tang on 2/25/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

<<<<<<< HEAD
#define kDeposit                  @"Deposit"
=======
>>>>>>> FETCH_HEAD
#define kSessionID				  @"SessionID"
#define kUserID                   @"UserID"
#define kGroupID                  @"GroupID"
#define kUserName				  @"UserName"
#define kNickName				  @"NickName"
#define kSchemeName               @"SchemeName"
#define kPassword				  @"Password"
#define kPhoneNumber              @"PhoneNumber"
#define kEmailAddr                @"EmailAddr"
#define kSex                      @"Sex"
#define kCurrentCity              @"CurrentCity"
<<<<<<< HEAD
#define kDefaultHouseingEstate    @"DefaultHouseingEstate"
=======
>>>>>>> FETCH_HEAD
#define kLogged                   @"Logged"
#define kFirstRun                 @"FirstRun"
#define kEnablePush               @"EnablePush"
#define kRememberdUsernameAtLogin @"RememberdUsernameAtLogin"
#define kRememberdPasswordAtLogin @"RememberdPasswordAtLogin"

@class HXTAccountManager;

@protocol AccountManagerDelegate <NSObject>

@optional

- (void)accountManager:(HXTAccountManager *)accountManager loginDidSucessed:(BOOL)sucessed;
- (void)accountManager:(HXTAccountManager *)accountManager registerAccountDidSucessed:(BOOL)sucessed;

@end

@interface HXTAccountManager : NSObject

@property (assign, nonatomic) id<AccountManagerDelegate> delegate;

<<<<<<< HEAD
@property (assign, nonatomic) double   deposit;
@property (copy,   nonatomic) NSString *sessionID;
@property (assign, nonatomic) NSUInteger userID;
=======
@property (copy,   nonatomic) NSString *sessionID;
@property (copy,   nonatomic) NSString *userID;
>>>>>>> FETCH_HEAD
@property (copy,   nonatomic) NSString *groupID;
@property (copy,   nonatomic) NSString *username;
@property (copy,   nonatomic) NSString *nickName;
@property (copy,   nonatomic) NSString *schemeName;
@property (copy,   nonatomic) NSString *password;
@property (copy,   nonatomic) NSString *phoneNumber;
@property (copy,   nonatomic) NSString *emailAddr;
@property (copy,   nonatomic) NSString *sex;
@property (copy,   nonatomic) NSString *currentCity;
<<<<<<< HEAD
@property (copy,   nonatomic) NSString *defaultHouseingEstate;
=======
>>>>>>> FETCH_HEAD

@property (assign, nonatomic, getter = isLogged) BOOL logged;
@property (assign, nonatomic, getter = isFirstRun) BOOL firstRun;
@property (assign, nonatomic, getter = isEnablePush) BOOL enablePush;
@property (assign, nonatomic, getter = isRememberdUsernameAtLogin) BOOL rememberdUsernameAtLogin;
@property (assign, nonatomic, getter = isRememberdPasswordAtLogin) BOOL rememberdPasswordAtLogin;

<<<<<<< HEAD
+ (instancetype)sharedInstance;
- (BOOL)writeDataToUserDefault;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)registerAccountWithUsername:(NSString *)username password:(NSString *)password;
=======
+ (HXTAccountManager *)sharedInstance;
- (BOOL)writeDataToUserDefault;

- (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password;
- (BOOL)registerAccountWithUsername:(NSString *)username password:(NSString *)password;
>>>>>>> FETCH_HEAD
@end
