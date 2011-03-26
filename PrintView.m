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
    }
    return self;
}

- (void)dealloc {
	self.flipSeries = nil;
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor whiteColor] set];
	NSRectFill(dirtyRect);
	
	if (flipSeries) {
		int imgCount = 0;
		for (NSImage *img in [flipSeries images]) {
			NSSize origSize =  [img	size];
			NSSize newSize = NSMakeSize(origSize.width/3, origSize.height/3);
			NSRect imgRect = NSMakeRect(0, imgCount*newSize.height, 
										newSize.width, newSize.height);
			[img drawInRect:imgRect 
					 fromRect:NSZeroRect 
					operation:NSCompositeSourceOver 
					 fraction:1.0];			
			imgCount++;
		}
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
