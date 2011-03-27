//
//  KineoAppDelegate.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "KineoAppDelegate.h"
#import "CameraWindowController.h"
#import "PreferencesController.h"

@implementation KineoAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	cameraController = [[CameraWindowController alloc] 
						initWithWindowNibName:@"Camera"];
	[cameraController showWindow:nil];
	
	// Register Default Prefs
	NSDictionary *defaultPrefs = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSNumber numberWithInt:48], @"numFrames", 
								  [NSNumber numberWithFloat:1.0], @"frameRate", nil];
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
}

- (IBAction)showPreferences:(id)sender {
	[[PreferencesController sharedPreferences] showWindow:nil];
}

@end
