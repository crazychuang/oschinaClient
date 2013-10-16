//
//  SettingModel.m
//  oschinaClient
//
//  Created by boai on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "SettingModel.h"

@implementation SettingModel
@synthesize strImg = _strImg;
@synthesize strTitle = _strTitle;
@synthesize strTitle2 = _strTitle2;

- (id)initWith:(NSString *)_title img:(NSString *)_img tag:(int)_tag title2:(NSString *)_title2
{
    if (self = [super init]) {
        self.strTitle = _title;
        self.strImg   = _strImg;
        self.strTitle2 = _strTitle2;
        self.nTag = _tag;
    }
    return self;
}

- (void)dealloc
{
    [_strTitle2 release];
    [_strImg release];
    [_strTitle2 release];
    [super dealloc];
}

@end
