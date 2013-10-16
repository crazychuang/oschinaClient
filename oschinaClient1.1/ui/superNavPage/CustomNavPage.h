//
//  CustomNavPage.h
//  oschinaClient1.1
//
//  Created by boai on 13-8-19.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fatherHeadView.h"
#import "superNavBackPage.h"
@interface CustomNavPage : superNavBackPage
{
    fatherHeadView *_headView;
}
@property (retain, nonatomic) fatherHeadView *headView;
@end
