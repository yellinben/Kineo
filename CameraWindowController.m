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
#import "PreferencesController.h"

#define kFrameCount 5
#define kRecordRate 0.5

@interface CameraWindowController (Private)
- (void)setupCamera;
- (void)setupDevices;
- (void)updateDevice;
- (void)devicesChanged:(NSNotification *)notification;
- (void)setRecording:(BOOL)flag;
- (void)prefsChanged:(NSNotification *)notification;
@end

@implementation CameraWindowController

@synthesize isRecording;
@synthesize currentFlipSeries;

+ (CameraWindowController *)sharedCameraWindow {
	static CameraWindowController *shared = nil;
	@synchronized(self) {
		if (!shared)
			shared = [[CameraWindowController alloc] initWithWindowNibName:@"Camera"];		
	}
	return shared;
}

- (void)windowDidLoad {
	isRecording = NO;
	[self setupCamera];
	[frameCountLabel setHidden:YES];
	[devicePicker removeAllItems];
	
	numFrames = [[[NSUserDefaults standardUserDefaults] 
						 objectForKey:@"numFrames"] integerValue];
	frameRate = (NSTimeInterval)[[[NSUserDefaults standardUserDefaults] 
										 objectForKey:@"frameRate"] floatValue];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(prefsChanged:) 
												 name:NSUserDefaultsDidChangeNotification 
											   object:nil];
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
	
	if (isRecording) {
		[videoSession startRunning];
		self.currentFlipSeries = [[FlipSeries alloc] init];
		currentFrameCount = 0;
		[frameCountLabel setIntValue:numFrames];
		[NSTimer scheduledTimerWithTimeInterval:frameRate	 
										 target:self 
									   selector:@selector(recordingTimer:) 
									   userInfo:nil 
										repeats:YES];
		[recordButton setTitle:@"Stop"];
	} else {
		//[videoSession stopRunning];	
		[recordButton setTitle:@"Make Flipbook"];
	}

	[frameCountLabel setHidden:!isRecording];
}

- (IBAction)recordingAction:(id)sender {
	[self setRecording:!isRecording];	
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
	if (isRecording) {
		if (currentFrameCount <= numFrames) {
			if (currentImageBuffer) {
				CIImage *camImage = [CIImage imageWithCVImageBuffer:currentImageBuffer];
				[currentFlipSeries addImage:
				 [NSImage imageFromCIImage:camImage]];
				
				[frameCountLabel setIntValue:(numFrames-currentFrameCount)];
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
	} else {
		[timer invalidate];
		currentFrameCount = 0;
	}

}

- (IBAction)showPreferences:(id)sender {
	[[PreferencesController sharedPreferences] showWindow:nil];
}

- (void)prefsChanged:(NSNotification *)notification {
	numFrames = [[[NSUserDefaults standardUserDefaults] 
						 objectForKey:@"numFrames"] integerValue];
	frameRate = (NSTimeInterval)[[[NSUserDefaults standardUserDefaults] 
										 objectForKey:@"frameRate"] floatValue];
}

@end
