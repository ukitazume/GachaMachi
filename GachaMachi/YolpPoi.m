//
//  YolpStation.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/20.
//  Copyright 2011 none. All rights reserved.
//

#import "YolpPoi.h"


@implementation YolpPoi

@synthesize savedTime = savedTime_;
@synthesize rawData = rawData_;

- (NSString *)name {
    return [self.rawData objectForKey:@"Name"];
}
- (NSString *)uid {
    return [self.rawData objectForKey:@"Id"];
}

- (void) dealloc {
    if (self.rawData != nil) {
        self.rawData = nil;
        [self.rawData release];
    }
    [super dealloc];
}

#pragma - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.rawData forKey:@"rawData"];
	[coder encodeObject:self.savedTime forKey:@"savedTime"];
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self != nil) {
		self.rawData = [coder decodeObjectForKey:@"rawData"];
        self.savedTime = [coder decodeObjectForKey:@"savedTime"];
	}
	return self;
}

@end
