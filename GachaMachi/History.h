//
//  History.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Tumblr;

@interface History : NSObject {
    
}
+ (void) save:(Tumblr *)station;
+ (NSArray *) collection;
+ (void) deleteAll;
+ (void) deleteAtIndex:(NSInteger)index;
 
@end
