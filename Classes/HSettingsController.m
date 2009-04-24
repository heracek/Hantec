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
	
	[[NSUserDefaults standardUserDefaults] setValue:[NSArray arrayWithObjects:
													 @"Vytvořeno za základě www.hantec.cz",
													 @"© 2009 Tomáš Horáček",
													 nil] forKey:@"bottomSettingsTextInfo"];
	
	[self initWithConfigFile:plist];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[settingsdatasource save];
}


@end
