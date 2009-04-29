//
//  HWordDetails.h
//  Hantec
//
//  Created by Tomas Horacek on 29.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

#define SHOW_TRANSLATION_IN_WORD_OF_THE_DAY_KEY @"showTranslationInWordOfTheDay"

@interface HWordDetails : UIViewController {
	IBOutlet UILabel *_original;
	IBOutlet UITextView *_translation;
	IBOutlet UIButton *_addToOrRemoveFromFavourites;
	IBOutlet NSObject<HFavouritesDataSource> *_favouritesDataSource;
	
	NSDictionary *_actualDictionaryItem;
	
	BOOL _showTranslationInWordOfTheDay;
	
	UIImage *_starOn;
	UIImage *_starOff;
}

- (void)setDictionaryItem:(NSDictionary *)dictionaryItem;

- (IBAction)addToOrRemoveFromFavourites:(id)sender;
- (void)autosetStateOfAddToFavourites;
- (void)setStateOfAddToFavouritesWithIsInFavourites:(BOOL)isInFavourites;

@end
