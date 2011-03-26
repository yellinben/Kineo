//
//  PrintController.h
//  Kineo
//
//  Created by Ben Yellin on 3/25/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PrintView, FlipSeries;

@interface PrintController : NSWindowController {
	IBOutlet PrintView *printView;
	//PrintView *printView;
	FlipSeries *flipSeries;
}
@property (nonatomic, retain) FlipSeries *flipSeries;
- (id)initWithFlipSeries:(FlipSeries *)series;
- (IBAction)openInPreview:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)print:(id)sender;
@end