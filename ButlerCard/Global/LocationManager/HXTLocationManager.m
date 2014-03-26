//
//  HXTLocationManager.m
//  ButlerCard
//
//  Created by johnny tang on 3/26/14.
//  Copyright (c) 2014 johnny tang. All rights reserved.
//

#import "HXTLocationManager.h"

@interface HXTLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, assign) CLLocationCoordinate2D lastCoordinate;
@property (nonatomic, strong) NSString *lastCity;
@property (nonatomic, strong) NSString *lastAddress;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation HXTLocationManager

+ (instancetype)sharedLocation;
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        
        float longitude = [standard floatForKey:kLastLongitude];
        float latitude = [standard floatForKey:kLastLatitude];
        self.longitude = longitude;
        self.latitude = latitude;
        self.lastCoordinate = CLLocationCoordinate2DMake(longitude,latitude);
        self.lastCity = [standard objectForKey:kLastCity];
        self.lastAddress=[standard objectForKey:kLastAddress];
    }
    return self;
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock
{
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getAddress:(NSStringBlock)addressBlock
{
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock
{
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock error:(LocationErrorBlock) errorBlock
{
    self.cityBlock = [cityBlock copy];
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

#pragma mark - CLLocationManager delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    self.lastCoordinate = newLocation.coordinate;
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    
    [standard setObject:@(self.lastCoordinate.latitude) forKey:kLastLatitude];
    [standard setObject:@(self.lastCoordinate.longitude) forKey:kLastLongitude];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks,NSError *error) {
                       for (CLPlacemark * placeMark in placemarks)
                       {
                           self.lastCity = placeMark.locality;
                           self.lastAddress = placeMark.name;
                           
                           [standard setObject:self.lastCity forKey:kLastCity];
                           [standard setObject:self.lastAddress forKey:kLastAddress];
                           
                           NSLog(@"%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, placeMark.addressDictionary);
                           
                           [self stopLocation];
                       }
                       
                       if (_cityBlock) {
                           _cityBlock(_lastCity);
                           _cityBlock = nil;
                       }
                       
                       if (_locationBlock) {
                           _locationBlock(_lastCoordinate);
                           _locationBlock = nil;
                       }
                       
                       if (_addressBlock) {
                           _addressBlock(_lastAddress);
                           _addressBlock = nil;
                       }
                       
                       [[NSUserDefaults standardUserDefaults] synchronize];
                   }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%s %s %d %@", __FILE__, __FUNCTION__, __LINE__, [error localizedDescription]);
    if (_errorBlock) {
        _errorBlock(error);
        _errorBlock = nil;
    }
    
    [self stopLocation];
}

#pragma mark - location functions

-(void)startLocation
{
    if (_locationManager) {
        _locationManager = nil;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 1000.0f;
    [_locationManager startUpdatingLocation];
}

-(void)stopLocation
{
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}

@end
