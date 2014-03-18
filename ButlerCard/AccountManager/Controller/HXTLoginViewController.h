//
//  HXTLoginViewController.h
//  ButlerCard
//
//  Created by johnny tang on 2/21/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXTLoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

-(void)loginViewController:(UIViewController *)loginViewController loginDidSucessed:(BOOL)sucessed;

@end

@interface HXTLoginViewController : UIViewController

@property (assign, nonatomic) id<LoginViewControllerDelegate> delegate;

@end
