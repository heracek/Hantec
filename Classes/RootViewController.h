//
//  RootViewController.h
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSectionName @"sectionName"
#define kSectionData @"sectionData"
#define kOriginal    @"orig"
#define kTranslation @"trans"

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *_tableView;
	IBOutlet UISearchBar *_searchBar;
	
	NSArray *_dataBySections;
	NSMutableArray *_filteredListContent; // the filtered content as a result of the search
	bool _useFilteredList;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchBar;


@end
