//
//  HDWordOfTheDay.h
//  Hantec
//
//  Created by Tomas Horacek on 27.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWordOfTheDayDataSource<NSObject>

@required

- (NSDictionary *)getWordOfTheDay;

@end

@interface HDWordOfTheDay : UIViewController {
	IBOutlet UILabel *_original;
	IBOutlet UITextView *_translation;
	IBOutlet UIButton *_showTranslation;
	IBOutlet UIButton *_next;
	IBOutlet NSObject<HWordOfTheDayDataSource> *_wordOfTheDayDataSource;
	
	NSDictionary *_actualDictionaryItem;
}

- (IBAction)showTranslationAction:(id)sender;
- (IBAction)nextWordAction:(id)sender;
- (void)loadNextDictionaryItem;

@end
