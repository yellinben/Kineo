//
//  CameraWindowController.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "CameraWindowController.h"
#import <QTKit/QTKit.h>

@interface CameraWindowController (Private)
- (void)setupCamera;
- (void)setRecording:(BOOL)flag;
@end


@implementation CameraWindowController

@synthesize isRecording;

- (void)windowDidLoad {
	isRecording = NO;
	[self setupCamera];
}

- (void)setupCamera {
	session = [[QTCaptureSession alloc] init];
	QTCaptureDevice *device = [QTCaptureDevice 
							   defaultInputDeviceWithMediaType:QTMediaTypeVideo];
	[device open:nil];
	
	QTCaptureDeviceInput *deviceInput = [QTCaptureDeviceInput deviceInputWithDevice:device];
	[session addInput:deviceInput error:nil];
	
	[captureView setCaptureSession:session];
}

- (void)setRecording:(BOOL)flag {
	isRecording = flag;
	
	if (isRecording) {
		[session startRunning];
	} else {
		[session stopRunning];
	}

}

- (IBAction)startRecording:(id)sender {
	[self setRecording:YES];
}

@end
