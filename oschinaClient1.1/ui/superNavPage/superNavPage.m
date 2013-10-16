//
//  superNavPage.m
//  oschinaClient
//
//  Created by boai on 13-6-28.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "superNavPage.h"

@interface superNavPage ()

@end

@implementation superNavPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        leftBtn = [[[UIButton alloc] init] autorelease];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG"] forState:UIControlStateNormal];
        
        [leftBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
        leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
        [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    }
    return self;
}

- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setNavTxt:(NSString *)title
{
    UILabel *_lblTile = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    [_lblTile setBackgroundColor:[UIColor clearColor]];
    [_lblTile setTextColor:[UIColor whiteColor]];
    [_lblTile setFont:[UIFont fontWithName:@"DFShaoNvW5-GB" size:20]];
    [_lblTile setText:title];
    [_lblTile setTextAlignment:UITextAlignmentCenter];
    [self.navigationItem setTitleView:_lblTile];
    [_lblTile release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
    [super dealloc];
}


@end
