//
//  HitViewController.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TumblrClient.h"

@class YolpPoi, Tumblr;

@interface DetailViewController : UIViewController <APIClientDelegate, UIWebViewDelegate> {
@private
    TumblrClient *tumblrClient_;
    YolpPoi *poi_;
    Tumblr *tumblr_;
    
    // view
    UIScrollView *scrollView_;
    UILabel *photoFlame_;
    UILabel *poiInfo_;
    UIWebView *photoWeb_;
    UIWebView *captionWeb_;
    
    
}

@property (nonatomic, retain) TumblrClient *tumblrClient;
@property (nonatomic, retain) YolpPoi *poi;
@property (nonatomic, retain) Tumblr *tumblr;

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *photoFlame;
@property (nonatomic, retain) UILabel *poiInfo;
@property (nonatomic, retain) UIWebView *photoWeb;
@property (nonatomic, retain) UIWebView *captionWeb;

@end    
