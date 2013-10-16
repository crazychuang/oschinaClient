//
//  aninationView.m
//  oschinaClient1.1
//
//  Created by boai on 13-8-20.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "aninationView.h"

@implementation aninationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.screenShotView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.screenShotView];
    }
    return self;
}

 + (id) sharedAnimationView
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen] bounds].size.height - 20)];
    });
    return _sharedObject;
}


- (void)doViewTransitionAnimationCrossDissolve:(UIViewController *)viewcontroller
{
    BOOL isBigToSmall = self.targetView.frame.size.width > 140;
    
    for (UIView *vv in viewcontroller.view.subviews) {
        if (![vv isKindOfClass:[self class]]) {
            vv.alpha = 0.0f;
        }
    }
    
    if (!isBigToSmall) {
        for (UIView *ss in self.subviews) {
            if ([ss isKindOfClass:[UIButton class]]) {
                [ss removeFromSuperview];
            }
        }
        [self addSubview:self.targetView];
    }
    
    self.screenShotView.image = self.screenShot;
    
    if (isBigToSmall) {
        self.targetView.alpha = 0;
        self.screenShotView.alpha = 1;
    }else{
        self.targetView.alpha = 1;
        self.screenShotView.alpha = 1;
    }
    
    [UIView animateWithDuration:0.5f
                          delay:0.01f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         for (UIView *vv in viewcontroller.view.subviews) {
                             if (![vv isKindOfClass:[self class]]) {
                                 vv.alpha = 1;
                             }
                         }
                         self.targetView.alpha = 1 - self.targetView.alpha;
                         self.screenShotView.alpha = 1 - self.screenShotView.alpha;
                         
                         CGRect pointRect = self.targetView.frame;
                         
                         if (isBigToSmall) {
                             [self.targetView setTransform:CGAffineTransformMake(1, 0, 0, 1, - self.center.x + (pointRect.origin.x+0.5*pointRect.size.width), - self.center.y + (pointRect.origin.y + 0.5*pointRect.size.height))];
                             
                         }else{
                             CGFloat scalfactor = (self.targetView.frame.size.width == 140 ? 5 : 10);
                             [self.targetView setTransform:CGAffineTransformMake(scalfactor, 0, 0, scalfactor, self.center.x - (pointRect.origin.x+0.5*pointRect.size.width), self.center.y - (pointRect.origin.y + 0.5*pointRect.size.height))];
                         }
    }
                     completion:^(BOOL finished) {
                         if ([viewcontroller respondsToSelector:@selector(transitionViewAnimationFinished)]) {
                             [viewcontroller performSelector:@selector(transitionViewAnimationFinished)];
                         }
    }];
}

@end
