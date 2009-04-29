//
//  HDWordOfTheDay.h
//  Hantec
//
//  Created by Tomas Horacek on 27.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "HWordDetails.h"

@interface HDWordOfTheDay : HWordDetails {
	IBOutlet NSObject<HWordOfTheDayDataSource> *_wordOfTheDayDataSource;
	IBOutlet UIButton *_showTranslation;
	IBOutlet UIButton *_next;
}

- (IBAction)showTranslationAction:(id)sender;
- (IBAction)nextWordAction:(id)sender;
- (void)loadNextDictionaryItem;

@end
