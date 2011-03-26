//
//  NSFileManager+TemporaryDirectory.h
//  Kineo
//
//  Created by Ben Yellin on 3/26/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>


// Thanks: Philipp
// http://stackoverflow.com/questions/215820/how-do-i-create-a-temporary-file-with-cocoa/4001613#4001613

@interface NSFileManager (TemporaryDirectory)
- (NSString *)createTemporaryDirectory;
- (NSString *)createTemporaryFile;
@end
