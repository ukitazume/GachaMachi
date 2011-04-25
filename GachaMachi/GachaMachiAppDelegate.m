//
//  GachaMachiAppDelegate.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import "GachaMachiAppDelegate.h"
#import "HomeViewController.h"
#import "HistoryTableViewController.h"
#import "SettingTableViewController.h"

@implementation GachaMachiAppDelegate


@synthesize window=_window;
@synthesize tabBarController = tabBarController_;

- (UINavigationController *)newNavigationControllerWithTopController:(Class)viewControllerClass {

	UIViewController *theViewController = [[viewControllerClass alloc] init];
	
	
	UINavigationController *theNavigationController;
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:theViewController];
   // theNavigationController.navigationBar.tintColor = [UIColor colorWithRed:0.25 green:0.75 blue:0.9 alpha:1.0];
    theNavigationController.navigationBar.tintColor = [UIColor blackColor];


	
	// and we can release the viewController because it is managed by the navigation controller
	[theViewController release];
	
	return theNavigationController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.tabBarController = [[UITabBarController alloc] init];
    NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:3];
    [localViewControllersArray autorelease];

    // 
    UINavigationController *localNavigationController;
    
    // メイン画
    localNavigationController = [[self newNavigationControllerWithTopController:[HomeViewController class]] autorelease];
	UIImage *gachaIcon = [UIImage imageNamed:@"22-skull-n-crossbones.png"];
	localNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gacha" image:gachaIcon tag:1];
    [localViewControllersArray addObject:localNavigationController];
    
    // 履歴画面
    localNavigationController = [[self newNavigationControllerWithTopController:[HistoryTableViewController class]] autorelease];
    UIImage *iconHistory = [UIImage imageNamed:@"68-paperclip.png"];
	localNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"History" image:iconHistory tag:1];
    [localViewControllersArray addObject:localNavigationController];
    
    // セッティング画面
    localNavigationController = [[self newNavigationControllerWithTopController:[SettingTableViewController class]] autorelease];
    UIImage *iconSetting = [UIImage imageNamed:@"106-sliders.png"];
	localNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Setting" image:iconSetting tag:1];
    [localViewControllersArray addObject:localNavigationController];
    
    // TabBarをメインにどうぞ
    self.tabBarController.viewControllers = localViewControllersArray;
    [self.window addSubview:self.tabBarController.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [tabBarController_ release];
    [_window release];
    [super dealloc];
}

@end
