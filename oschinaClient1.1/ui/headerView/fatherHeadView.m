//
//  fatherHeadView.m
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "fatherHeadView.h"
#import "allAboutMePage.h"
@implementation fatherHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)dealloc {
    
    [_lbl_NavTitle release];
    [super dealloc];
}
- (IBAction)popSubVc:(id)sender {
    
    UIViewController *vc = [self.superview viewController];
    if ([vc isKindOfClass:[allAboutMePage class]]) {
        [(allAboutMePage *)vc customPopAction];
    }else{
        [vc.navigationController popViewControllerAnimated:YES];
    }
}
@end
