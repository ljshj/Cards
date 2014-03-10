//
//  HXTMyPropertyModel.h
//  ButlerCard
//
//  Created by johnny tang on 3/10/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXTMyPropertyModel : NSObject

@property (strong, nonatomic) NSArray *housingEstateNames;

+ (HXTMyPropertyModel *)sharedInstance;
@end
