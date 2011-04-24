//
//  HomeViewController.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"

@class YolpSearchClient, YolpPoi;

@interface HomeViewController : UIViewController <LocationManagerDelegate> {
@private
    // view
    UILabel *stationLable_;
    UILabel *locationLabel_;
    UIImageView *backImage_;
    UIButton *gachaButton_;
    // model
    YolpSearchClient *yolpClient_;
    YolpPoi *station_;
    LocationManager *locationManager_;
    
}


- (void)kickLocationUpdate;


// view
@property (nonatomic, retain) UILabel *stationLable;
@property (nonatomic, retain) UILabel *locationLabel;
@property (nonatomic, retain) UIImageView *backImage;
@property (nonatomic, retain) UIButton *gachaButton;
// model
@property (nonatomic, retain) YolpSearchClient *yolpClient;
@property (nonatomic, retain) YolpPoi *station;
@property (nonatomic, retain) LocationManager *locationManager;


@end
