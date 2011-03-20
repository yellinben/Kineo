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

- (void)addImage:(CIImage *)img {
	[images addObject:img];
}

@end
