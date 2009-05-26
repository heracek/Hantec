//
//  InfoSettingsCustomCell.h
//  Hantec
//
//  Created by Tomas Horacek on 24.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsCellProtocol.h"

@interface InfoSettingsCustomCell : UITableViewCell <SettingsCellProtocol> {
	UILabel *label;
	
	NSObject *value;
	NSDictionary *configuration;
	NSMutableDictionary *changedsettings;
	NSString *_url;
}

@property (retain, nonatomic) NSString *url;

@end
