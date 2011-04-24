//
//  YolpSearchClient.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"


@interface YolpSearchClient : APIClient {
@private

    NSMutableArray *stock_;
}

- (void) requestStationWithLocation:(CLLocation *) location;
- (void) jsonParse;

@property (nonatomic, retain) NSMutableArray *stock;

@end
