//
//  FlipViewerController.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FlipSeries;

@interface FlipViewerController : NSWindowController {
	IBOutlet NSImageView *imageView;
	
	FlipSeries *flipSeries; 
}
- (id)initWithFlipSeries:(FlipSeries *)series;

- (IBAction)showPrevImage:(id)sender;
- (IBAction)showNextImage:(id)sender;

- (IBAction)print:(id)sender;

@end
