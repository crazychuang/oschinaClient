//
//  superPage.m
//  oschinaClient
//
//  Created by boai on 13-8-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "superPage.h"

@interface superPage ()

@end

@implementation superPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	[self registerAsObserver];
    [self configureNavViews];
    [self configureBgViews];
}

- (void)registerAsObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(configureNavViews) name:TAG_CHANGE_NAV_THEME_NOT object:nil];
    [center addObserver:self selector:@selector(configureBgViews) name:TAG_CHANGE_BG_THEME_NOT object:nil];
}

- (void)configureNavViews;
{
    float _fVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (_fVersion >= 5.0f) {
        switch ([oschinaSingleton sharedInstance].nSkin_Nav) {
            case TAG_SKIN_DAYTIME:
            {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBg"] forBarMetrics:UIBarMetricsDefault];
            }
                break;
            case TAG_SKIN_NIGHT:
            {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"head_background"] forBarMetrics:UIBarMetricsDefault];
            }
                break;
            default:
                break;
        }
        
    }
}

- (void)configureBgViews
{
    switch ([oschinaSingleton sharedInstance].nSkin_BG) {
        case TAG_SKIN_BLUE:
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        }
            break;
        case TAG_SKIN_RED:
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
        }
            break;
        case TAG_SKIN_BLACK:
        {
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"IndexBG"]]];
        }
            break;
        default:
            break;
    }
}

- (void)unregisterAsObserver
{
    NSNotificationCenter *certer = [NSNotificationCenter defaultCenter];
    [certer removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [self unregisterAsObserver];
    [super dealloc];
}


@end
