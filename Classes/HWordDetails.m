//
//  HWordDetails.m
//  Hantec
//
//  Created by Tomas Horacek on 29.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HWordDetails.h"


@implementation HWordDetails

- (void)dealloc {
	[_starOff dealloc];
	[_starOn dealloc];
    [super dealloc];
}

#pragma mark Custom methods

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_starOn = [UIImage imageNamed:@"star-on.png"];
	_starOff = [UIImage imageNamed:@"star-off.png"];
}

- (IBAction)addToOrRemoveFromFavourites:(id)sender {
	BOOL isInFavourites = [_favouritesDataSource isInFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:_isFromOriginalDict];
	if (isInFavourites) {
		[_favouritesDataSource removeFromFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:_isFromOriginalDict];
	} else {
		[_favouritesDataSource addToFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:_isFromOriginalDict];
	}
	
	[self setStateOfAddToFavouritesWithIsInFavourites: ! isInFavourites];
}

- (void)setStateOfAddToFavouritesWithIsInFavourites:(BOOL)isInFavourites {
	if (isInFavourites) {
		[_addToOrRemoveFromFavourites setImage:_starOn forState:UIControlStateNormal];
	} else {
		[_addToOrRemoveFromFavourites setImage:_starOff forState:UIControlStateNormal];
	}
}

- (void)autosetStateOfAddToFavourites {
	BOOL isInFavourites = [_favouritesDataSource isInFavouritesWithDictionaryItem:_actualDictionaryItem AndIsOriginalDict:_isFromOriginalDict];
	[self setStateOfAddToFavouritesWithIsInFavourites:isInFavourites];
}

- (void)setDictionaryItem:(NSDictionary *)dictionaryItem isFromOriginalDict:(BOOL)isFromOriginalDict {
	_actualDictionaryItem = dictionaryItem;
	_isFromOriginalDict = isFromOriginalDict;
	
	_original.text = [_actualDictionaryItem valueForKey:kOriginal];
	_translation.text = [_actualDictionaryItem valueForKey:kTranslation];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self autosetStateOfAddToFavourites];
}

@end
