//
//  HXTPropertyBillDetailCell.h
//  ButlerCard
//
//  Created by johnny tang on 3/11/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BillState) {
    BillStateNeedToPay = 0, //缴费
    BillStateProcessing,    //处理中
    BillStatePaid,          //已缴费
};

@interface HXTPropertyBillDetailCell : NSObject
@property (assign, nonatomic) NSUInteger year;
@property (assign, nonatomic) NSUInteger month;
@property (assign, nonatomic) float      money;
@property (assign, nonatomic) BillState  state;
@end
