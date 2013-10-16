//
//  AppDelegate.h
//  oschinaClient
//
//  Created by boai on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingView.h"
#import "complexPage.h"
#import "queAnswPage.h"
#import "twitterPage.h"
#import "IIViewDeckController.h"
#import "leftSideViewPage.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    IIViewDeckController *_viewController;
    
    UIImageView *_zView;
    UIImageView *_fView;
    UIView *_rView;
}
@property (strong, nonatomic) IIViewDeckController *viewCotroller;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SettingView *settingView;
@property (strong, nonatomic) UITabBarController *tabBarController;
@end
