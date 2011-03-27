//
//  KineoAppDelegate.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CameraWindowController;

@interface KineoAppDelegate : NSObject <NSApplicationDelegate> {
    CameraWindowController *cameraController;
}
- (IBAction)showPreferences:(id)sender;
@end
