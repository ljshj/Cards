//
//  HXTPropertyTableViewHeaderFooterView.m
//  ButlerCard
//
//  Created by johnny tang on 3/13/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTPropertyTableViewHeaderFooterView.h"
@interface HXTPropertyTableViewHeaderFooterView ()

@property (weak, nonatomic) IBOutlet UIButton *expandButton;
@end

@implementation HXTPropertyTableViewHeaderFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setExpanded:(BOOL)expanded {
    _expanded = expanded;
    _expandButton.selected = _expanded;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)expandButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    _expanded = sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(HXTPropertyTableViewHeaderFooterView:expanded:)]) {
        [_delegate HXTPropertyTableViewHeaderFooterView:self expanded:_expanded];
    }
}
@end
