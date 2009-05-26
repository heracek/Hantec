//
//  HSettingsController.m
//  Hantec
//
//  Created by Tomas Horacek on 22.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HSettingsController.h"
#import "HSettingsMetadataSource.h"

@implementation HSettingsController

#pragma mark -
# pragma mark rewriting settingsdatasource to HSettingsMetadataSource

- (id)initWithConfigFile:(NSString *)configfile {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		settingsdatasource = [[HSettingsMetadataSource alloc] initWithConfigFile:configfile];
		[self setup];
    }
    return self;
}

- (id) initWithConfigFile:(NSString *)configfile andSettings:(NSObject *)newsettings {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		settingsdatasource = [[HSettingsMetadataSource alloc] initWithConfigFile:configfile andSettings:newsettings];
		[self setup];
    }
    return self;	
}

#pragma mark -

- (void)awakeFromNib {
	NSString *plist = [[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
	
	[[NSUserDefaults standardUserDefaults]
	setValue:[NSArray arrayWithObjects:
			  [NSArray arrayWithObjects:@"Vytvořeno za základě www.hantec.cz", @"http://www.hantec.cz/", nil],
			  [NSArray arrayWithObjects:@"© 2009 Tomáš Horáček", @"http://www.horacek.net/", nil],
			  nil
	 ] forKey:@"bottomSettingsTextInfo"];
	
	[self initWithConfigFile:plist];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[settingsdatasource save];
}

@end
