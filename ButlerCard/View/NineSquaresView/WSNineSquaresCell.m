//
//  WSNineSquaresCell.m
//  FlyingCodes WifiSwitch
//
//  Created by johnny tang on 8/19/13.
//  Copyright (c) 2013 GZTech Electronics (Shenzhen) Company Limited. All rights reserved.
//

#import "WSNineSquaresCell.h"

#define kDelBtnWidth            40
#define kDelBtnHeight           40
#define kSideMargin             10
#define kTopMargin              10

@interface WSNineSquaresCell ()
{
    UIButton *button;
    UIButton *deleteBtn;
    UILabel *titleLbl;
}
@end

@implementation WSNineSquaresCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) 
    {
        self.backgroundColor = [UIColor clearColor];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(kSideMargin, kTopMargin, frame.size.width - 2 * kSideMargin, frame.size.height - 2 * kSideMargin - kTopMargin);
        [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(0, 0, kDelBtnWidth, kDelBtnHeight);
        deleteBtn.center = CGPointMake(kSideMargin + 4, kTopMargin + 4);
        [deleteBtn setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchDown];
        deleteBtn.hidden = YES;
        [self addSubview:deleteBtn];
        
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 2 * kSideMargin, frame.size.width, 2 * kSideMargin)];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLbl];
    }
    
    return self;
}

- (void)buttonClicked {
    if ([_delegate respondsToSelector:@selector(WSNineSquaresCellClicked:)]) {
        [_delegate WSNineSquaresCellClicked:self];
    }
}

- (void)deleteBtnClicked {
    if ([_delegate respondsToSelector:@selector(WSNineSquaresCellDeleteButtonClicked:)]) {
        [_delegate WSNineSquaresCellDeleteButtonClicked:self];
    }
}

- (void)hideDeleteBtn:(BOOL)hidden {
    deleteBtn.hidden = hidden;
}

- (void)setTitle:(NSString *)title {
    titleLbl.text = title;
}

- (NSString *)title {
    return titleLbl.text;
}

- (void)setImage:(UIImage *)image {
    [button setImage:image forState:UIControlStateNormal];
}

- (UIImage *)image {
    return button.currentImage;
}

@end
