//
//  CameraWindowController.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "CameraWindowController.h"
#import "CameraView.h"
#import <QTKit/QTKit.h>
#import <QuartzCore/CIImage.h>
#import "FlipSeries.h"
#import "FlipViewerController.h"
#import "NSImage+Extras.h"

#define kFrameCount 5

@interface CameraWindowController (Private)
- (void)setupCamera;
- (void)setRecording:(BOOL)flag;
@end

@implementation CameraWindowController

@synthesize isRecording;
@synthesize currentFlipSeries;

- (void)windowDidLoad {
	isRecording = NO;
	[self setupCamera];
	[frameCountLabel setHidden:YES];
}

- (void)setupCamera {
	videoSession = [[QTCaptureSession alloc] init];
	QTCaptureDevice *device = [QTCaptureDevice 
							   defaultInputDeviceWithMediaType:QTMediaTypeVideo];
	[device open:nil];
	
	QTCaptureDeviceInput *deviceInput = [QTCaptureDeviceInput deviceInputWithDevice:device];
	[videoSession addInput:deviceInput error:nil];
	
	videoOutput = [[QTCaptureDecompressedVideoOutput alloc] init];
	[videoOutput setDelegate:self];
	[videoSession addOutput:videoOutput error:nil];
	[videoSession startRunning];
	
	[camView setCaptureSession:videoSession];
}

- (void)setRecording:(BOOL)flag {
	isRecording = flag;
	
	if (isRecording) {
		[videoSession startRunning];
		self.currentFlipSeries = [[FlipSeries alloc] init];
		currentFlipCount = 0;
		[frameCountLabel setIntValue:kFrameCount];
		[NSTimer scheduledTimerWithTimeInterval:1.0 
										 target:self 
									   selector:@selector(recordingTimer:) 
									   userInfo:nil 
										repeats:YES];		
	} else {
		//[videoSession stopRunning];		
	}

	[frameCountLabel setHidden:!isRecording];
}

- (IBAction)startRecording:(id)sender {
	[self setRecording:YES];	
}

#pragma mark Capture Delegate

- (void)captureOutput:(QTCaptureOutput *)captureOutput 
  didOutputVideoFrame:(CVImageBufferRef)videoFrame 
	 withSampleBuffer:(QTSampleBuffer *)sampleBuffer 
	   fromConnection:(QTCaptureConnection *)connection {

	CVImageBufferRef previousBuffer;
	CVBufferRetain(videoFrame);
	
	@synchronized (self) {
		previousBuffer = currentImageBuffer;
		currentImageBuffer = videoFrame;
	}
	
	CVBufferRelease(previousBuffer);
}

#pragma mark Recording

- (void)recordingTimer:(NSTimer *)timer {
	if (currentFlipCount <= kFrameCount) {
		if (currentImageBuffer) {
			CIImage *camImage = [CIImage imageWithCVImageBuffer:currentImageBuffer];
			[currentFlipSeries addImage:
			 [NSImage imageFromCIImage:camImage]];
			
			[frameCountLabel setIntValue:(kFrameCount-currentFlipCount)];
			currentFlipCount++;
		}
	} else {
		[timer invalidate];
		[self setRecording:NO];
		
		// Open Flip Viewer
		FlipViewerController *flipViewer = [[FlipViewerController alloc] initWithFlipSeries:currentFlipSeries];
		[flipViewer showWindow:nil];
		self.currentFlipSeries = nil;
	}

}

@end
