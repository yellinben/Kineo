//
//  CameraWindowController.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

/*@class QTCaptureView, QTCaptureSession, QTCaptureDecompressedVideoOutput;*/
@class CIImage;
@class FlipSeries;

@interface CameraWindowController : NSWindowController {
	IBOutlet QTCaptureView *captureView;
	IBOutlet NSButton *recordButton;
	IBOutlet NSTextField *frameCountLabel;
	
	QTCaptureSession *videoSession;
	QTCaptureDecompressedVideoOutput  *videoOutput;
	BOOL isRecording;
	CVImageBufferRef currentImageBuffer;
	
	FlipSeries *currentFlipSeries;
	NSInteger currentFlipCount;
}
@property (readonly) BOOL isRecording;
@property (nonatomic, assign) CIImage *currentCameraImage;
@property (nonatomic, assign) NSImage *currentImage;
@property (nonatomic, assign) FlipSeries *currentFlipSeries;
- (IBAction)startRecording:(id)sender; 
@end
