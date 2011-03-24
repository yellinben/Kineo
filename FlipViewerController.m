//
//  FlipViewerController.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "FlipViewerController.h"
#import "FlipSeries.h"

@implementation FlipViewerController

- (id)initWithFlipSeries:(FlipSeries *)series {
	if (self = [super initWithWindowNibName:@"FlipViewer"]) {
		flipSeries = [series retain];
	}
	return self;
}

- (void)windowDidLoad {
	// Set Window Title
	NSString *title = [NSString stringWithFormat:@"Flip Book: %@",
					   [flipSeries title], nil];
	[self.window setTitle:title];
	
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
		 
- (IBAction)print:(id)sender {
}

@end
