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
    }
    return accountManager;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    
}
- (void)registerAccountWithUsername:(NSString *)username password:(NSString *)password {
    
}

@end
