//
//  HXTViewWithArrow.m
//  ButlerCard
//
//  Created by johnny tang on 3/3/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//


#import "HXTViewWithArrow.h"

#define kArrowHeight 20
#define kArrowWidth  20
@interface HXTViewWithArrow ()
@property(strong, nonatomic) UIView *contentView;
@end

@implementation HXTViewWithArrow


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //we need to set the background as clear to see the view below
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //we need to set the background as clear to see the view below
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        for (UIView *aSubView in self.subviews) {
            _contentView = aSubView;
        }
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, _relativeOrigin.x, 0);//设置起点
    CGContextAddLineToPoint(context, _relativeOrigin.x - kArrowWidth / 2.0, kArrowHeight);
    CGContextAddLineToPoint(context, _relativeOrigin.x + kArrowWidth / 2.0, kArrowHeight);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [_contentView.backgroundColor setFill]; //设置填充色
    [_contentView.backgroundColor setStroke]; //设置边框颜色
    CGContextSetAlpha(context, _contentView.alpha);
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}


@end
