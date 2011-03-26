//
//  PrintController.m
//  Kineo
//
//  Created by Ben Yellin on 3/25/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "PrintController.h"
#import "FlipSeries.h"
#import "PrintView.h"

@implementation PrintController

@synthesize flipSeries;

- (id)initWithFlipSeries:(FlipSeries *)series {
	if (self = [super initWithWindowNibName:@"Print"]) {
		flipSeries = series;
		/*printView = [[PrintView alloc] 
					 initWithFlipSeries:series frame:[printViewHolder frame]];
		[printViewHolder addSubview:printView];*/
		//[printView setFlipSeries:series];
		[self.window setTitle:series.title];
	}
	return self;
}

- (void)windowDidLoad {
	[self.window setAspectRatio:NSMakeSize(1.0, 1.2941)]; // doesn't work
	[printView setFlipSeries:flipSeries];
}
	
- (IBAction)openInPreview:(id)sender {
}

- (IBAction)save:(id)sender {
}

- (IBAction)print:(id)sender {
}

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize {
	[printView setNeedsDisplay:YES];
	double width = (frameSize.width >= 300) ? frameSize.width : 300;
	return NSMakeSize(width, width*1.2941);
}

@end
