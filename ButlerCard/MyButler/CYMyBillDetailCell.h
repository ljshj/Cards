//
//  CYMyBillDetailCell.h
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyBillDetailCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UIImageView *titleImageView;
@property(nonatomic,retain)IBOutlet UILabel *titleLable;
@property(nonatomic,retain)IBOutlet UILabel *timeLable;
@property(nonatomic,retain)IBOutlet UILabel *moneyLable;
@property(nonatomic,retain)IBOutlet UILabel *stateLable;

@end
