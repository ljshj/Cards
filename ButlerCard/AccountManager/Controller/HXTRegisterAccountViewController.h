//
//  HXTRegisterAccountViewController.h
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXTRegisterAccountViewController;
@protocol RegisterAccountViewControllerDelegate <NSObject>

- (void)registerAccountViewController:(UIViewController *)registerAccountViewController registerDidSucessed:(BOOL)sucessed;

@end

@interface HXTRegisterAccountViewController : UIViewController

@property (assign, nonatomic) id<RegisterAccountViewControllerDelegate> delegate;

@end
