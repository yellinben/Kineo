//
//  FlipViewerController.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FlipSeries;

@interface FlipViewerController : NSWindowController <NSWindowDelegate> {
	IBOutlet NSImageView *imageView;	
	IBOutlet NSTextField *titleField;
	
	FlipSeries *flipSeries;
	NSInteger currentImageIndex;
	
	BOOL isPlaying;
}

@property (readwrite) BOOL isPlaying;

- (id)initWithFlipSeries:(FlipSeries *)series;

- (IBAction)showPrevImage:(id)sender;
- (IBAction)showNextImage:(id)sender;
- (void)displayImageAtIndex:(NSInteger)index;
- (IBAction)playPause:(id)sender;

- (IBAction)changeTitle:(id)sender;
- (IBAction)print:(id)sender;

@end
