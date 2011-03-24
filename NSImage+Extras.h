//
//  NSImage+Extras.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSImage (Extras)
+ (NSImage *)imageFromCIImage:(CIImage *)img;
@end
