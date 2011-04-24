//
//  LocationManager.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import "LocationManager.h"


@implementation LocationManager

@synthesize delegate = delegate_;
@synthesize isStoped = isStoped_;

- (void) startUpdates {
    
    if (locationManager_)
	{
		[locationManager_ stopUpdatingLocation];
	}
	else
	{
		locationManager_ = [[CLLocationManager alloc] init];
		locationManager_.delegate = self;
		locationManager_.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	}
    [locationManager_ startUpdatingLocation];
    self.isStoped = NO;
    
    

}

- (void) stopUpdates {
    self.isStoped = YES;
    [locationManager_ stopUpdatingLocation];
}


#pragma mark - CLLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation  fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    
    if (isStoped_ == NO) {
        [self.delegate locationUpdate:newLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.delegate locationDidFail:error];
}
@end
