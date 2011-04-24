//
//  Tumblr.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import "Tumblr.h"
#import "YolpPoi.h"

@implementation Tumblr

@synthesize rawData = rawData_;
@synthesize poi = poi_;
@synthesize date = date_;
@synthesize icon = icon_;


- (NSURL *)photoUrl {
    NSString *string = [self.rawData objectForKey:@"photo-url-400"];
    return [NSURL URLWithString:string];
}

- (NSURL *)photoTumbUrl {
    NSString *string = [self.rawData objectForKey:@"photo-url-75"];
    return [NSURL URLWithString:string];
}

- (NSString *)caption {
    NSLog(@"%@", self.rawData);
    NSString *string = [self.rawData objectForKey:@"photo-caption"];
    return string;
}

- (NSData *)photoData {
    return [NSData dataWithContentsOfURL:self.photoUrl];
}

- (NSData *)photoTumbData {
    return [NSData dataWithContentsOfURL:self.photoTumbUrl];
}

- (UIImage *)photoImage {
    return [UIImage imageWithData:self.photoData];
}

- (void) dealloc {
    [self.rawData release];
    [self.poi release];
    [self.date release];
    
    [super dealloc];
}

#pragma - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.rawData forKey:@"rawData"];
    [coder encodeObject:self.poi forKey:@"poi"];
	[coder encodeObject:self.date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self != nil) {
		self.rawData = [coder decodeObjectForKey:@"rawData"];
        self.poi = [coder decodeObjectForKey:@"poi"];
        self.date = [coder decodeObjectForKey:@"date"];
	}
	return self;
}
@end
