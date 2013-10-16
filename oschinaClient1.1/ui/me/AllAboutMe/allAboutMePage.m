//
//  allAboutMePage.m
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "allAboutMePage.h"
#import "aninationView.h"
@interface allAboutMePage ()

@end

@implementation allAboutMePage
@synthesize strTitle = _strTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.headView.lbl_NavTitle setText:_strTitle];
}

- (void)transitionViewAnimationFinished{
    [[self.view.subviews lastObject] removeFromSuperview];
}

- (void)customPopAction{
    [[aninationView sharedAnimationView] setScreenShot:[oschinaTool renderImageFromView:self.view]];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:[aninationView sharedAnimationView]];
    [[aninationView sharedAnimationView] doViewTransitionAnimationCrossDissolve:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
