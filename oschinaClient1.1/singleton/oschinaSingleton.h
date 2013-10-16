//
//  oschinaSingleton.h
//  oschinaClient
//
//  Created by boai on 13-7-18.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface oschinaSingleton : NSObject
{
    UserModel *_user;
    int       _nSkin_Nav;
    int       _nSkin_BG;
    
    UIImage *_screenShot;
    UIView *_targetView;
    UIImageView *_screenShotView;
    
}

@property (retain, nonatomic)UserModel *user;
@property (assign, nonatomic)int nSkin_Nav;
@property (assign, nonatomic)int nSkin_BG;

@property (retain, nonatomic)UIImage *screenShot;
@property (retain, nonatomic)UIView *targetView;
@property (retain, nonatomic)UIImageView *screenShotView;
+ (oschinaSingleton *)sharedInstance;
@end
