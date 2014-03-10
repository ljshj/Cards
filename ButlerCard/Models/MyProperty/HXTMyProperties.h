//
//  HXTMyProperties.h
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTMyProperties : NSObject

@property (strong, nonatomic) NSArray *housingEstateNames;
@property (strong, nonatomic) NSArray *myHousingEstate;

+ (HXTMyProperties *)sharedInstance;
@end
