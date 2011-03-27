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
	
	/*[templateImage drawInRect:dirtyRect 
					 fromRect:NSZeroRect 
					operation:NSCompositeSourceOver 
					 fraction:1.0];*/
	
	if (flipSeries) {
		NSSize imageFrameSize = NSMakeSize(354, 267);
		NSSize stapleSize = NSMakeSize(68, 267);
		float margin = 5.0;

		int numCols = 6;
		int numRows = 8;
		
		// Draw Title Box
		/*float titleXPos = stapleSize.width;
		float titleYPos = dirtyRect.size.height-imageFrameSize.height;
		NSRect titleRect = NSMakeRect(titleXPos, titleYPos, 
									  imageFrameSize.height, imageFrameSize.width);
		NSTextView *titleBox = [[NSTextView alloc] initWithFrame:titleRect];
		[titleBox setString:flipSeries.title];
		[self addSubview:titleBox];
		
		// Draw Cut Line
		NSBezierPath *cutLine = [NSBezierPath bezierPath];
		[cutLine setLineWidth:2.0];			
		CGFloat dashPattern[2] = {6.0, 3.0};
		[cutLine setLineDash:dashPattern count:2 phase:0.0];
		[cutLine moveToPoint:NSMakePoint(imageFrameSize.width+titleXPos+1, titleYPos)];
		[cutLine lineToPoint:NSMakePoint(imageFrameSize.width+titleXPos+1, titleYPos+imageFrameSize.height)];
		[cutLine stroke];
		
		// Staple Box
		NSRect stapleRect = NSMakeRect(titleXPos-stapleSize.width, titleYPos, 
									   stapleSize.width, stapleSize.height);
		[[NSColor grayColor] set];
		NSRectFill(stapleRect);	*/
		
				
		int imgIndex = 0;
		//int colCount = 0;
		int rowIndex = 0;	
		for (NSImage *img in [flipSeries images]) {														
			float xPos = ((imgIndex * stapleSize.width) + stapleSize.width) +
				(imgIndex * (imageFrameSize.width + margin));
			float oldYPos = dirtyRect.size.height-imageFrameSize.height;
			
			float yPos = (dirtyRect.size.height - (rowIndex * (imageFrameSize.height+margin))) - imageFrameSize.height;
			
			// Draw Staple Box
			NSRect stapleRect = NSMakeRect(xPos-stapleSize.width, yPos, 
										   stapleSize.width, stapleSize.height);
			[[NSColor grayColor] set];
			NSRectFill(stapleRect);			
			
			NSRect imgRect = NSMakeRect(xPos, yPos, 
										imageFrameSize.width, imageFrameSize.height);

			[img drawInRect:imgRect 
					 fromRect:NSZeroRect 
					operation:NSCompositeSourceOver 
					 fraction:1.0];	
			
			// Draw Cut Line
			NSBezierPath *cutLine = [NSBezierPath bezierPath];
			[cutLine setLineWidth:2.0];			
			CGFloat dashPattern[2] = {6.0, 3.0};
			[cutLine setLineDash:dashPattern count:2 phase:0.0];
			[cutLine moveToPoint:NSMakePoint(imageFrameSize.width+xPos+2, yPos)];
			[cutLine lineToPoint:NSMakePoint(imageFrameSize.width+xPos+2, yPos+imageFrameSize.height)];
			[cutLine stroke];
			
			imgIndex++;
			//colCount++;
			
			if (imgIndex > numCols) {
				rowIndex++;
				//colCount = 0;
				imgIndex = 0;
				
				// Draw Row Line
				NSBezierPath *rowLine = [NSBezierPath bezierPath];
				[rowLine setLineWidth:2.0];
				[rowLine setLineDash:dashPattern count:2 phase:0.0];
				[rowLine moveToPoint:NSMakePoint(0.0, yPos-2)];
				[rowLine lineToPoint:NSMakePoint(dirtyRect.size.width, yPos-2)];
				[rowLine stroke];
			}
		}
		
		//NSLog(@"index: %i", imgIndex);
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
