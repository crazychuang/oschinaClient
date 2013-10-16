//
//  UITap.h
//  oschinaClient
//
//  Created by boai on 13-7-10.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweetModel.h"
@interface UITap : UITapGestureRecognizer
{
    int _nTag;
    NSString *_strTagString;
    
}
@property (assign, nonatomic) int nTag;
@property (copy, nonatomic) NSString *strTagString;

@end
