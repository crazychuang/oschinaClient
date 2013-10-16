//
//  oschinaSingleton.m
//  oschinaClient
//
//  Created by boai on 13-7-18.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "oschinaSingleton.h"
@implementation oschinaSingleton
@synthesize user = _user;
@synthesize nSkin_Nav = _nSkin_Nav;
@synthesize nSkin_BG = _nSkin_BG;

@synthesize screenShot = _screenShot;
@synthesize targetView = _targetView;
@synthesize screenShotView = _screenShotView;


static oschinaSingleton *shareInstance = nil;
+ (oschinaSingleton *)sharedInstance
{
    @synchronized(self)
    {
        if (shareInstance == nil) {
            shareInstance = [[oschinaSingleton alloc] init];
            [shareInstance initData];
        }
    }
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareInstance == nil) {
            shareInstance = [super allocWithZone:zone];
            return shareInstance;
        }
    }
    return nil;
}

- (void)initData
{
    _user = [[UserModel alloc] init];
    _nSkin_Nav = TAG_SKIN_DAYTIME;
    _nSkin_BG = TAG_SKIN_BLUE;
}

- (void)dealloc
{
    [_user release];
    [super dealloc];
}

@end
