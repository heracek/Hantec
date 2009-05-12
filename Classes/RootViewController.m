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
#import "HWordDetails.h"

@implementation RootViewController

@synthesize tableView = _tableView;
@synthesize searchBar = _searchBar;
@synthesize tabBar = _tabBar;

- (void)awakeFromNib {
	_filteredListContent = [[NSMutableArray alloc] init];
	_useFilteredList = NO;
	_showSectionIndex = YES;
	
	// don't get in the way of user typing
	_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.showsCancelButton = NO;
}

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
	if (_useFilteredList || _showSectionIndex == NO) {
		return [NSArray array];
	}
	
	NSMutableArray *sections = [[NSMutableArray alloc] initWithCapacity:[_dataBySections count]];
	
	for (NSDictionary *sectionDict in _dataBySections) {
		[sections addObject:[sectionDict objectForKey:kSectionName]];
	}
	
	return [sections autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGRect bounds = [UIScreen mainScreen].bounds;
	CGFloat cellWidth = (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) ? bounds.size.width : bounds.size.height;
	NSDictionary *dictionaryItem;
	if (_useFilteredList) {
		dictionaryItem = [_filteredListContent objectAtIndex: indexPath.row];
	} else {
		dictionaryItem = [[[_dataBySections objectAtIndex: indexPath.section] objectForKey:kSectionData] objectAtIndex: indexPath.row];
		if (_showSectionIndex) {
			cellWidth -= 40;
		}
	}
	
	NSString *originalText = [dictionaryItem objectForKey:kOriginal];
	NSString *translationText = [dictionaryItem objectForKey:kTranslation];
	
	CGFloat originalWidth = cellWidth - 30;
	CGFloat translationWidth = cellWidth - 40;
	
	
	CGSize originalConstrainedToSize = {originalWidth, 20000.0f};
	CGSize sizeOfOriginal = [originalText sizeWithFont:[UIFont boldSystemFontOfSize:17.0f]
									 constrainedToSize:originalConstrainedToSize];
	
	CGSize translationConstrainedToSize = {translationWidth, 20000.0f};
	CGSize sizeOfTranslation = [translationText sizeWithFont:[UIFont systemFontOfSize:17.0f]
										   constrainedToSize:translationConstrainedToSize];
	
	
	CGFloat additionaHeight = 0;
	if (_selectRowIndexPath != nil &&
		_selectRowIndexPath.section == indexPath.section &&
		_selectRowIndexPath.row == indexPath.row) {
		additionaHeight = 10;
	}
	return sizeOfOriginal.height + sizeOfTranslation.height + 3 + additionaHeight;
}

- (NSDictionary *)getDictionaryItemForIndexPath:(NSIndexPath *)indexPath {
	if (_useFilteredList) {
		return [_filteredListContent objectAtIndex: indexPath.row];
	} else {
		return [[[_dataBySections objectAtIndex: indexPath.section] objectForKey:kSectionData] objectAtIndex: indexPath.row];
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
    static NSString *CellIdentifier = @"HDictionaryCell";
	CGRect bounds = [UIScreen mainScreen].bounds;
	CGFloat cellWidth = (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) ? bounds.size.width : bounds.size.height;
	
    _cell = (HDictionaryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (_cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"HDictionaryCell" owner:self options:nil];
    }
	
    NSDictionary *dictionaryItem = [self getDictionaryItemForIndexPath:indexPath];
	if ( ! _useFilteredList && _showSectionIndex) {
		cellWidth -= 40;
	}
	
	[_cell setCellOriginal:[dictionaryItem objectForKey:kOriginal]
			   translation:[dictionaryItem objectForKey:kTranslation]
				 cellWidht:cellWidth
				 andIsEven:indexPath.row % 2];
	
	//#BD D5 FC
	_cell.backgroundColor = [UIColor colorWithRed:0xBD / 256.
											green:0xD5 / 256.
											 blue:0xFC / 256.
											alpha:0.5];
	
	return _cell;
}

- (void)dealloc {
	[_dataBySections release];
	
    [super dealloc];
}

- (void)hideIndexAndMoveTableUp:(BOOL)hide {
	CGRect rect = self.tableView.frame;
	rect.size.height += (hide) ? -167 : +167;
	
	UITableView *tableView = self.tableView;
	//[UIView beginAnimations:nil context:nil];
	
	
	
	NSObject <NonPublicTableViewMethods> *noCompilerWarningTableView \
		= (NSObject <NonPublicTableViewMethods> *)tableView;
	[noCompilerWarningTableView setIndexHidden:hide animated:YES];
	
	
	
	//[UIView commitAnimations];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	self.tableView.frame = rect;
	[UIView commitAnimations];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[_detailsController setDictionaryItem:[self getDictionaryItemForIndexPath:indexPath]
					   isFromOriginalDict:_isFromOriginalDict];
	
	[_navigationController pushViewController:_detailsController animated:YES];
}

#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	_searchBar.showsCancelButton = YES;
	[self hideIndexAndMoveTableUp:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	_searchBar.showsCancelButton = NO;
	[self hideIndexAndMoveTableUp:NO];
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

#pragma mark HWordOfTheDayDataSource methods

- (NSDictionary *)getWordOfTheDay {
	NSDictionary *wordOfTheDay;
	NSInteger totalNumOfWords = 0;
	for (NSDictionary *section in _dataBySections) {
		totalNumOfWords += [[section objectForKey:kSectionData] count];
	}
	
	NSInteger absoluteIndexOfWordOfTheDay = arc4random() % totalNumOfWords;
	NSInteger wordsPassed = 0;
	for (NSDictionary *section in _dataBySections) {
		NSArray *wordsInSection = [section objectForKey:kSectionData];
		
		if (absoluteIndexOfWordOfTheDay >= wordsPassed &&
			absoluteIndexOfWordOfTheDay < wordsPassed + [wordsInSection count]) {
			wordOfTheDay = [wordsInSection objectAtIndex:absoluteIndexOfWordOfTheDay - wordsPassed];
			break;
		}
		
		wordsPassed += [wordsInSection count];
	}
	
	return wordOfTheDay;
}

@end
