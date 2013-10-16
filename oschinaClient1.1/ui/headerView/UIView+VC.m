//
//  UIView+VC.m
//  oschinaClient1.1
//
//  Created by boai on 13-8-20.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "UIView+VC.h"

@implementation UIView (VC)
- (UIViewController *)viewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    }else{
        return nil;
    }
}
@end
