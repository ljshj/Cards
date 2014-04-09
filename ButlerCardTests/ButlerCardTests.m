//
//  ButlerCardTests.m
//  ButlerCardTests
//
//  Created by johnny tang on 2/19/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import <XCTest/XCTest.h>
<<<<<<< HEAD
#import "AFNetworking.h"
=======
>>>>>>> FETCH_HEAD

@interface ButlerCardTests : XCTestCase

@end

@implementation ButlerCardTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
<<<<<<< HEAD
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
=======
>>>>>>> FETCH_HEAD
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
<<<<<<< HEAD
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    [super tearDown];
}

- (void)testAFNetworkReachability {
    XCTAssertFalse([AFNetworkReachabilityManager sharedManager].isReachable, @"network is not reachable");
=======
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
>>>>>>> FETCH_HEAD
}

@end
