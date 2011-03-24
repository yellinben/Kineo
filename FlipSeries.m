//
//  FlipSeries.m
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "FlipSeries.h"


@implementation FlipSeries

@synthesize images, title, dateCreated;

- (id)init {
	if (self = [super init]) {
		images = [[NSMutableArray alloc] init];
		title = @"Unititled";
		dateCreated = [NSDate date]; // now		
	}
	return self;
}

- (void)dealloc {
	[images release];
	self.title = nil;
	[dateCreated release];
	[super dealloc];
}

- (void)addImage:(NSImage *)img {
	[images addObject:img];
}

- (NSImage *)getImage:(NSInteger)index {
	if (index >= [images count])
		return nil;
	
	return [images objectAtIndex:index];
}

- (NSInteger)numberOfImages {
	return [images count];
}

@end
