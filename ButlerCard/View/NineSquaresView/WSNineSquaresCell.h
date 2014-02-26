//
//  WSNineSquaresCell.h
//  FlyingCodes WifiSwitch
//
//  Created by johnny tang on 8/19/13.
//  Copyright (c) 2013 GZTech Electronics (Shenzhen) Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSNineSquaresCell;
@protocol WSNineSquaresCellDelegate <NSObject>
@optional
- (void)WSNineSquaresCellClicked:(WSNineSquaresCell *)cell;
- (void)WSNineSquaresCellDeleteButtonClicked:(WSNineSquaresCell *)cell;
@end

@interface WSNineSquaresCell : UIView

@property (assign, nonatomic) id<WSNineSquaresCellDelegate> delegate;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger oldIndex;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

- (void)hideDeleteBtn:(BOOL)hidden;

@end
