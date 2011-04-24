//
//  History.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import "History.h"
#import "Tumblr.h"

@implementation History

+ (void) save:(Tumblr *)station {
	
    NSArray *collection = [[NSUserDefaults standardUserDefaults] objectForKey: @"history"];
	NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithArray:collection];
	[tmpArr addObject:[NSKeyedArchiver archivedDataWithRootObject:station]]; 
	
	[[NSUserDefaults standardUserDefaults] setObject:tmpArr forKey:@"history"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[tmpArr release];
	
}

+ (NSArray *) collection {
    NSArray *collection = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[collection count]];
    for (NSData *data in collection) {
        [array addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    return array;
}

+ (void)deleteAll {
    NSArray *empty =[NSArray array];
    [[NSUserDefaults standardUserDefaults] setObject:empty forKey:@"history"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) deleteAtIndex:(NSInteger)index {
    NSArray *collection = [[NSUserDefaults standardUserDefaults] objectForKey: @"history"];
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithArray:collection];
	[tmpArr removeObjectAtIndex:index]; 
	
	[[NSUserDefaults standardUserDefaults] setObject:tmpArr forKey:@"history"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[tmpArr release];

}

@end
