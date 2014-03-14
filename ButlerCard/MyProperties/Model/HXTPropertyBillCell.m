//
//  HXTPropertyBillCell.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTPropertyBillCell.h"
#import "HXTPropertyBillDetailCell.h"

@interface HXTPropertyBillCell ()

@end

@implementation HXTPropertyBillCell

- (id)init {
    self = [super init];
    if (self) {
        _billDetails = [[NSMutableArray alloc] initWithCapacity:2];
        for (NSUInteger i = 0; i < 2; i++) {
            for (NSUInteger j = 1; j <= 12; j ++) {
                HXTPropertyBillDetailCell *billDetailCell = [[HXTPropertyBillDetailCell alloc] init];
                billDetailCell.year = 2013;
                billDetailCell.month = i;
                billDetailCell.money = 210;
                billDetailCell.state = BillStateNeedToPay;
            }
        }
    }
    return self;
}
@end
