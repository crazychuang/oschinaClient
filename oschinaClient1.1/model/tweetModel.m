//
//  tweetModel.m
//  oschinaClient
//
//  Created by boai on 13-7-8.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "tweetModel.h"

@implementation tweetModel
@synthesize strTweetID = _strTweetID;
@synthesize strPortrait = _strPortrait;
@synthesize strAuthor = _strAuthor;
@synthesize strAuthorID = _strAuthorID;
@synthesize strBody = _strBody;
@synthesize nAppClient = _nAppClient;
@synthesize nCommentCount = _nCommentCount;
@synthesize strPubDate = _strPubDate;
@synthesize strUrlImgBig = _strUrlImgBig;
@synthesize strUrlImgSmall = _strUrlImgSmall;
- (void)dealloc
{
    [_strTweetID release];
    [_strPortrait release];
    [_strAuthorID release];
    [_strBody release];
    [_strPubDate release];
    [_strUrlImgSmall release];
    [_strUrlImgBig release];
    [super dealloc];
}

- (id)initWith:(TBXMLElement *)xml
{
    if (self = [super init]) {
        TBXMLElement *tweetID = [TBXML childElementNamed:@"id" parentElement:xml];
        TBXMLElement *portrait = [TBXML childElementNamed:@"portrait" parentElement:xml];
        TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:xml];
        TBXMLElement *authorID = [TBXML childElementNamed:@"authorid" parentElement:xml];
        TBXMLElement *body = [TBXML childElementNamed:@"body" parentElement:xml];
        TBXMLElement *appclient = [TBXML childElementNamed:@"appclient" parentElement:xml];
        TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:xml];
        TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:xml];
        TBXMLElement *imgSmall = [TBXML childElementNamed:@"imgSmall" parentElement:xml];
        TBXMLElement *imgBig = [TBXML childElementNamed:@"imgBig" parentElement:xml];
        
        self.strTweetID = [TBXML textForElement:tweetID];
        self.strPortrait = [TBXML textForElement:portrait];
        self.strAuthor = [TBXML textForElement:author];
        self.strAuthorID = [TBXML textForElement:authorID];
        self.strBody = [TBXML textForElement:body];
        self.nAppClient = [[TBXML textForElement:appclient] intValue];
        self.nCommentCount = [[TBXML textForElement:commentCount] intValue];
        self.strPubDate = [TBXML textForElement:pubDate];
        self.strUrlImgSmall = [TBXML textForElement:imgSmall];
        self.strUrlImgBig = [TBXML textForElement:imgBig];
        
    }
    return self;
}



@end
