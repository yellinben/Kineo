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

	FlipSeries *flipSeries;
	NSInteger currentImageIndex;
}
- (id)initWithFlipSeries:(FlipSeries *)series;

- (IBAction)showPrevImage:(id)sender;
- (IBAction)showNextImage:(id)sender;
- (void)displayImageAtIndex:(NSInteger)index;

- (IBAction)print:(id)sender;

@end
