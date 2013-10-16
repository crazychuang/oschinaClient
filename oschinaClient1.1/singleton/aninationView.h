//
//  aninationView.h
//  oschinaClient1.1
//
//  Created by boai on 13-8-20.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aninationView : UIView

@property (nonatomic, retain) UIImage *screenShot;
@property (nonatomic, retain) UIView *targetView;
@property (nonatomic, retain) UIImageView *screenShotView;

+ (id)sharedAnimationView;

- (void)doViewTransitionAnimationCrossDissolve:(UIViewController *)viewcontroller;
@end
