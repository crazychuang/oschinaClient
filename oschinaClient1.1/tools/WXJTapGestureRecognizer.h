//
//  WXJTapGestureRecognizer.h
//  oschinaClient
//
//  Created by boai on 13-8-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXJTapGestureRecognizer : UITapGestureRecognizer
{
    int _nTag;
}
@property (assign,nonatomic)int nTag;
@end
