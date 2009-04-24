//
//  HSettingsController.m
//  Hantec
//
//  Created by Tomas Horacek on 22.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HSettingsController.h"


@implementation HSettingsController

- (void)awakeFromNib {
	NSString *plist = [[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
	[self initWithConfigFile:plist];
}

@end
