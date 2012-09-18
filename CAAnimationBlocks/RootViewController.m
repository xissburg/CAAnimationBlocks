//
//  RootViewController.m
//  RootViewController
//
//  Created by xissburg on 7/16/11.
//  Copyright 2011 xissburg. All rights reserved.
//

#import "RootViewController.h"
#import "CAAnimation+Blocks.h"
#import <QuartzCore/QuartzCore.h>


@implementation RootViewController

@synthesize imageView, anotherImageView;

- (void)dealloc
{
    self.imageView = nil;
    self.anotherImageView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.layer.shadowOffset = CGSizeMake(0, 4);
    self.imageView.layer.shadowRadius = 7;
    self.imageView.layer.shadowOpacity = 0.7;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.imageView = nil;
    self.anotherImageView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(runAnimation:) withObject:nil afterDelay:1.0];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)runAnimation:(id)unused
{
    // Create a shaking animation that rotates a bit counter clockwisely and then rotates another
    // bit clockwisely and repeats. Basically, add a new rotation animation in the opposite
    // direction at the completion of each rotation animation.
    const CGFloat duration = 0.1f;
    const CGFloat angle = 0.03f;
    NSNumber *angleR = [NSNumber numberWithFloat:angle];
    NSNumber *angleL = [NSNumber numberWithFloat:-angle];
    
    CABasicAnimation *animationL = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    CABasicAnimation *animationR = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    void (^completionR)(BOOL) = ^(BOOL finished) {
        [self.imageView.layer setValue:angleL forKey:@"transform.rotation.z"];
        [self.imageView.layer addAnimation:animationL forKey:@"L"]; // Add rotation animation in the opposite direction.
    };
    
    void (^completionL)(BOOL) = ^(BOOL finished) {
        [self.imageView.layer setValue:angleR forKey:@"transform.rotation.z"];
        [self.imageView.layer addAnimation:animationR forKey:@"R"];
    };
    
    animationL.fromValue = angleR;
    animationL.toValue = angleL;
    animationL.duration = duration;
    animationL.completion = completionL; // Set completion to perform rotation in opposite direction upon completion.
    
    animationR.fromValue = angleL;
    animationR.toValue = angleR;
    animationR.duration = duration;
    animationR.completion = completionR;
    
    // First animation performs half rotation and then proceeds to enter the loop by playing animationL in its completion block
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = angleR;
    animation.duration = duration/2;
    animation.completion = completionR;
    
    [self.imageView.layer setValue:angleR forKey:@"transform.rotation.z"];
    [self.imageView.layer addAnimation:animation forKey:@"0"];
    
    // Setup another animation just to show a different coding style
    CABasicAnimation *anotherAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anotherAnimation.fromValue = [NSNumber numberWithFloat:self.anotherImageView.layer.position.x];
    anotherAnimation.toValue = [NSNumber numberWithFloat:600];
    anotherAnimation.duration = 2;
    [anotherAnimation setCompletion:^(BOOL finished) {
        CABasicAnimation *oneMoreAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        oneMoreAnimation.fromValue = [NSNumber numberWithFloat:600];
        oneMoreAnimation.toValue = [NSNumber numberWithFloat:160];
        oneMoreAnimation.duration = 1;
        [self.anotherImageView.layer addAnimation:oneMoreAnimation forKey:@"1"];
    }];
    [self.anotherImageView.layer addAnimation:anotherAnimation forKey:@"1"];
}

@end
