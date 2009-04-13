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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (_actualDictionaryItem == nil) {
		[self loadNextDictionaryItem];
	}
	
	_original.text = [_actualDictionaryItem valueForKey:kOriginal];
	_translation.text = @"";
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

- (IBAction)showTranslationAction:(id)sender {
	_translation.text = [_actualDictionaryItem valueForKey:kTranslation];
}

- (IBAction)nextWordAction:(id)sender {
	[self loadNextDictionaryItem];
	_original.text = [_actualDictionaryItem valueForKey:kOriginal];
	_translation.text = @"";
}

- (IBAction)addToFavourites:(id)sender {
	[_favouritesDataSource addToFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:YES];
}

- (void)loadNextDictionaryItem {
	if (_actualDictionaryItem != nil) {
		[_actualDictionaryItem release];
	}
	
	_actualDictionaryItem = [[_wordOfTheDayDataSource getWordOfTheDay] retain];
}

@end
