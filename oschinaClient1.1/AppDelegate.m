//
//  AppDelegate.m
//  oschinaClient
//
//  Created by boai on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate
@synthesize settingView;
@synthesize tabBarController;
@synthesize viewCotroller = _viewController;
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    complexPage *complex = [[complexPage alloc] initWithNibName:[oschinaTool getXibName:@"complexPage"] bundle:nil];
    UINavigationController *complexNav = [[UINavigationController alloc] initWithRootViewController:complex];
    
    leftSideViewPage *leftSidePage = [[leftSideViewPage alloc] initWithNibName:[oschinaTool getXibName:@"leftSideViewPage"] bundle:nil];
    _viewController = [[IIViewDeckController alloc] initWithCenterViewController:complexNav leftViewController:leftSidePage];
    //_viewController.enabled = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewCotroller;
    [self.window makeKeyAndVisible];
    
    
    SQLiteDatabase *_db = [oschinaTool initDB:DB_OSCHINA_CLIENT];
    bool _bRet = [oschinaTool createTweetTable:_db nametable:@"tweetCache"];
    NSLog(@"%d",_bRet);
    [_db close];
    
//    _fView = [[UIImageView alloc] initWithFrame:_window.frame];
//    _fView.image = [UIImage imageNamed:@"f"];
//    
//    _zView = [[UIImageView alloc] initWithFrame:_window.frame];
//    _zView.image = [UIImage imageNamed:@"z"];
//    
//    _rView = [[UIView alloc] initWithFrame:_window.frame];
//    
//    [_rView addSubview:_fView];
//    [_rView addSubview:_zView];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(3);
//        
//    });
    //sleep(3);
    return YES;
}

- (void)TheAnimation{
    CATransition *_animation = [CATransition animation];
    _animation.delegate = self;
    _animation.duration = 0.7f;
    //_animation.timingFunction = UIViewAnimationCurveEaseInOut;
    _animation.type = kCATransitionFade;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
