//
//  InfoSettingsCustomCell.m
//  Hantec
//
//  Created by Tomas Horacek on 24.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "InfoSettingsCustomCell.h"


@implementation InfoSettingsCustomCell

@synthesize configuration, value, changedsettings;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
    if (self == nil) {
		return nil;
	}
	
	label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont systemFontOfSize:13];
	label.font = [UIFont boldSystemFontOfSize:13];
	[self.contentView addSubview:label];
	
    return self;
}

- (void)dealloc {
	[super dealloc];
	[label release];
}

- (void) layoutSubviews {
	[super layoutSubviews];
	
	CGRect titleframe = label.frame;
	titleframe.origin.x = 10;
	
	titleframe.size.width = self.contentView.frame.size.width - 20;
	titleframe.size.height = self.contentView.frame.size.height;
	
	label.frame = titleframe;
}
/*
 - (void) setConfiguration:(NSDictionary *)config {
 configuration = config;
 label.text = [configuration objectForKey:@"Title"];
 
 }
 */

- (void) setValue:(NSObject *)newvalue {
	value = newvalue;
	label.text = (NSString *) value;
}

@end
