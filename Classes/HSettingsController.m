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
	
	CGRect newFrame = CGRectMake(0, 0, 320, 20);
	_footerLabel = [[UILabel alloc] initWithFrame:newFrame];
	_footerLabel.text = @"iHantec v1.0";
	_footerLabel.textAlignment = UITextAlignmentCenter;
	_footerLabel.opaque = NO;
	_footerLabel.backgroundColor = [UIColor clearColor];
	_footerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	_footerLabel.font = [UIFont boldSystemFontOfSize:12];
	_footerLabel.textColor = [UIColor grayColor];
	_footerLabel.shadowColor = [UIColor whiteColor];
	_footerLabel.shadowOffset = CGSizeMake(0, 1);
	
	_footerView = [[UIView alloc] initWithFrame:newFrame];
	_footerView.backgroundColor = [UIColor clearColor];
	[_footerView addSubview:_footerLabel];
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGRect newFrame = CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, _footerView.frame.size.height);
    _footerView.frame = newFrame;
    self.tableView.tableFooterView = _footerView;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[settingsdatasource save];
}

@end
