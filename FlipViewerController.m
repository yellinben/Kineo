//
//  FlipViewerController.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "FlipViewerController.h"
#import "FlipSeries.h"

@interface FlipViewerController (Private)
- (void)playUpdate:(NSTimer *)timer;
@end


@implementation FlipViewerController

@synthesize isPlaying;

- (id)initWithFlipSeries:(FlipSeries *)series {
	if (self = [super initWithWindowNibName:@"FlipViewer"]) {
		flipSeries = [series retain];
	}
	return self;
}

- (void)windowDidLoad {	
	[self.window setTitle:[flipSeries title]];
	[titleField setStringValue:[flipSeries title]];
	
	// Image View
	currentImageIndex = 0;	
	[self displayImageAtIndex:currentImageIndex];
}

- (void)windowWillClose:(NSNotification *)notification {
	[flipSeries release];
}

- (void)dealloc {
	[flipSeries release];
	[super dealloc];
}

- (IBAction)showPrevImage:(id)sender {
	currentImageIndex--;
	if (currentImageIndex < 0)
		currentImageIndex = [flipSeries numberOfImages]-1;
	
	[self displayImageAtIndex:currentImageIndex];
}

- (IBAction)showNextImage:(id)sender {
	currentImageIndex++;
	if (currentImageIndex >= [flipSeries numberOfImages])
		currentImageIndex = 0;
	
	[self displayImageAtIndex:currentImageIndex];
}

- (void)displayImageAtIndex:(NSInteger)index {
	NSImage *flipImage = [flipSeries getImage:index];	
	if (flipImage) {
		[imageView setImage:flipImage];
	}
}

- (IBAction)playPause:(id)sender {
	self.isPlaying = !isPlaying;
	
	if ([sender isKindOfClass:[NSButton class]]) {
		if (isPlaying)
			[sender setTitle:@"Pause"];
		else
			[sender setTitle:@"Play"];
	}
}

- (void)setIsPlaying:(BOOL)flag {
	isPlaying = flag;
	if (isPlaying) {
		[NSTimer scheduledTimerWithTimeInterval:0.1 
										 target:self 
									   selector:@selector(playUpdate:) 
									   userInfo:nil 
										repeats:YES];
	}
}

- (void)playUpdate:(NSTimer *)timer {
	if (isPlaying) {
		[self showNextImage:nil];
	} else {
		[timer invalidate];
	}

}

- (IBAction)changeTitle:(id)sender {
	NSString *newTitle = [titleField stringValue];
	flipSeries.title = newTitle;
	[self.window setTitle:newTitle];
}
		 
- (IBAction)print:(id)sender {
}

@end
