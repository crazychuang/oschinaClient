//
//  CustomNavPage.m
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "CustomNavPage.h"

@interface CustomNavPage ()

@end

@implementation CustomNavPage
@synthesize headView = _headView;
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
    
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"fatherHeadView" owner:self options:nil] objectAtIndex:0];
    self.headView.frame = CGRectMake(0, 0, _headView.frame.size.width, _headView.frame.size.height);
    [self.view addSubview:_headView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
