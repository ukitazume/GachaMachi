//
//  HitViewController.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/21.
//  Copyright 2011 none. All rights reserved.
//

#import "DetailViewController.h"
#import "TumblrClient.h"
#import "Tumblr.h"
#import "YolpPoi.h"
#import "History.h"


@implementation DetailViewController

@synthesize tumblrClient = tumblrClient_;
@synthesize poi = poi_;
@synthesize tumblr = tumblr_;

@synthesize scrollView = scrollView_;
@synthesize photoFlame = photoFlame_;
@synthesize poiInfo = poiInfo_;
@synthesize photoWeb = photoWeb_;
@synthesize captionWeb = captionWeb_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tumblrClient = [[[TumblrClient alloc] initWithDelegate:self] autorelease];
    }
    return self;
}

- (void)dealloc
{
    [self.scrollView release];
    [self.photoFlame release];
    [self.photoWeb release];
    [self.poiInfo release];
    [self.tumblrClient release];
    [self.tumblr release];
    [self.poi release];
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

- (void) viewDidDisappear:(BOOL)animated {
    [self.tumblrClient canncel];
    [self.photoWeb stopLoading];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView = [[[UIScrollView alloc] init] autorelease];
	self.scrollView.frame = self.view.bounds;
	self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0 green:0.69 blue:0.42 alpha:1.0];


    [self.view addSubview:self.scrollView];
    
    self.photoFlame = [[UILabel alloc] initWithFrame:CGRectMake(1, 5, 310, 500)];
    self.photoFlame.center = self.view.center;
    self.photoFlame.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.scrollView addSubview:self.photoFlame];
    
    self.photoWeb = [[[UIWebView alloc] initWithFrame:CGRectMake(5, 5, 300, 500)] autorelease];
    self.photoWeb.delegate = self;
    [self.photoFlame addSubview:self.photoWeb];
    
    self.poiInfo = [[[UILabel alloc] init] autorelease];
    self.poiInfo.text = [self.poi name];
    [self.photoFlame addSubview:self.poiInfo];
    
    /* caption
    self.captionWeb = [[[UIWebView alloc] initWithFrame:CGRectMake(5, 3, 300, 500)] autorelease];
    self.captionWeb.delegate = self;
    self.captionWeb.backgroundColor = [UIColor clearColor];
    [self.photoFlame addSubview:self.captionWeb];
     */
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.photoFlame = nil;
    self.photoWeb = nil;
    self.poiInfo = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma - YolpSearchClient delegate
- (void)connectFinished:(NSURLConnection *)connection {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([webView isEqual:self.photoWeb]) {
        NSInteger height, width, marginX;
        height = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"photo\").offsetHeight;"] integerValue];
        width = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"photo\").offsetWidth;"] integerValue];
        if (width < self.photoWeb.frame.size.width) {
            marginX = (self.photoFlame.frame.size.width - width)/2;
        }
        else {
            marginX = 5;
        }
        self.photoWeb.frame = CGRectMake(marginX, 5, width, height);
        self.poiInfo.frame = CGRectMake(5, self.photoWeb.bounds.size.height, 300, 30);
        
        
        self.photoFlame.frame = CGRectMake(self.photoFlame.frame.origin.x,
                                           self.photoFlame.frame.origin.y,
                                           self.photoFlame.frame.size.width,
                                           self.photoWeb.frame.size.height + 100);
        
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.photoFlame.frame.size.height + 20);
        self.scrollView.center = self.view.center;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.photoWeb stopLoading];
}

- (void)connectFailed:(NSError *)error {

}

@end
