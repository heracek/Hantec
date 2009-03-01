//
//  HDictionaryItem.h
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HDictionaryItem : NSObject {
	NSString *_original;
	NSString *_translation;
}

@property (readonly) NSString *original;
@property (readonly) NSString *translation;

- (id)initWithOriginal:(NSString *)original andTranslation:(NSString *)translation;
+ (id)dictionaryItemWithOriginal:(NSString *)original andTranslation:(NSString *)translation;

@end
