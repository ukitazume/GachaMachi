//
//  HomeViewController.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import "HomeViewController.h"
#import "YolpSearchClient.h"
#import "YolpPoi.h"
#import "History.h"
#import "HitViewController.h"

@implementation HomeViewController

// view
@synthesize stationLable = stationLable_;
@synthesize locationLabel = locationLabel_;
@synthesize gachaButton = gachaButton_;
@synthesize backImage = backImage_;

// model
@synthesize station = station_;
@synthesize yolpClient = yolpClient_;
@synthesize locationManager = locationManager_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.locationManager = [[[LocationManager alloc] init] autorelease];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [self.stationLable release];
    [self.gachaButton release];
    [self.locationLabel release];
    [self.locationManager release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)kickLocationUpdate {
    self.gachaButton.hidden = YES;
    [self.locationManager startUpdates];
}

#pragma mark - View lifecycle
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    NSLog(@"load");
   // [self.locationManager startUpdates];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"will appeare");
    self.gachaButton.hidden = YES;
    self.yolpClient = [[[YolpSearchClient alloc] initWithDelegate:self] autorelease];
    [self.locationManager startUpdates];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"will disappear");
    [self.locationManager stopUpdates];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    UIImage *overImage = [UIImage imageNamed:@"bg01.png"];
    self.backImage = [[UIImageView alloc] initWithImage:overImage];
    [self.backImage sizeToFit];
    self.backImage.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.backImage];
    
    // 駅名
    self.stationLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 400)] autorelease];
    self.stationLable.text = @"現在地を取得しています";
    self.stationLable.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.stationLable];
    
    // ガチャボタン
    self.gachaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"btn_gacha2.png"];
	[self.gachaButton setImage:buttonImage forState:UIControlStateNormal];
    [self.gachaButton setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
    self.gachaButton.center = self.view.center;
    [self.gachaButton addTarget:self action:@selector(gacha) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.gachaButton];

    
    // 緯度経度
	CGRect rLocation = CGRectMake(0, 30, self.view.frame.size.width, 30);
	self.locationLabel = [[[UILabel alloc] initWithFrame:rLocation] autorelease];
	self.locationLabel.backgroundColor = [UIColor clearColor];
	self.locationLabel.font = [UIFont boldSystemFontOfSize:10.0];
    self.locationLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.locationLabel];
    
    // リロード
    UIImage *locationImage = [UIImage imageNamed:@"shiro74-location.png"];
	UIBarButtonItem *refreshButton = [[[UIBarButtonItem alloc] initWithImage:locationImage style:UIBarButtonItemStyleBordered target:self action:@selector(kickLocationUpdate)] autorelease];
	self.navigationItem.leftBarButtonItem = refreshButton;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"unload");
    self.stationLable = nil;
    self.gachaButton = nil;
    self.locationLabel = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma - YolpSearchClient delegate
- (void)connectFinished:(NSURLConnection *)connection {
    if ([self.yolpClient.stock count] > 0) {
        self.station = [self.yolpClient.stock objectAtIndex:0];
        self.stationLable.text = self.station.name;
        self.gachaButton.hidden = NO;
    } else {
        self.stationLable.text = @"ガチャがありません";
    }
    
}

- (void)connectFailed:(NSError *)error {
    
}

#pragma - LocationManager delegate
- (void)locationUpdate:(CLLocation *)location {
    self.stationLable.text = @"近くのガチャを探しています";
    NSDate *date = location.timestamp;
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setTimeStyle:NSDateFormatterMediumStyle];
	NSString *dateString = [formatter stringFromDate:date];
    self.locationLabel.text = [NSString stringWithFormat:@"%f %f GPS %@  精度:%0.1fm", location.coordinate.latitude, location.coordinate.longitude, dateString, location.horizontalAccuracy];
    [self.yolpClient requestStationWithLocation:location];
    [self.locationManager stopUpdates];
}

- (void)locationDidFail:(NSError *)error {
    NSLog(@"cannt");
}

#pragma - Original
-(void) gacha {
    HitViewController *hitController = [[[HitViewController alloc] init] autorelease];
    hitController.poi = self.station;
    [self.navigationController pushViewController:hitController animated:YES];
}

@end
