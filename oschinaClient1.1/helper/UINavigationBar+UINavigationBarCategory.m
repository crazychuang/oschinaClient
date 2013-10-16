//
//  UINavigationBar+UINavigationBarCategory.m
//  qiushibaike
//
//  Created by chuang on 13-5-8.
//  Copyright (c) 2013年 com.bravetorun. All rights reserved.
//

#import "UINavigationBar+UINavigationBarCategory.h"

@implementation UINavigationBar (UINavigationBarCategory)
- (void)drawRect:(CGRect)rect
{
    UIImage *_imageBackGround = [UIImage imageNamed:@"navBg"];
    [_imageBackGround drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
