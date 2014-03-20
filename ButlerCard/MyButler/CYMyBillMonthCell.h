//
//  CYMyBillMonthCell.h
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyBillMonthCell : UITableViewCell
@property(nonatomic,getter = isFold)BOOL fold;
@property(nonatomic,retain)UILabel *timeLable;
@property(nonatomic,retain)UILabel *moneyLable;
@end
