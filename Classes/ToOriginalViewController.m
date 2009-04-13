//
//  ToOriginalViewController.m
//  Hantec
//
//  Created by Tomas Horacek on 6.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ToOriginalViewController.h"


@implementation ToOriginalViewController

- (void)awakeFromNib {
	NSString *dictFileName = @"dict-reverse";
	_dataBySections = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:dictFileName ofType:@"plist"]] retain];
	
	[super awakeFromNib];
}

@end
