//
//  PrintView.m
//  Kineo
//
//  Created by Ben Yellin on 3/25/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "PrintView.h"
#import "FlipSeries.h"

const NSRect kPageFrame = {0, 0, 2550, 3300};

@implementation PrintView

@synthesize flipSeries;

- (id)initWithFlipSeries:(FlipSeries *)series {
    self = [super initWithFrame:kPageFrame];
    if (self) {
        flipSeries = [series retain];
		templateImage = [[NSImage imageNamed:@"template"] retain];
    }
    return self;
}

- (void)dealloc {
	self.flipSeries = nil;
	[templateImage release];
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor whiteColor] set];
	NSRectFill(dirtyRect);
	
	[templateImage drawInRect:dirtyRect 
					 fromRect:NSZeroRect 
					operation:NSCompositeSourceOver 
					 fraction:1.0];
	
	if (flipSeries) {
		NSSize imageFrameSize = NSMakeSize(354, 267);
		NSSize stapleSize = NSMakeSize(68, 267);
		float margin = 5.0;

		int numCols = 6;
		int numRows = 8;
		
		int imgIndex = 0;
		for (NSImage *img in [flipSeries images]) {					
			float xPos = ((imgIndex * stapleSize.width) + stapleSize.width) +
			(imgIndex * (imageFrameSize.width + margin));
			float yPos = dirtyRect.size.height-imageFrameSize.height;
			
			NSRect imgRect = NSMakeRect(xPos, yPos, 
										imageFrameSize.width, imageFrameSize.height);
			[img drawInRect:imgRect 
					 fromRect:NSZeroRect 
					operation:NSCompositeSourceOver 
					 fraction:1.0];			
			imgIndex++;
		}
		
		NSLog(@"index: %i", imgIndex);
	}
}

- (void)setFlipSeries:(FlipSeries *)series {
	if (![flipSeries isEqualTo:series]) {
		[flipSeries release];
		flipSeries = [series retain];
	}
	[self setNeedsDisplay:YES];
}

@end
