//
//  HDWordOfTheDay.m
//  Hantec
//
//  Created by Tomas Horacek on 27.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HDWordOfTheDay.h"
#import "RootViewController.h"

@implementation HDWordOfTheDay

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

-(void)autoSetShowTranslationInWordOfTheDay {
	_showTranslationInWordOfTheDay = [[NSUserDefaults standardUserDefaults] boolForKey:SHOW_TRANSLATION_IN_WORD_OF_THE_DAY_KEY];
	_showTranslation.hidden = _showTranslationInWordOfTheDay;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	_starOn = [UIImage imageNamed:@"star-on.png"];
	_starOff = [UIImage imageNamed:@"star-off.png"];
	
	if (_actualDictionaryItem == nil) {
		[self loadNextDictionaryItem];
	}
	
	[self autoSetShowTranslationInWordOfTheDay];
	
	_original.text = [_actualDictionaryItem valueForKey:kOriginal];
	_translation.text = @"";
	if (_showTranslationInWordOfTheDay) {
		[self showTranslationAction:nil];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self autoSetShowTranslationInWordOfTheDay];
	if (_showTranslationInWordOfTheDay) {
		[self showTranslationAction:nil];
	}
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)setStateOfAddToFavouritesWithIsInFavourites:(BOOL)isInFavourites {
	if (isInFavourites) {
		[_addToOrRemoveFromFavourites setImage:_starOn forState:UIControlStateNormal];
	} else {
		[_addToOrRemoveFromFavourites setImage:_starOff forState:UIControlStateNormal];
	}
}

- (void)autosetStateOfAddToFavourites {
	BOOL isInFavourites = [_favouritesDataSource isInFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:YES];
	[self setStateOfAddToFavouritesWithIsInFavourites:isInFavourites];
}

- (IBAction)showTranslationAction:(id)sender {
	_translation.text = [_actualDictionaryItem valueForKey:kTranslation];
}

- (IBAction)nextWordAction:(id)sender {
	[self loadNextDictionaryItem];
	_original.text = [_actualDictionaryItem valueForKey:kOriginal];
	_translation.text = @"";
	if (_showTranslationInWordOfTheDay) {
		[self showTranslationAction:nil];
	}
}

- (IBAction)addToOrRemoveFromFavourites:(id)sender {
	BOOL isInFavourites = [_favouritesDataSource isInFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:YES];
	if (isInFavourites) {
		[_favouritesDataSource removeFromFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:YES];
	} else {
		[_favouritesDataSource addToFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:YES];
	}
	
	[self setStateOfAddToFavouritesWithIsInFavourites: ! isInFavourites];
}

- (void)loadNextDictionaryItem {
	if (_actualDictionaryItem != nil) {
		[_actualDictionaryItem release];
	}
	
	_actualDictionaryItem = [[_wordOfTheDayDataSource getWordOfTheDay] retain];
	[self autosetStateOfAddToFavourites];
}

@end
