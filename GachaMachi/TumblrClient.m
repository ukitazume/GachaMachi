//
//  ThumblrClient.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import "TumblrClient.h"
#import "JSON.h"
#import "Tumblr.h"


@implementation TumblrClient

@synthesize stock = stock_;

static NSString *API_URL = @"http://kyahhoi.tumblr.com/api/read/json";

- (id)initWithDelegate:(id)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        self.stock = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void) dealloc {
    [self.stock release];
    [super dealloc];
}

- (void)requestRandam {
    // 乱数
	srand(time(NULL));
	int r = rand() % 300;
	NSInteger start = r;
    
	// URLを指定する
	NSString *urlString = [NSString stringWithFormat:
						   @"%@?type=photo&start=%i&num=1&debug=1",
						   API_URL, start];
    NSLog(@"%@", urlString);

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
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
    if ([self.stock count] > 0 && self.connection) {
        [self.delegate connectFinished:connection];
    }
    else {
        [self connection:connection didFailWithError:[NSError errorWithDomain:@"tubler" code:500 userInfo:nil]];
    }
    self.connection = nil;
}

#pragma -
- (void) jsonParse {
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *photo = [responseString JSONValue];
    NSDictionary *posts = [photo objectForKey:@"posts"];
    for (NSDictionary *post in posts) {
        Tumblr *tumblr = [[[Tumblr alloc] init] autorelease];
        tumblr.rawData = post;
        tumblr.date = [NSDate date];
        [self.stock addObject:tumblr];
    }
    
    [responseString release];
    
}
@end
