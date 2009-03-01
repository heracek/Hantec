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

@interface RootViewController : UITableViewController {
	NSArray *_dataBySections;
}

@end
