//
//  FromOriginalViewController.m
//  Hantec
//
//  Created by Tomas Horacek on 6.3.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FromOriginalViewController.h"


@implementation FromOriginalViewController

- (void)awakeFromNib {
	NSLog(@"FromOriginalViewController - awakeFromNib");
	
	NSString *dictFileName = @"dict";
	_dataBySections = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:dictFileName ofType:@"plist"]] retain];
	
	self.title = @"Z Hantecu";
	
	[super awakeFromNib];
}

@end
