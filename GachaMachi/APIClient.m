//
//  APIClient.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import "APIClient.h"


@implementation APIClient

@synthesize delegate = delegate_;
@synthesize connection = connection_;
@synthesize responseData = responseData_;


- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        self.responseData = [NSMutableData data];
        self.delegate = delegate;
    }
    return self;
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
    [self.delegate connectFinished:connection];
    self.connection = nil;
}

@end
