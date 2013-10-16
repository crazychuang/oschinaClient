//
//  TweetImgDetail.m
//  oschinaClient
//
//  Created by boai on 13-7-10.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "TweetImgDetail.h"

@interface TweetImgDetail ()

@end

@implementation TweetImgDetail
@synthesize strImgHref = _strImgHref;
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
    
    NSString *imgStr = [NSString stringWithFormat:@"<div style='margin:auto;width:640px;'><img width='640' style='vertical-align:middle' src='%@'/></div>",self.strImgHref];
    [self.web_Img loadHTMLString:imgStr baseURL:nil];
    [oschinaTool clearWebViewBackgrount:self.web_Img];
}

- (void)configureNavViews
{
    switch ([oschinaSingleton sharedInstance].nSkin_Nav) {
        case TAG_SKIN_DAYTIME:
        {
            [_imgView_nav setImage:[UIImage imageNamed:@"navBg"]];
        }
            break;
        case TAG_SKIN_NIGHT:
        {
            [_imgView_nav setImage:[UIImage imageNamed:@"head_background"]];
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
    [_strImgHref release];
    [_web_Img release];
    [_imgView_nav release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWeb_Img:nil];
    [self setImgView_nav:nil];
    [super viewDidUnload];
}
- (IBAction)closeThisPage:(id)sender {
    [self dismissSemiModalViewWithCompletion:nil];
}
@end
