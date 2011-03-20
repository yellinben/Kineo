//
//  CameraWindowController.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QTCaptureView, QTCaptureSession;

@interface CameraWindowController : NSWindowController {
	IBOutlet QTCaptureView *captureView;
	IBOutlet NSButton *recordButton;
	
	QTCaptureSession *session;
	BOOL isRecording;
}
@property (readonly) BOOL isRecording;
- (IBAction)startRecording:(id)sender; 
@end
