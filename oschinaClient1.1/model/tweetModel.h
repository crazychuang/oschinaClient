//
//  tweetModel.h
//  oschinaClient
//
//  Created by boai on 13-7-8.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface tweetModel : NSObject
{
    NSString *_strTweetID;
    NSString *_strPortrait;
    NSString *_strAuthor;
    NSString *_strAuthorID;
    NSString *_strBody;
    int      _nAppClient;
    int      _nCommentCount;
    NSString *_strPubDate;
    NSString *_strUrlImgSmall;
    NSString *_strUrlImgBig;
    
}
@property (copy, nonatomic) NSString *strTweetID;
@property (copy, nonatomic) NSString *strPortrait;
@property (copy, nonatomic) NSString *strAuthor;
@property (copy, nonatomic) NSString *strAuthorID;
@property (copy, nonatomic) NSString *strBody;
@property (assign, nonatomic) int nAppClient;
@property (assign, nonatomic) int nCommentCount;
@property (copy, nonatomic) NSString *strPubDate;
@property (copy, nonatomic) NSString *strUrlImgSmall;
@property (copy, nonatomic) NSString *strUrlImgBig;
- (id)initWith:(TBXMLElement *)xml;

@end
