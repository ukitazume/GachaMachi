//
//  GachaMachiAppDelegate.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GachaMachiAppDelegate : NSObject <UIApplicationDelegate> {
@private
    UITabBarController *tabBarController_;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

@end
