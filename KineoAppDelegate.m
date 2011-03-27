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
<<<<<<< HEAD
	[[CameraWindowController sharedCameraWindow] showWindow:nil];
=======
	cameraController = [[CameraWindowController alloc] 
						initWithWindowNibName:@"Camera"];
	[cameraController showWindow:nil];
>>>>>>> 4bc11762c3e0d0afced952a438aa4ca3b653c33f
	
	// Register Default Prefs
	NSDictionary *defaultPrefs = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSNumber numberWithInt:48], @"numFrames", 
								  [NSNumber numberWithFloat:1.0], @"frameRate", nil];
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
}

- (IBAction)showPreferences:(id)sender {
	[[PreferencesController sharedPreferences] showWindow:nil];
<<<<<<< HEAD
}

- (IBAction)showCameraWindow:(id)sender {
	[[CameraWindowController sharedCameraWindow] showWindow:nil];
=======
>>>>>>> 4bc11762c3e0d0afced952a438aa4ca3b653c33f
}

@end
