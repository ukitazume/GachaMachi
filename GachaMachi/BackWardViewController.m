//
//  BackWardViewController.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/24.
//  Copyright 2011 none. All rights reserved.
//

#import "BackWardViewController.h"
#import "Tumblr.h"

@implementation BackWardViewController

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
    NSString *html = [NSString stringWithFormat:@"<style type=\"text/css\">* {margin:0px; padding:0px;}</style><img id=\"photo\" align=\"center\" width=\"300px\" src=\"%@\">", self.tumblr.photoUrl];
    [self.photoWeb loadHTMLString:html baseURL:nil];

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

@end
