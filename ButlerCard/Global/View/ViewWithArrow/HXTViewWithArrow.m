//
//  HXTViewWithArrow.m
//  ButlerCard
//
//  Created by johnny tang on 3/3/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//


#import "HXTViewWithArrow.h"

#define kArrowHeight 12
#define kArrowWidth  20
@interface HXTViewWithArrow ()
@property(strong, nonatomic) UIView *contentView;
@property(assign, nonatomic) CGPoint lastRelativeOrigin;
@end

@implementation HXTViewWithArrow


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //we need to set the background as clear to see the view below
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        for (UIView *aSubView in self.subviews) {
            _contentView = aSubView;
        }
        _relativeOrigin = CGPointZero;
        _lastRelativeOrigin = CGPointZero;
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
        _relativeOrigin = CGPointZero;
        _lastRelativeOrigin = CGPointZero;
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
    
    //利用path进行绘制图形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, 0, CGRectGetMaxY(self.bounds));//设置起点
    CGContextAddLineToPoint(context, 0, kArrowHeight);
    CGContextAddLineToPoint(context, _relativeOrigin.x - kArrowWidth / 2.0, kArrowHeight);
    CGContextAddLineToPoint(context, _relativeOrigin.x, 0);
    CGContextAddLineToPoint(context, _relativeOrigin.x + kArrowWidth / 2.0, kArrowHeight);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), kArrowHeight);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor colorWithWhite:0.4 alpha:0.9] setFill]; //设置填充色
    [[UIColor blackColor] setStroke]; //设置边框颜色
    CGContextSetAlpha(context, _contentView.alpha);
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

#pragma mark - Setter and Getter Methords

- (void)setRelativeOrigin:(CGPoint)relativeOrigin {
    _lastRelativeOrigin = _relativeOrigin;
    _relativeOrigin = relativeOrigin;
}

- (void)moveArrowFromPoint:(CGPoint)sourcePoint toPoint:(CGPoint)destPoint {
    
    CAKeyframeAnimation *move = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.duration = 0.5;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, sourcePoint.x, sourcePoint.y);
    CGPathAddLineToPoint(path, NULL, destPoint.x, destPoint.y);
    move.path = path;
    
    CGPathRelease(path);
    
    CAAnimationGroup *totalAnimation = [CAAnimationGroup animation];
    totalAnimation.duration = 1.0f;
    totalAnimation.animations = @[move];
    totalAnimation.fillMode = kCAFillModeForwards;
    totalAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    totalAnimation.delegate = self;
    
    self.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    [self.layer addAnimation:totalAnimation forKey:@"arrowMove"];
}

@end
