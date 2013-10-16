//
//  mePage.m
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "mePage.h"
#import "allAboutMePage.h"
#import "aninationView.h"

#define TAG_BTN_BASE        0
#define TAG_BTN_ALL         TAG_BTN_BASE + 0
#define TAG_BTN_AT_ME       TAG_BTN_BASE + 1
#define TAG_BTN_COMMENT     TAG_BTN_BASE + 2
#define TAG_BTN_ME          TAG_BTN_BASE + 3
#define TAG_BTN_MSG         TAG_BTN_BASE + 4
@interface mePage ()

@end

@implementation mePage

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
    
    UIView *btn = [[aninationView sharedAnimationView] targetView];
    if (btn.frame.size.width > 140) {
        [self.view addSubview:[aninationView sharedAnimationView]];
        [[aninationView sharedAnimationView] doViewTransitionAnimationCrossDissolve:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_scrollView setContentSize:CGSizeMake(320, iPhone5 ? 560 : 490)];
}

- (void)transitionViewAnimationFinished{
    [[self.view.subviews lastObject] removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)MeBtnPressed:(id)sender {
    UIButton *_btn = (UIButton *)sender;
    allAboutMePage *vc = nil;
    switch (_btn.tag) {
        case TAG_BTN_ALL:
        {
            vc = [[[allAboutMePage alloc] initWithNibName:[oschinaTool getXibName:@"allAboutMePage"] bundle:nil] autorelease];
            vc = (allAboutMePage *)vc;
            vc.strTitle = _btn.titleLabel.text;
        }
            break;
        case TAG_BTN_AT_ME:
        {
            
        }
            break;
        case TAG_BTN_COMMENT:
        {
            
        }
            break;
        case TAG_BTN_ME:
        {
            
        }
            break;
        case TAG_BTN_MSG:
        {
            
        }
            break;
        default:
            break;
    }
    
    UIButton *_animationBtn = [[UIButton alloc] init];
    [_animationBtn setImage:[_btn backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    
    CGPoint pointView = [self.view convertPoint:_btn.frame.origin fromView:_scrollView];
    CGRect pointRect = CGRectMake(pointView.x, pointView.y, _btn.frame.size.width , _btn.frame.size.height);
    _animationBtn.frame = pointRect;
    
    [[aninationView sharedAnimationView] setScreenShot:[oschinaTool renderImageFromView:self.view]];
    [[aninationView sharedAnimationView] setTargetView:_animationBtn];
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)closeThisPage:(id)sender {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}
@end
