//
//  WSNineSquaresUpdateItem.h
//  FlyingCodes WifiSwitch
//
//  Created by johnny tang on 8/19/13.
//  Copyright (c) 2013 GZTech Electronics (Shenzhen) Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSNineSquaresUpdateItem : NSObject

@property (assign, nonatomic) int newIndex;
@property (assign, nonatomic) int oldIndex;
@property (assign, nonatomic) CGRect movedRect;

@end
