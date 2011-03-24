//
//  NSImage+Extras.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "NSImage+Extras.h"


@implementation NSImage (Extras)

// Thanks to Petteri Kamppuri
// http://theocacao.com/document.page/350/
+ (NSImage *)imageFromCIImage:(CIImage *)ciImage {
	NSImage *image = [[[NSImage alloc] initWithSize:NSMakeSize([ciImage extent].size.width, [ciImage extent].size.height)] autorelease];	
	[image addRepresentation:[NSCIImageRep imageRepWithCIImage:ciImage]];	
	return image;
}

@end
