//
//  LocationManager.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


@protocol LocationManagerDelegate 
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationDidFail:(NSError *)error;
@end

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
@private    
    id<LocationManagerDelegate> delegate_;
    CLLocationManager* locationManager_;
    BOOL isStoped_;
    
}

- (void) startUpdates;
- (void) stopUpdates;

@property (nonatomic, assign) id<LocationManagerDelegate> delegate;
@property BOOL isStoped;


@end
