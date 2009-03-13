//
//  RootViewController.m
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "RootViewController.h"
#import "HantecAppDelegate.h"
#import "HDictionaryCell.h"


@implementation RootViewController

@synthesize tableView = _tableView;
@synthesize searchBar = _searchBar;
@synthesize tabBar = _tabBar;

- (void)awakeFromNib {
	NSString *dictFileName;
	if (_isFromOriginalDict) {
		dictFileName = @"dict";
	} else {
		dictFileName = @"dict-reverse";
	}
	_dataBySections = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:dictFileName ofType:@"plist"]] retain];
	
	_filteredListContent = [[NSMutableArray alloc] init];
	_useFilteredList = NO;
	
	// don't get in the way of user typing
	_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.showsCancelButton = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (_useFilteredList) {
		return 1;
	}
	
    return [_dataBySections count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (_useFilteredList) {
		return [_filteredListContent count];
	}
	
    return [[[_dataBySections objectAtIndex: section] objectForKey:kSectionData] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (_useFilteredList) {
		return @"";
	}
	
	return [[_dataBySections objectAtIndex: section] objectForKey:kSectionName];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	if (_useFilteredList) {
		return [NSArray array];
	}
	
	NSMutableArray *sections = [[NSMutableArray alloc] initWithCapacity:[_dataBySections count]];
	
	for (NSDictionary *sectionDict in _dataBySections) {
		[sections addObject:[sectionDict objectForKey:kSectionName]];
	}
	
	return [sections autorelease];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
    static NSString *CellIdentifier = @"HDictionaryCell";
    
    _cell = (HDictionaryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (_cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"HDictionaryCell" owner:self options:nil];
    }
	
    NSDictionary *dictionaryItem;
	if (_useFilteredList) {
		dictionaryItem = [_filteredListContent objectAtIndex: indexPath.row];
	} else {
		dictionaryItem = [[[_dataBySections objectAtIndex: indexPath.section] objectForKey:kSectionData] objectAtIndex: indexPath.row];
	}
	
	[_cell setCellOriginal:[dictionaryItem objectForKey:kOriginal]
			andTranslation:[dictionaryItem objectForKey:kTranslation]];
	
	return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[_dataBySections release];
	
    [super dealloc];
}

#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	_searchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	_searchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[_filteredListContent removeAllObjects];
	
	if ([searchText length] == 0) {
		_useFilteredList = NO;
		[_tableView reloadData];
		return;
	}
	
	_useFilteredList = YES;
	
	NSDictionary *section;
	NSDictionary *dictionaryItem;
	NSString *cellTitle;
	for (section in _dataBySections) {
		for (dictionaryItem in [section objectForKey:kSectionData]) {
			cellTitle = [dictionaryItem objectForKey:kOriginal];
			
			NSComparisonResult result = [cellTitle compare:searchText
												   options:NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch
													 range:NSMakeRange(0, [searchText length])];
			
			if (result == NSOrderedSame) {
				[_filteredListContent addObject:dictionaryItem];
			}
		}
	}
	
	[_tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[_filteredListContent removeAllObjects];
	_useFilteredList = NO;
	
	[_tableView reloadData];
	[_searchBar resignFirstResponder];
	_searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
}


@end