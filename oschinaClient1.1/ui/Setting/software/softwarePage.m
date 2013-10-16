//
//  softwarePage.m
//  oschinaClient
//
//  Created by boai on 13-6-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "softwarePage.h"

@interface softwarePage ()

@end

@implementation softwarePage

@synthesize softwareType = _softwareType;
@synthesize software = _software;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    WXJSliderSwitch *_slider = [[WXJSliderSwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 48 * 5, 29)];
    [_slider setSliderSwitchBg:[UIImage imageNamed:@"top_tab_background3"]];
    _slider.nLabelCount = 5;
    _slider.nTabWidth = 48;
    _slider.nTabOffset = 0;
    _slider.delegate = self;
    [_slider initSliderSwitch:@"分类",@"推荐",@"最新",@"热门",@"国产"];
    self.navigationItem.titleView = _slider;
    [_slider release];
    

    self.softwareType = [[softwareTypesPage alloc] initWithNibName:[oschinaTool getXibName:@"softwareTypesPage"] bundle:nil];
    self.softwareType.nTag = 0;
    [self addChildViewController:self.softwareType];
    [self.view addSubview:self.softwareType.view];
    
    self.software = [[softwareOptionsPage alloc] initWithNibName:[oschinaTool getXibName:@"softwareOptionsPage"] bundle:nil];
    self.software.view.hidden = YES;
    [self addChildViewController:self.software];
    [self.view addSubview:self.software.view];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_software release];
    [_softwareType release];
   
    [super dealloc];
}

- (void)slideView:(WXJSliderSwitch *)slideSwitch switchChangedAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            self.softwareType.view.hidden = NO;
            self.software.view.hidden = YES;
        }
            break;
        case 1:
        {
            self.softwareType.view.hidden = YES;
            self.software.view.hidden = NO;
            self.software.strSearchTag = @"recommend";
            self.software.nTag = ERROR_BASE;
            [self.software reloadData];
        }
            break;
        case 2:
        {
            self.softwareType.view.hidden = YES;
            self.software.view.hidden = NO;
            self.software.strSearchTag = @"time";
            self.software.nTag = ERROR_BASE;
            [self.software reloadData];
        }
            break;
        case 3:
        {
            self.softwareType.view.hidden = YES;
            self.software.view.hidden = NO;
            self.software.strSearchTag = @"view";
            self.software.nTag = ERROR_BASE;
            [self.software reloadData];
        }
            break;
        case 4:
        {
            self.softwareType.view.hidden = YES;
            self.software.view.hidden = NO;
            self.software.strSearchTag = @"list_cn";
            self.software.nTag = ERROR_BASE;
            [self.software reloadData];
        }
            break;
        default:
            break;
    }
}

@end
