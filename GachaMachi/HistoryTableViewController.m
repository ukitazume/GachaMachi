//
//  HistoryTableViewController.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "History.h"
#import "Tumblr.h"
#import "YolpPoi.h"
#import "IconDownloader.h"
#import "BackWardViewController.h"

@implementation HistoryTableViewController

@synthesize collection = collection_;
@synthesize iconDownloadsInProgress = iconDownloadsInProgress_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [self.collection release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 75;
    [self.tableView setEditing:NO animated:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.collection = nil;
    self.iconDownloadsInProgress = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collection = [NSMutableArray arrayWithArray:[History collection]];
    self.iconDownloadsInProgress = [NSMutableDictionary dictionaryWithCapacity:10];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // Return the number of rows in the section.
    return [self.collection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    // customize the appearance of table view cells
	//
	static NSString *CellIdentifier = @"LazyTableCell";
    static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";
    
    // add a placeholder cell while waiting on table data
    int nodeCount = [self.collection count];
	
	if (nodeCount == 0 && indexPath.row == 0)
	{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        if (cell == nil)
		{
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
										   reuseIdentifier:PlaceholderCellIdentifier] autorelease];   
            cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
		cell.detailTextLabel.text = @"Loading…";
		
		return cell;
    }
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Leave cells empty if there's no data yet
    if (nodeCount > 0)
	{

        // Configure the cell...
        Tumblr *tumblr = [self.collection objectAtIndex:indexPath.row];
        cell.textLabel.text = tumblr.poi.name;

       // cell.detailTextLabel.text = tumblr.artist;
		
        // Only load cached images; defer new downloads until scrolling ends
        if (!tumblr.icon)
        {
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
            {
                [self startIconDownload:tumblr forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            cell.imageView.image = [UIImage imageNamed:@"icon_load.png"];                
        }
        else
        {
            cell.imageView.image = tumblr.icon;
        }
        
    }
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.collection removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [History deleteAtIndex:indexPath.row];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    BackWardViewController *backController = [[[BackWardViewController alloc] init] autorelease];
    backController.tumblr = [self.collection objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:backController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma -  IconDownloader delegate
- (void)iconImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [self.iconDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)  {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        
        // Display the newly loaded image
        cell.imageView.image = iconDownloader.tumblr.icon;
    }
}

#pragma mark - UIScrollViewDelegate

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


#pragma -  DownLoad Icon
- (void)loadImagesForOnscreenRows
{
    if ([self.collection count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            Tumblr *tumblr = [self.collection objectAtIndex:indexPath.row];
            
            if (!tumblr.icon) // avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:tumblr forIndexPath:indexPath];
            }
        }
    }
}


- (void)startIconDownload:(Tumblr *)tumblr forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [self.iconDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.tumblr = tumblr;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [self.iconDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];   
    }
}

@end
