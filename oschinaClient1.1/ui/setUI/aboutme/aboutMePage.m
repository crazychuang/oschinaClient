//
//  aboutMePage.m
//  oschinaClient
//
//  Created by boai on 13-8-16.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "aboutMePage.h"

@interface aboutMePage ()

@end

@implementation aboutMePage

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
    _theView.clipsToBounds = YES;
    _theView.frame = CGRectMake(_theView.frame.origin.x, _theView.frame.origin.y, _theView.frame.size.width, 0);
    _lbl_aboutMe.alpha = 0.0f;
    [UIView animateWithDuration:1.5 animations:^{
        _theView.frame = CGRectMake(_theView.frame.origin.x, _theView.frame.origin.y, _theView.frame.size.width, 274);
        _lbl_aboutMe.alpha = 0.5f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 animations:^{
            _lbl_aboutMe.alpha = 1.0f;
        }];
    }];
}

- (void)configureNavViews
{
    switch ([oschinaSingleton sharedInstance].nSkin_Nav) {
        case TAG_SKIN_DAYTIME:
        {
            [_navBg setImage:[UIImage imageNamed:@"navBg"]];
        }
            break;
        case TAG_SKIN_NIGHT:
        {
            [_navBg setImage:[UIImage imageNamed:@"head_background"]];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_theView release];
    [_lbl_aboutMe release];
    [_navBg release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTheView:nil];
    [self setLbl_aboutMe:nil];
    [self setNavBg:nil];
    [super viewDidUnload];
}
- (IBAction)closeThepage:(id)sender {
}
@end
