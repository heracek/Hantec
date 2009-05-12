//
//  FavouritesViewController.m
//  Hantec
//
//  Created by Tomas Horacek on 12.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FavouritesViewController.h"


@implementation FavouritesViewController

- (NSMutableArray *)getFavoritesDataBySectiosFromFile {
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _pathToUserCopyOfPlist = [[documentsDirectory stringByAppendingPathComponent:@"favourites.plist"] retain];
	
    if ([fileManager fileExistsAtPath:_pathToUserCopyOfPlist] == NO) {
        NSString *pathToDefaultPlist = [[NSBundle mainBundle] pathForResource:@"empty-favourites" ofType:@"plist"];
		
        if ([fileManager copyItemAtPath:pathToDefaultPlist toPath:_pathToUserCopyOfPlist error:&error] == NO) {
            NSAssert1(0, @"Failed to copy data with error message '%@'.", [error localizedDescription]);
        }
    }
	
	return [[NSMutableArray alloc] initWithContentsOfFile:_pathToUserCopyOfPlist];
}

- (void)awakeFromNib {
	_dataBySections = [self getFavoritesDataBySectiosFromFile];
	_favouritesDataSource = self;
	_sortingLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"cs"];
	[super awakeFromNib];
	
	self.title = @"Oblíbené";
	
	_showSectionIndex = NO;
}

- (void)saveFavouritesToFile {
	[_dataBySections writeToFile:_pathToUserCopyOfPlist atomically:YES];
}

- (void)addToFavouritesWithDictionaryItem:(NSDictionary *)dictItem AndIsOriginalDict:(BOOL) isOriginalDict {
	NSMutableDictionary *section = [_dataBySections objectAtIndex:(isOriginalDict) ? 0 : 1];
	NSMutableArray *sectionData = [section objectForKey:kSectionData];
	
	NSString *originalToAdd = [dictItem objectForKey:kOriginal];
	NSUInteger originalToAddLength = [originalToAdd length];
	NSComparisonResult result;
	BOOL foundPlaceToInsertNewFavourite = NO;
	for (NSInteger index = 0; index < [sectionData count]; index++) {
		NSDictionary *comparedDictItem = [sectionData objectAtIndex:index];
		NSString *comparedDictItemOriginal = [comparedDictItem valueForKey:kOriginal];
		result = [originalToAdd compare:comparedDictItemOriginal
								options:NSCaseInsensitiveSearch|NSForcedOrderingSearch
								  range:NSMakeRange(0, MAX(originalToAddLength, [comparedDictItemOriginal length]))
								 locale:_sortingLocale];
		
		if (result == NSOrderedAscending) {
			foundPlaceToInsertNewFavourite = YES;
			[sectionData insertObject:dictItem atIndex:index];
			break;
		} else if (result == NSOrderedSame) {
			foundPlaceToInsertNewFavourite = YES;
			[sectionData replaceObjectAtIndex:index withObject:dictItem];
			break;
		}
	}
	
	if (foundPlaceToInsertNewFavourite == NO) {
		[sectionData addObject:dictItem];
	}
	
	[self saveFavouritesToFile];
	[self.tableView reloadData];
}

- (void)removeFromFavouritesWithDictionaryItem:(NSDictionary *)dictItem AndIsOriginalDict:(BOOL) isOriginalDict {
	NSMutableDictionary *section = [_dataBySections objectAtIndex:(isOriginalDict) ? 0 : 1];
	NSMutableArray *sectionData = [section objectForKey:kSectionData];
	
	NSString *originalToFind = [dictItem objectForKey:kOriginal];
	NSUInteger originalToFindLength = [originalToFind length];
	NSComparisonResult result;
	for (NSInteger index = 0; index < [sectionData count]; index++) {
		NSDictionary *comparedDictItem = [sectionData objectAtIndex:index];
		NSString *comparedDictItemOriginal = [comparedDictItem valueForKey:kOriginal];
		result = [originalToFind compare:comparedDictItemOriginal
								 options:NSCaseInsensitiveSearch|NSForcedOrderingSearch
								   range:NSMakeRange(0, MAX(originalToFindLength, [comparedDictItemOriginal length]))
								  locale:_sortingLocale];
		
		if (result == NSOrderedSame) {
			[sectionData removeObjectAtIndex:index];
		}
	}
	
	[self saveFavouritesToFile];
	[self.tableView reloadData];
}

- (BOOL)isInFavouritesWithDictionaryItem:(NSDictionary *)dictItem AndIsOriginalDict:(BOOL) isOriginalDict {
	NSMutableDictionary *section = [_dataBySections objectAtIndex:(isOriginalDict) ? 0 : 1];
	NSMutableArray *sectionData = [section objectForKey:kSectionData];
	
	NSString *originalToFind = [dictItem objectForKey:kOriginal];
	NSUInteger originalToFindLength = [originalToFind length];
	NSComparisonResult result;
	for (NSInteger index = 0; index < [sectionData count]; index++) {
		NSDictionary *comparedDictItem = [sectionData objectAtIndex:index];
		NSString *comparedDictItemOriginal = [comparedDictItem valueForKey:kOriginal];
		result = [originalToFind compare:comparedDictItemOriginal
								 options:NSCaseInsensitiveSearch|NSForcedOrderingSearch
								   range:NSMakeRange(0, MAX(originalToFindLength, [comparedDictItemOriginal length]))
								  locale:_sortingLocale];
		
		if (result == NSOrderedAscending) {
			return NO;
		} else if (result == NSOrderedSame) {
			return YES;
		}
	}
	
	return NO;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"in fav {%d, %d}", indexPath.section, indexPath.row);
	
	[_detailsController setDictionaryItem:[self getDictionaryItemForIndexPath:indexPath]
					   isFromOriginalDict:(indexPath.section == 0) ? YES : NO];
	
	[_navigationController pushViewController:_detailsController animated:YES];
}

@end
