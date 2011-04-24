//
//  ThumblrClient.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"

@interface TumblrClient : APIClient {
@private
    NSMutableArray *stock_;
}

- (void)requestRandam;
- (void)jsonParse;

@property (nonatomic, retain) NSMutableArray *stock;
@end
