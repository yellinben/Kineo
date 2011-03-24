//
//  KineoAppDelegate.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "KineoAppDelegate.h"
#import "CameraWindowController.h"

@implementation KineoAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	cameraController = [[CameraWindowController alloc] 
						initWithWindowNibName:@"Camera"];
	[cameraController showWindow:nil];
}

@end
