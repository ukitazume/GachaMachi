//
//  YolpStation.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/20.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YolpPoi : NSObject <NSCoding> {
@private
    NSDictionary *rawData_;
    NSDate *savedTime_;
}

- (NSString *)name;
- (NSString *)uid;

@property (nonatomic, retain) NSDictionary *rawData;
@property (nonatomic, retain) NSDate *savedTime;

@end
