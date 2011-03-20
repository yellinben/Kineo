//
//  FlipViewerController.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "FlipViewerController.h"


@implementation FlipViewerController

- (id)initWithFlipSeries:(FlipSeries *)series {
	if (self = [super initWithWindowNibName:@"FlipViewer"]) {
		flipSeries = series;
	}
	return self;
}

- (IBAction)showPrevImage:(id)sender {

}

- (IBAction)showNextImage:(id)sender {

}

- (IBAction)print:(id)sender {

}

@end
