//
//  CameraView.m
//  Kineo
//
//  Created by Ben Yellin on 3/24/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "CameraView.h"

@implementation CameraView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		showFlash = NO;
		[super setFillColor:[NSColor blackColor]];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {    
	/*NSLog(@"draw rect");	
	if (showFlash) {
		NSLog(@"flash");
		[[NSColor whiteColor] set];
		NSRectFill(dirtyRect);
		//showFlash = NO;
	} else {
		[super drawRect:dirtyRect];
	}*/
	[super drawRect:dirtyRect];
}

- (void)flashView {
	showFlash = YES;
	[self needsDisplay];
}

@end
