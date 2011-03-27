//
//  PreferencesController.m
//  Kineo
//
//  Created by Ben Yellin on 3/27/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "PreferencesController.h"


@implementation PreferencesController

+ (PreferencesController *)sharedPreferences {
	static PreferencesController *instance = nil;
	@synchronized(self) {
		if (!instance)
			instance = [[PreferencesController alloc] initWithWindowNibName:@"Preferences"];
	}
	return instance;
}

- (void)showWindow:(id)sender {
    [super showWindow:sender];
    [[self window] center];
}

@end
