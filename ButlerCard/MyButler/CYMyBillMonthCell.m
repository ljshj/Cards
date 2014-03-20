//
//  CYMyBillMonthCell.m
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYMyBillMonthCell.h"

@implementation CYMyBillMonthCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        //设置背景色
        self.backgroundColor = [UIColor yellowColor];
        //设置时间lable
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 100, 20)];
        [_timeLable setText:@"本月"];
        _timeLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_timeLable];
        //设置支出lable
        _moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(250, 5, 70, 20)];
        [_moneyLable setText:@"支出998"];
        _moneyLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_moneyLable];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
