//
//  PrintController.h
//  Kineo
//
//  Created by Ben Yellin on 3/25/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PDFView, PrintView, FlipSeries;

@interface PrintController : NSWindowController {
	IBOutlet PDFView *pdfView;
	PrintView *hiddenPrintView;
	FlipSeries *flipSeries;
}
@property (nonatomic, retain) FlipSeries *flipSeries;
- (id)initWithFlipSeries:(FlipSeries *)series;
- (IBAction)openInPreview:(id)sender;
- (IBAction)save:(id)sender;
- (void)saveToFile:(NSString *)path;
- (IBAction)print:(id)sender;
@end