//
//  ButlerCardTests.m
//  ButlerCardTests
//
//  Created by johnny tang on 2/19/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworking.h"

@interface ButlerCardTests : XCTestCase

@end

@implementation ButlerCardTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    [super tearDown];
}

- (void)testAFNetworkReachability {
    XCTAssertFalse([AFNetworkReachabilityManager sharedManager].isReachable, @"network is not reachable");
}

@end
