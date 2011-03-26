//
//  NSFileManager+TemporaryDirectory.m
//  Kineo
//
//  Created by Ben Yellin on 3/26/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import "NSFileManager+TemporaryDirectory.h"


@implementation NSFileManager (TemporaryDirectory)

- (NSString *)createTemporaryDirectory {
	// Create a unique directory in the system temporary directory
	NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString];
	NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:guid];
	if (![self createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil]) {
		return nil;
	}
	return path;
}

- (NSString *)createTemporaryFile {
	// Create a unique directory in the system temporary directory
	NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString];
	NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:guid];
	if (![self createFileAtPath:path contents:nil attributes:nil]) {
		return nil;
	}
	return path;
}

@end
