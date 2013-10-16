//
//  aboutPage.m
//  oschinaClient
//
//  Created by boai on 13-6-28.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "aboutPage.h"
#import "oschinaTool.h"
@interface aboutPage ()

@end

@implementation aboutPage

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
    [self setNavTxt:@"关于我们"];
    self.lbl_version.text = [NSString stringWithFormat:@"版本:%@",[oschinaTool getAppVersion]];
    [self.lbl_version setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:20]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_lbl_version release];
    [super dealloc];
}
@end
