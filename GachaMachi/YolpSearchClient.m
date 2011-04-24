//
//  YolpSearchClient.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import "YolpSearchClient.h"
#import "JSON.h"
#import "YolpPoi.h"

@implementation YolpSearchClient


@synthesize stock = stock_;

static NSString *API_URL = @"http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch";
static NSString *APPID = @"0IUL4NSxg660tpSsbHp4yPjvewg6NgP1pJ_PePFcEdEh5HFEGzqAAQvO2WjdutrH";

- (id)initWithDelegate:(id)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        self.stock = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void) requestStationWithLocation:(CLLocation *) location {
    NSString *urlString = [NSString stringWithFormat:@"%@?appid=%@&sort=dist&output=json&lat=%f&lon=%f&results=1&query=",
                           API_URL,
                           APPID,
                           location.coordinate.latitude,
                           location.coordinate.longitude];
    NSLog(@"%@", urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void) dealloc {
    [self.responseData release];
    if (self.stock != nil) {
        [self.stock release];
    }
    if (self.connection != nil) {
        [self.connection cancel];
        [self.connection release];
    }
    [super dealloc];
}

- (void) canncel {
    [self.connection cancel];
    self.connection = nil;
   // [self.responseData setLength:0];

}


#pragma - NSURLCOnnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
    [self.delegate connectFailed:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self jsonParse];
    [self.delegate connectFinished:connection];
    self.connection = nil;
}

#pragma -
- (void) jsonParse {
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
	NSDictionary *ret = [responseString JSONValue];
    NSArray *features =[ret objectForKey:@"Feature"];
    for (NSDictionary *feature in features) {
        YolpPoi *station = [[[YolpPoi alloc] init] autorelease];
        station.rawData = feature;
        [self.stock addObject:station];
    }
    
    [responseString release];
}

@end
