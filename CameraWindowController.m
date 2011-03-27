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
#define kRecordRate 0.5

@interface CameraWindowController (Private)
- (void)setupCamera;
- (void)setupDevices;
- (void)updateDevice;
- (void)devicesChanged:(NSNotification *)notification;
- (void)setRecording:(BOOL)flag;
@end

@implementation CameraWindowController

@synthesize isRecording;
@synthesize currentFlipSeries;

- (void)windowDidLoad {
	isRecording = NO;
	[self setupCamera];
	[frameCountLabel setHidden:YES];
	[devicePicker removeAllItems];
}

- (void)dealloc {
	[deviceList release];
	self.currentFlipSeries = nil;
	[super dealloc];
}

- (void)setupCamera {
	videoSession = [[QTCaptureSession alloc] init];
	QTCaptureDevice *device = [QTCaptureDevice 
							   defaultInputDeviceWithMediaType:QTMediaTypeVideo];
	[device open:nil];
	
	[self setupDevices];
	
	videoOutput = [[QTCaptureDecompressedVideoOutput alloc] init];
	[videoOutput setDelegate:self];
	[videoSession addOutput:videoOutput error:nil];
	[videoSession startRunning];
	
	[camView setCaptureSession:videoSession];
}

- (void)setupDevices {
	currentVideoDevice = [[QTCaptureDevice 
						   defaultInputDeviceWithMediaType:QTMediaTypeVideo] retain];
	
	if (deviceList) {
		[deviceList release];
		deviceList = nil;
	}
	deviceList = [[NSMutableArray alloc] 
				  initWithArray:[QTCaptureDevice 
								 inputDevicesWithMediaType:QTMediaTypeVideo]];	
	if ([deviceList count] > 1) {
		for (QTCaptureDevice *device in deviceList) {			
			[devicePicker addItemWithTitle:[device description]];
		}
		[devicePicker setHidden:NO];		
	} else {
		[devicePicker setHidden:YES];
	}		
	
	[self updateDevice];
	
	
	// Device Notifications
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(devicesChanged:) 
												 name:QTCaptureDeviceWasConnectedNotification 
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(devicesChanged:) 
												 name:QTCaptureDeviceWasDisconnectedNotification 
											   object:nil];
}

- (void)devicesChanged:(NSNotification *)notification {
	[self setupDevices];
}

- (void)updateDevice {
	// Remove Current Device
	[videoSession removeInput:[QTCaptureDeviceInput deviceInputWithDevice:currentVideoDevice]];
	 
	QTCaptureDeviceInput *deviceInput = [QTCaptureDeviceInput deviceInputWithDevice:currentVideoDevice];
	
	NSError *err = nil;	
	[videoSession addInput:deviceInput error:&err];
	if (err) {
		NSLog(@"Video Error: %@", [err description]);
	}
}	

- (IBAction)changeDevice:(id)sender {
	NSInteger selectedIndex = [devicePicker indexOfSelectedItem];
	currentVideoDevice = [[deviceList objectAtIndex:selectedIndex] retain];
	[self updateDevice];
}

- (void)setRecording:(BOOL)flag {
	isRecording = flag;
	
	[recordButton setEnabled:!isRecording];
	
	if (isRecording) {
		[videoSession startRunning];
		self.currentFlipSeries = [[FlipSeries alloc] init];
		currentFrameCount = 0;
		[frameCountLabel setIntValue:kFrameCount];
		[NSTimer scheduledTimerWithTimeInterval:kRecordRate	 
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
	if (currentFrameCount <= kFrameCount) {
		if (currentImageBuffer) {
			CIImage *camImage = [CIImage imageWithCVImageBuffer:currentImageBuffer];
			[currentFlipSeries addImage:
			 [NSImage imageFromCIImage:camImage]];
			
			[frameCountLabel setIntValue:(kFrameCount-currentFrameCount)];
			currentFrameCount++;
		}
	} else {
		[timer invalidate];
		[self setRecording:NO];
		
		// Open Flip Viewer
		FlipViewerController *flipViewer = [[FlipViewerController alloc] initWithFlipSeries:currentFlipSeries];
		[flipViewer showWindow:nil];
		self.currentFlipSeries = nil;
		
		currentFrameCount = 0;
	}

}

@end
