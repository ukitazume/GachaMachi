//
//  SettingTableViewController.m
//  GachaMachi
//
//  Created by kitazume yu on 11/04/19.
//  Copyright 2011 none. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AboutViewContoller.h"
#import "History.h"

@implementation SettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"self %@", self);

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
		return 1;
	}
	else if (section == 1) {
		return 1;
	}
	else if (section == 2) {
		return 1;
	}
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Twitterアカウント";
	}
	else if (section == 1) {
		return @"データのリセット";
	}
	else if (section == 2) {
		return @"";
	}
	return @"";
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SettingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			cell.textLabel.text = @"設定する";
		} else if (indexPath.row == 1){
			cell.textLabel.text = @"リセット";
		}
	}
	else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			cell.textLabel.text = @"リセットする";
		}
		else if (indexPath.row == 1) {
			cell.textLabel.text = @"";	
		}
	}
	else if (indexPath.section == 2) {
		cell.textLabel.text = @"遊び方をみる";
	}
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	//cell.detailTextLabel.text = @"test";
	
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {

        }
	}
	else if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			UIAlertView *resetAlert = [[[UIAlertView alloc] init] autorelease];
			resetAlert.delegate = self;
			resetAlert.title = @"データのリセットする";
			resetAlert.message = @"ガチャ回数と、これまでの履歴がリセットされます。";
			[resetAlert addButtonWithTitle:@"キャンセル"];
			[resetAlert addButtonWithTitle:@"OK"];
			resetAlert.cancelButtonIndex = 0;
			[resetAlert show];
		}
	}
	else if (indexPath.section == 2) {
		UIViewController *aboutView = [[[AboutViewContoller alloc] init] autorelease];
		[self.navigationController pushViewController:aboutView animated:YES];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[History deleteAll];
	}
}
@end
