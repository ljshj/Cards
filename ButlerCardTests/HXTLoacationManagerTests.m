//
//  HXTLoacationManagerTests.m
//  ButlerCard
//
//  Created by johnny tang on 3/26/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HXTLocationManager.h"

@interface HXTLoacationManagerTests : XCTestCase

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *addr;
@property (assign, nonatomic) float latitude;
@property (assign, nonatomic) float longitude;

@end

@implementation HXTLoacationManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _city = nil;
    _addr = nil;
    _latitude = 0.0f;
    _longitude = 0.0f;
    
    [super tearDown];
}

/*
- (void)testLocationCoordinate {
    __block __weak HXTLoacationManagerTests *loacationManagerTests = self;
    [[HXTLocationManager sharedLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        loacationManagerTests.latitude  = locationCorrrdinate.latitude;
        loacationManagerTests.longitude = locationCorrrdinate.longitude;
    }];
    
    NSLog(@"latitude ＝ %f, longitude = %f",_latitude, _longitude);
    XCTAssertFalse(fabs(_latitude - 30.5f) > 0.1f || fabs(_longitude - 104.0f) > 0.1f, @"locationCorrrdinate out of range!");
}

- (void)testCity {
    __block __weak HXTLoacationManagerTests *loacationManagerTests = self;
    [[HXTLocationManager sharedLocation] getCity:^(NSString *addressString) {
        loacationManagerTests.city = addressString;
    }];
    
    NSLog(@"city = %@", _city);
    XCTAssertNotNil(_city, @"cant find address");
}

- (void)testAddr {
    __block __weak HXTLoacationManagerTests *loacationManagerTests = self;
    [[HXTLocationManager sharedLocation] getAddress:^(NSString *addressString) {
        loacationManagerTests.addr = addressString;
    }];
    
    XCTAssertNotNil(_addr, @"cant find address");
}
 */
@end
