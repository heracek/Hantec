//
//  HSettingsMetadataSource.m
//  Hantec
//
//  Created by Tomas Horacek on 25.5.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HSettingsMetadataSource.h"
#import "InfoSettingsCustomCell.h"

@implementation HSettingsMetadataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[InfoSettingsCustomCell class]]) {
		InfoSettingsCustomCell *infoSettingsCustomCell = (InfoSettingsCustomCell *)cell;
		if (infoSettingsCustomCell.url) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:infoSettingsCustomCell.url]];
		}
	}
}

@end

