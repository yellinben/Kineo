//
//  FlipSeries.h
//  Kineo
//
//  Created by Ben Yellin on 3/20/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FlipSeries : NSObject {	
	NSMutableArray *images;
	NSString *title;
	NSDate *dateCreated;
}
@property (readonly) NSMutableArray *images;
@property (nonatomic,retain) NSString *title;
@property (readonly) NSDate *dateCreated;
- (void)addImage:(CIImage *)img;
@end
