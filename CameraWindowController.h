//
//  CameraWindowController.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@class CameraView;
@class CIImage;
@class FlipSeries;

@interface CameraWindowController : NSWindowController {
	IBOutlet CameraView *camView;
	IBOutlet NSButton *recordButton;
	IBOutlet NSTextField *frameCountLabel;
	IBOutlet NSPopUpButton *devicePicker;
	
	NSMutableArray *deviceList;
	QTCaptureDevice *currentVideoDevice;
	QTCaptureSession *videoSession;
	QTCaptureDecompressedVideoOutput  *videoOutput;
	BOOL isRecording;
	CVImageBufferRef currentImageBuffer;
	
	FlipSeries *currentFlipSeries;
	NSInteger currentFrameCount;
	
	NSInteger numFrames;
	NSTimeInterval frameRate;
}
@property (readonly) BOOL isRecording;
@property (nonatomic, assign) FlipSeries *currentFlipSeries;

+ (CameraWindowController *)sharedCameraWindow;

- (IBAction)startRecording:(id)sender; 
- (IBAction)changeDevice:(id)sender;
- (IBAction)showPreferences:(id)sender;

@end
