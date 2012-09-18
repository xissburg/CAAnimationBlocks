//
//  CAAnimation+Blocks.m
//  CAAnimationBlocks
//
//  Created by xissburg on 7/7/11.
//  Copyright 2011 xissburg. All rights reserved.
//

#import "CAAnimation+Blocks.h"
#import <objc/objc-class.h>


@interface CAAnimationDelegate : NSObject

@property (nonatomic, copy) void (^completion)(BOOL);
@property (nonatomic, copy) void (^start)(void);

- (void)animationDidStart:(CAAnimation *)anim;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

@end

@implementation CAAnimationDelegate

@synthesize completion=_completion;
@synthesize start=_start;

- (id)init
{
    self = [super init];
    if (self) {
        self.completion = nil;
        self.start = nil;
    }
    return self;
}

- (void)dealloc
{
    self.completion = nil;
    self.start = nil;
    [super dealloc];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.start != nil) {
        self.start();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completion != nil) {
        self.completion(flag);
    }
}

@end


@implementation CAAnimation (BlocksAddition)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
        Method newMethod = class_getInstanceMethod([self class], @selector(_setDelegate:));
        method_exchangeImplementations(originalMethod, newMethod);
    });
}

- (void)_setDelegate:(id)delegate
{
    NSAssert([delegate isKindOfClass:[CAAnimationDelegate class]], @"CAAnimationBlocks: Do not set the delegate, use the start and completion blocks instead. Or, remove the CAAnimation+Blocks.h/m from your project.");
    [self _setDelegate:delegate];
}

- (void)setCompletion:(void (^)(BOOL))completion
{
    if (self.delegate == nil) {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.completion = completion;
        self.delegate = delegate;
        [delegate release];
    }
    else {
        CAAnimationDelegate *delegate = (CAAnimationDelegate *)self.delegate;
        delegate.completion = completion;
    }
}

- (void (^)(BOOL))completion
{
    return ((CAAnimationDelegate *)self.delegate).completion;
}

- (void)setStart:(void (^)(void))start
{
    if (self.delegate == nil) {
        CAAnimationDelegate *delegate = [[CAAnimationDelegate alloc] init];
        delegate.start = start;
        self.delegate = delegate;
        [delegate release];
    }
    else {
        CAAnimationDelegate *delegate = (CAAnimationDelegate *)self.delegate;
        delegate.start = start;
    }
}

- (void (^)(void))start
{
    return ((CAAnimationDelegate *)self.delegate).start;
}

@end
