//
//  UserModel.h
//  oschinaClient
//
//  Created by boai on 13-6-15.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface UserModel : NSObject
{
    NSString *_strUid;
    NSString *_strLocation;
    NSString *_strUser;
    int      _nFollowers;
    int      _nFans;
    int      _nScore;
    int      _nAtmeCount;
    int      _nMsgCount;
    int      _nReviewCount;
    int      _nNewFansCount;
}

@property (retain, nonatomic) NSString *strUid;
@property (retain, nonatomic) NSString *strLocation;
@property (retain, nonatomic) NSString *strUser;
@property (assign, nonatomic) int nFollowers;
@property (assign, nonatomic) int nFans;
@property (assign, nonatomic) int nScore;
@property (assign, nonatomic) int nAtmeCount;
@property (assign, nonatomic) int nMsgCount;
@property (assign, nonatomic) int nReviewCount;
@property (assign, nonatomic) int nNewFansCount;

- (id)initWithXml:(TBXML *)xml;
@end
