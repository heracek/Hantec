//
//  HTabBarController.m
//  Hantec
//
//  Created by Tomas Horacek on 5.4.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HTabBarController.h"


@implementation HTabBarController

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
	//return YES;
}

@end
