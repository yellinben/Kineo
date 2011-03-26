//
//  CameraView.h
//  Kineo
//
//  Created by Ben Yellin on 3/24/11.
//  Copyright 2011 Been Yelling. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTCaptureView.h>

@interface CameraView : QTCaptureView {
	BOOL showFlash;
}
- (void)flashView;
@end
