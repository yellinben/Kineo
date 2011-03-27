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
		//NSDictionary *labelAttrs = [NSDictionary dictionaryWithObjectsAndKeys:		
		
		NSSize imageFrameSize = NSMakeSize(354, 267);
		NSSize stapleSize = NSMakeSize(68, 267);
		float margin = 5.0;

		int numCols = 6;
		int numRows = 8;
				
		int imgCount = 0;
		int rowIndex = 0;
		BOOL showTitleBox = YES;
		for (NSImage *img in [flipSeries images]) {														
			float xPos = ((imgCount * stapleSize.width) + stapleSize.width) +
				(imgCount * (imageFrameSize.width + margin));		
			float yPos = (dirtyRect.size.height - (rowIndex * (imageFrameSize.height+margin))) - imageFrameSize.height;
			
			// Draw Staple Box
			NSRect stapleRect = NSMakeRect(xPos-stapleSize.width, yPos, 
										   stapleSize.width, stapleSize.height);
			[[NSColor colorWithCalibratedWhite:0.230 alpha:1.000] set];
			NSRectFill(stapleRect);							
			
			NSRect imgRect = NSMakeRect(xPos, yPos, 
										imageFrameSize.width, imageFrameSize.height);

			// Title Box
			if (showTitleBox) {
				[[NSColor colorWithCalibratedWhite:0.704 alpha:1.000] set];
				NSFrameRect(imgRect);
				showTitleBox = NO;
			} else {
				[img drawInRect:imgRect 
					   fromRect:NSZeroRect 
					  operation:NSCompositeSourceOver 
					   fraction:1.0];
				// Frame Count Label
				/*[[NSFont fontWithName:@"Helvetica" size:20.0] set];
				[[NSString stringWithFormat:@"%i", imgCount] drawAtPoint:stapleRect.origin];*/
			}			
			
			// Draw Cut Line
			NSBezierPath *cutLine = [NSBezierPath bezierPath];
			[cutLine setLineWidth:2.0];			
			CGFloat dashPattern[2] = {6.0, 3.0};
			[cutLine setLineDash:dashPattern count:2 phase:0.0];
			[cutLine moveToPoint:NSMakePoint(imageFrameSize.width+xPos+2, yPos)];
			[cutLine lineToPoint:NSMakePoint(imageFrameSize.width+xPos+2, yPos+imageFrameSize.height)];
			[cutLine stroke];
			
			imgCount++;

			if (imgCount > numCols) {
				rowIndex++;
				imgCount = 0;
				
				// Draw Row Line
				NSBezierPath *rowLine = [NSBezierPath bezierPath];
				[rowLine setLineWidth:2.0];
				[rowLine setLineDash:dashPattern count:2 phase:0.0];
				[rowLine moveToPoint:NSMakePoint(0.0, yPos-2)];
				[rowLine lineToPoint:NSMakePoint(dirtyRect.size.width, yPos-2)];
				[rowLine stroke];
			}
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
