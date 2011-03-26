//
//  PrintView.h
//  Kineo
//
//  Created by Ben Yellin on 3/25/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class FlipSeries;

@interface PrintView : NSView {
	FlipSeries *flipSeries;
}
@property (nonatomic, retain) FlipSeries *flipSeries;
- (id)initWithFlipSeries:(FlipSeries *)series frame:(NSRect)frame;
@end
