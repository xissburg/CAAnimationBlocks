//
//  AppDelegate.h
//  AppDelegate
//
//  Created by xissburg on 7/16/11.
//  Copyright 2011 xissburg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet RootViewController *viewController;

@end
