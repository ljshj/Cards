//
//  HXTViewWithArrow.m
//  ButlerCard
//
//  Created by johnny tang on 3/3/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTViewWithArrow.h"

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
    }
    
    return self;
}

- (void)setContentView:(UIView *)contentView {
    if(_contentView != contentView) {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        _contentView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y + 20, self.bounds.size.width, self.bounds.size.height - 20);
        [self addSubview:_contentView];
    }
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
    CGContextAddLineToPoint(context, _relativeOrigin.x - 10, 20);
    CGContextAddLineToPoint(context, _relativeOrigin.x + 10, 20);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [_contentView.backgroundColor setFill]; //设置填充色
    [[UIColor clearColor] setStroke]; //设置边框颜色
    CGContextSetAlpha(context, _contentView.alpha);
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}


@end
