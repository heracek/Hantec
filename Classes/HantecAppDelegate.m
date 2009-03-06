//
//  HantecAppDelegate.m
//  Hantec
//
//  Created by Tomas Horacek on 1.3.09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "HantecAppDelegate.h"
#import "RootViewController.h"


@implementation HantecAppDelegate

@synthesize window;
@synthesize rootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[rootViewController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[rootViewController release];
	[window release];
	[super dealloc];
}

@end
