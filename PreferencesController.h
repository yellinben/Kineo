//
//  PreferencesController.h
//  Kineo
//
//  Created by Ben Yellin on 3/27/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferencesController : NSWindowController {
	IBOutlet NSTextField *frameField;
	IBOutlet NSTextField *rateField;
}
+ (PreferencesController *)sharedPreferences;
@end
