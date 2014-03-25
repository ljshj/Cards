//
//  CYMyPropertyTableViewCell.m
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import "CYMyPropertyTableViewCell.h"

@implementation CYMyPropertyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [_titleImageView setImage:[UIImage imageNamed:@"home_panda"]];
//        _titleImageView.backgroundColor = [UIColor redColor];
        [self addSubview:_titleImageView];
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 150, 30)];
        [_titleLable setText:@"小区公告"];
        [self addSubview:_titleLable];
        
        _contentLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 35, 200, 30)];
        [_contentLable setText:@"2014年9月14日停水一天"];
        [self addSubview:_contentLable];

//        self.backgroundColor = [UIColor blueColor];
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
