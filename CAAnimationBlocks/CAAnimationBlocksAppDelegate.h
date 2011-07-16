//
//  CAAnimationBlocksAppDelegate.h
//  CAAnimationBlocks
//
//  Created by xissburg on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAAnimationBlocksViewController;

@interface CAAnimationBlocksAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CAAnimationBlocksViewController *viewController;

@end
