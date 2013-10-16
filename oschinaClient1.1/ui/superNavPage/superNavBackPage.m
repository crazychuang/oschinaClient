//
//  superNavBackPage.m
//  oschinaClient
//
//  Created by boai on 13-7-13.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "superNavBackPage.h"

@interface superNavBackPage ()

@end

@implementation superNavBackPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(20, 5, 50, 30);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[[UIBarButtonItem alloc] initWithCustomView:backBtn] autorelease];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

- (void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)setNavTxt:(NSString *)title
//{
//    UILabel *_lblTile = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
//    [_lblTile setBackgroundColor:[UIColor clearColor]];
//    [_lblTile setTextColor:[UIColor whiteColor]];
//    [_lblTile setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:20]];
//    [_lblTile setText:title];
//    [_lblTile setTextAlignment:UITextAlignmentCenter];
//    [self.navigationItem setTitleView:_lblTile];
//    [_lblTile release];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
