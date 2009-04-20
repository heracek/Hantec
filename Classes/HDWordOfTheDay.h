//
//  HDWordOfTheDay.h
//  Hantec
//
//  Created by Tomas Horacek on 27.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface HDWordOfTheDay : UIViewController {
	IBOutlet UILabel *_original;
	IBOutlet UITextView *_translation;
	IBOutlet UIButton *_showTranslation;
	IBOutlet UIButton *_next;
	IBOutlet UIButton *_addToOrRemoveFromFavourites;
	IBOutlet NSObject<HWordOfTheDayDataSource> *_wordOfTheDayDataSource;
	IBOutlet NSObject<HFavouritesDataSource> *_favouritesDataSource;
	
	NSDictionary *_actualDictionaryItem;
	
	UIImage *_starOn;
	UIImage *_starOff;
}

- (IBAction)showTranslationAction:(id)sender;
- (IBAction)nextWordAction:(id)sender;
- (IBAction)addToOrRemoveFromFavourites:(id)sender;
- (void)loadNextDictionaryItem;

@end
