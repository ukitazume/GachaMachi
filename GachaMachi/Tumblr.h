//
//  Tumblr.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YolpPoi;

@interface Tumblr : NSObject <NSCoding> {
    NSDictionary *rawData_;
    YolpPoi *poi_;
    NSDate *date_;
    UIImage *icon_;
}

- (NSURL *)photoUrl;
- (NSData *)photoData;
- (UIImage *)photoImage;

- (NSURL *)photoTumbUrl;
- (NSData *)photoTumbData;
- (NSString *)caption;

@property (nonatomic, retain) NSDictionary *rawData;
@property (nonatomic, retain) YolpPoi *poi;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) UIImage *icon;

//@property (nonatomic, readonly) NSString *caption;
@end
