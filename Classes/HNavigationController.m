//
//  HNavigationController.m
//  Hantec
//
//  Created by Tomas Horacek on 28.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HNavigationController.h"


@implementation HNavigationController

- (void)awakeFromNib {
	[self pushViewController:_firstViewController animated:NO];
}

@end
