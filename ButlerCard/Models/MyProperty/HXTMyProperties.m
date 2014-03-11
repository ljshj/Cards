//
//  HXTMyProperties.m
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTMyProperties.h"
#import "HXTPropertyCell.h"

@implementation HXTMyProperties

- (id) init {
    self = [super init];
    if (self) {
        _properties = [[NSMutableArray alloc] initWithCapacity:0];
        _allHousingEstateNames = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

+ (HXTMyProperties *)sharedInstance {
    static HXTMyProperties *myProprtyModel;
    if (!myProprtyModel) {
        myProprtyModel = [[HXTMyProperties alloc] init];
        [myProprtyModel.allHousingEstateNames addObjectsFromArray:@[@"中铁八局", @"万科A小区", @"置信A区", @"华润AA",
                                                                   @"保利别墅A", @"恒大宅院", @"万达高层", @"置信B区",
                                                                   @"华润凤凰城", @"万科V地", @"保利商业", @"中铁Q区",
                                                                    @"小区13", @"小区14", @"小区15", @"小区16"]];
        
        HXTPropertyCell * propertyA = [[HXTPropertyCell alloc] init];
        propertyA.house.housingEstatename = @"中铁八局";
        propertyA.house.buildingNo = 1;
        propertyA.house.unitNo = 2;
        propertyA.house.roomNo = 302;
        propertyA.propertyManagementFees.money = 120;
        propertyA.propertyManagementFees.bindCard = YES;
        propertyA.parkingFees.money = -200;
        propertyA.parkingFees.bindCard = YES;
        propertyA.waterFees.money = 400;
        propertyA.waterFees.bindCard = YES;
        propertyA.electricityFees.money = -500;
        propertyA.electricityFees.bindCard = YES;
        propertyA.gasFrees.money = 0;
        propertyA.gasFrees.bindCard = NO;
        
        [myProprtyModel.properties addObject:propertyA];
        
        propertyA = [[HXTPropertyCell alloc] init];
        propertyA.house.housingEstatename = @"万科A小区";
        propertyA.house.buildingNo = 2;
        propertyA.house.unitNo = 3;
        propertyA.house.roomNo = 301;
        propertyA.propertyManagementFees.money = 220.1;
        propertyA.propertyManagementFees.bindCard = YES;
        propertyA.parkingFees.money = -300.23;
        propertyA.parkingFees.bindCard = YES;
        propertyA.waterFees.money = 400;
        propertyA.waterFees.bindCard = YES;
        propertyA.electricityFees.money = -500;
        propertyA.electricityFees.bindCard = NO;
        propertyA.gasFrees.money = 0;
        propertyA.gasFrees.bindCard = NO;
        
        [myProprtyModel.properties addObject:propertyA];
    }
    
    return myProprtyModel;
}

@end
