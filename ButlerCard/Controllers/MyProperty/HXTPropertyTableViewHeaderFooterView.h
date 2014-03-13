//
//  HXTPropertyTableViewHeaderFooterView.h
//  ButlerCard
//
//  Created by johnny tang on 3/13/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXTPropertyTableViewHeaderFooterView;

@protocol HXTPropertyTableViewHeaderFooterViewDelegate <NSObject>
@optional
-(void)HXTPropertyTableViewHeaderFooterView:(HXTPropertyTableViewHeaderFooterView *)tableViewHeaderFooterView expanded:(BOOL)expanded;

@end

@interface HXTPropertyTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, assign) id <HXTPropertyTableViewHeaderFooterViewDelegate>   delegate;
@property (nonatomic, assign) BOOL expanded;
@end
