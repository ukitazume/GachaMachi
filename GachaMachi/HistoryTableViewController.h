//
//  HistoryTableViewController.h
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@interface HistoryTableViewController : UITableViewController <UIScrollViewDelegate, IconDownloaderDelegate> {
@private
    NSMutableArray *collection_;
    NSMutableDictionary *iconDownloadsInProgress_;
}

@property (nonatomic, retain) NSMutableArray *collection;
@property (nonatomic, retain) NSMutableDictionary *iconDownloadsInProgress;

- (void)loadImagesForOnscreenRows;
- (void)startIconDownload:(Tumblr *)tumblr forIndexPath:(NSIndexPath *)indexPath;

@end
