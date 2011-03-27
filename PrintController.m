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
#import "NSFileManager+TemporaryDirectory.h"
#import <Quartz/Quartz.h>

@interface PrintController (Private)
- (void)updatePDF;
- (NSString *)saveTemporaryPDF;
@end

@implementation PrintController

@synthesize flipSeries;

- (id)initWithFlipSeries:(FlipSeries *)series {
	if (self = [super initWithWindowNibName:@"Print"]) {
		flipSeries = series;
		hiddenPrintView = [[PrintView alloc] 
					 initWithFlipSeries:series];
		[self.window setTitle:series.title];
		[pdfView setAutoScales:YES];
		[pdfView setDisplayMode:kPDFDisplaySinglePage];
		[self updatePDF];
	}
	return self;
}

- (void)windowDidLoad {
	[self.window setAspectRatio:NSMakeSize(1.0, 1.2941)]; // doesn't work
	[hiddenPrintView setFlipSeries:flipSeries];
}
	
- (IBAction)openInPreview:(id)sender {
	NSString *tempPath = [self saveTemporaryPDF];
	[[NSWorkspace sharedWorkspace] openFile:tempPath];
}

- (NSString *)saveTemporaryPDF {
	NSString *tempPath = [[NSFileManager defaultManager] createTemporaryFile];	
	[self saveToFile:tempPath];
	return tempPath;
}

- (IBAction)save:(id)sender {
	NSSavePanel *savePanel = [NSSavePanel savePanel];
	int result;
	
	[savePanel setRequiredFileType:@"pdf"];
	result = [savePanel runModal];
	
	if (result == NSOKButton) {
		[self saveToFile:[savePanel filename]];
	}
}

- (void)saveToFile:(NSString *)path {
	[[pdfView document] writeToFile:path];
}

- (IBAction)print:(id)sender {
	NSPrintOperation *printOperation = [NSPrintOperation printOperationWithView:pdfView];
	NSPrintPanel *printPanel = [printOperation printPanel];
	[printPanel setOptions:NSPrintPanelShowsCopies | NSPrintPanelShowsPaperSize | 
	 NSPrintPanelShowsOrientation | NSPrintPanelShowsScaling | NSPrintPanelShowsPreview];
	[printPanel runModal];
}

- (void)updatePDF {
	NSData *pdfData = [hiddenPrintView dataWithPDFInsideRect:[hiddenPrintView frame]];
	PDFDocument *document = [[PDFDocument alloc] initWithData:pdfData];
	[pdfView setDocument:document];
	[document release];
}

@end
