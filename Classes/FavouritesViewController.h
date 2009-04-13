//
//  FavouritesViewController.h
//  Hantec
//
//  Created by Tomas Horacek on 12.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"

@interface FavouritesViewController : RootViewController <HFavouritesDataSource> {
	NSString *_pathToUserCopyOfPlist;
	NSLocale *_sortingLocale;
}

@end
