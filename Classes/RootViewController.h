//
//  RootViewController.h
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDictionaryCell.h"
@class HWordDetails;

#define kSectionName @"sectionName"
#define kSectionData @"sectionData"
#define kOriginal    @"orig"
#define kTranslation @"trans"

@protocol HFavouritesDataSource
@required
- (void)addToFavouritesWithDictionaryItem:(NSDictionary *)dictItem AndIsOriginalDict:(BOOL) isOriginalDict;
- (void)removeFromFavouritesWithDictionaryItem:(NSDictionary *)dictItem AndIsOriginalDict:(BOOL) isOriginalDict;
- (BOOL)isInFavouritesWithDictionaryItem:(NSDictionary *)dictItem AndIsOriginalDict:(BOOL) isOriginalDict;
@end

@protocol HWordOfTheDayDataSource
@required
- (NSDictionary *)getWordOfTheDay;
@end

@protocol NonPublicTableViewMethods
- (void)setIndexHidden:(BOOL)hidden animated:(BOOL)animated;
@end


@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, HWordOfTheDayDataSource> {
	BOOL _isFromOriginalDict;
	IBOutlet UITableView *_tableView;
	IBOutlet UISearchBar *_searchBar;
	IBOutlet UITabBar *_tabBar;
	IBOutlet HDictionaryCell *_cell;
	IBOutlet NSObject<HFavouritesDataSource> *_favouritesDataSource;
	IBOutlet UINavigationController *_navigationController;
	IBOutlet HWordDetails* _detailsController;
	
	NSIndexPath *_selectRowIndexPath;
	
	NSArray *_dataBySections;
	NSMutableArray *_filteredListContent; // the filtered content as a result of the search
	BOOL _useFilteredList;
	BOOL _showSectionIndex;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITabBar *tabBar;

@end
