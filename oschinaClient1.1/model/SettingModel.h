//
//  SettingModel.h
//  oschinaClient
//
//  Created by boai on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingModel : NSObject
{
    NSString *_strImg;
    NSString *_strTitle;
    NSString *_strTitle2;
    int      _nTag;
}
@property (retain, nonatomic) NSString *strImg;
@property (retain, nonatomic) NSString *strTitle;
@property (retain, nonatomic) NSString *strTitle2;
@property (assign, nonatomic) int      nTag;

- (id)initWith:(NSString *)_title img:(NSString *)_img tag:(int)_tag title2:(NSString *)_title2;
@end
