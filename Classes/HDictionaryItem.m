//
//  HDictionaryItem.m
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HDictionaryItem.h"


@implementation HDictionaryItem

@synthesize original = _original;
@synthesize translation = _translation;

- (id)initWithOriginal:(NSString *)original andTranslation:(NSString *)translation {
	self = [super init];
	if (self == nil) {
		return nil;
	}
	
	_original = [original retain];
	_translation = [translation retain];
	
	return self;
}

- (void)dealloc {
	[_original release];
	[_translation release];
	[super dealloc];
}

+ (id)dictionaryItemWithOriginal:(NSString *)original andTranslation:(NSString *)translation {
	return [[[HDictionaryItem alloc] initWithOriginal:original andTranslation:translation] autorelease];
}

@end
