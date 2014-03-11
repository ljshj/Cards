//
//  HXTPropertyCell.h
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXTHouse.h"
#import "HXTPropertyBillCell.h"

@interface HXTPropertyCell : NSObject
@property (strong, nonatomic) HXTHouse     *house;
@property (strong, nonatomic) HXTPropertyBillCell *propertyManagementFees; //物业费
@property (strong, nonatomic) HXTPropertyBillCell *parkingFees;            //停车费
@property (strong, nonatomic) HXTPropertyBillCell *waterFees;              //水费
@property (strong, nonatomic) HXTPropertyBillCell *electricityFees;        //电费
@property (strong, nonatomic) HXTPropertyBillCell *gasFrees;               //气费
@end
