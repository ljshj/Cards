//
//  HXTPropertyCell.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTPropertyCell.h"

@implementation HXTPropertyCell

- (id)init {
    self = [super init];
    if (self) {
        _house = [[HXTHouse alloc] init];
        _propertyManagementFees = [[HXTPropertyBillCell alloc] init];
        _parkingFees            = [[HXTPropertyBillCell alloc] init];
        _waterFees              = [[HXTPropertyBillCell alloc] init];
        _electricityFees        = [[HXTPropertyBillCell alloc] init];
        _gasFrees               = [[HXTPropertyBillCell alloc] init];
    }
    
    return self;
}
@end
