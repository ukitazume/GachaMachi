//
//  HitViewController.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/24.
//  Copyright 2011 none. All rights reserved.
//

#import "HitViewController.h"
#import "Tumblr.h"
#import "History.h"

@implementation HitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tumblrClient requestRandam];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)connectFinished:(NSURLConnection *)connection {
    
    // ガチャの確定
    Tumblr *tumblr = [self.tumblrClient.stock objectAtIndex:0];
    tumblr.poi = self.poi;
    [History save:tumblr];
    
    NSString *html = [NSString stringWithFormat:@"<style type=\"text/css\">* {margin:0px; padding:0px;}</style><img id=\"photo\" align=\"center\" width=\"300px\" src=\"%@\">", tumblr.photoUrl];
    [self.photoWeb loadHTMLString:html baseURL:nil];
    
    /*
     html = [NSString stringWithFormat:@"<div id=\"caption\">%@</div>", tumblr.caption];
     [self.captionWeb loadHTMLString:tumblr.caption baseURL:nil];
     */
}

@end
