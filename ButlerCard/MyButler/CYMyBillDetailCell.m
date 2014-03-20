//
//  CYMyBillDetailCell.m
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYMyBillDetailCell.h"

@implementation CYMyBillDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //设置背景色
        self.backgroundColor = [UIColor greenColor];
        //标题图片
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [_titleImageView setImage:[UIImage imageNamed:@"home_panda"]];
        _titleImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleImageView];
        //标题lable
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 100, 20)];
        [_titleLable setText:@"物业费"];
        _titleLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLable];

        //时间lable
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, 100, 20)];
        [_timeLable setFont:[UIFont systemFontOfSize:12.0f]];
        [_timeLable setText:@"2014.9.26"];
        _timeLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_timeLable];
        //价格lable
        _moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(180, 30, 100, 20)];
        [_moneyLable setText:@"729.00"];
        _moneyLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_moneyLable];

        //状态lable
        _stateLable = [[UILabel alloc]initWithFrame:CGRectMake(250, 30, 100, 20)];
        [_stateLable setFont:[UIFont systemFontOfSize:14.0f]];
        [_stateLable setText:@"交易成功"];
        _stateLable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_stateLable];

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
