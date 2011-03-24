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
@property (nonatomic, readonly) NSMutableArray *images;
@property (nonatomic,retain) NSString *title;
@property (nonatomic, readonly) NSDate *dateCreated;
- (void)addImage:(NSImage *)img;
- (NSImage *)getImage:(NSInteger)index;
- (NSInteger)numberOfImages;
@end
