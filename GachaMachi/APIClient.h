//
//  APIClient.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIClientDelegate 
@required
- (void)connectFinished:(NSURLConnection *)connection;
- (void)connectFailed:(NSError *)error;
@end

@interface APIClient : NSObject {
    NSMutableData *responseData_;
    id<APIClientDelegate> delegate_;
    NSURLConnection *connection_;
}

- (id)initWithDelegate:(id)delegate;
- (void)canncel;

@property (nonatomic, assign) id<APIClientDelegate> delegate;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *responseData;

@end
