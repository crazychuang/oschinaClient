//
//  commentModel.m
//  oschinaClient
//
//  Created by boai on 13-7-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "commentModel.h"

@implementation commentModel
@synthesize strID = _strID;
@synthesize strPortrait = _strPortrait;
@synthesize strAuthor = _strAuthor;
@synthesize strAuthorID = _strAuthorID;
@synthesize strContent = _strContent;
@synthesize strPubDate = _strPubDate;
@synthesize nAppclient = _nAppclient;

- (void)dealloc
{
    [_strID release];
    [_strPortrait release];
    [_strAuthor release];
    [_strAuthorID release];
    [_strContent release];
    [_strPubDate release];
    [super dealloc];
}

- (id)initWithXML:(TBXMLElement *)xml
{
    if (self = [super init]) {
        TBXMLElement *commentID = [TBXML childElementNamed:@"id" parentElement:xml];
        TBXMLElement *portrait = [TBXML childElementNamed:@"portrait" parentElement:xml];
        TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:xml];
        TBXMLElement *authorid = [TBXML childElementNamed:@"authorid" parentElement:xml];
        TBXMLElement *content = [TBXML childElementNamed:@"content" parentElement:xml];
        TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:xml];
        TBXMLElement *appclient = [TBXML childElementNamed:@"appclient" parentElement:xml];
        
        self.strID = [TBXML textForElement:commentID];
        self.strPortrait = [TBXML textForElement:portrait];
        self.strAuthor = [TBXML textForElement:author];
        self.strAuthorID = [TBXML textForElement:authorid];
        self.strContent = [TBXML textForElement:content];
        self.strPubDate = [TBXML textForElement:pubDate];
        self.nAppclient = [[TBXML textForElement:appclient] intValue];
    }
    return self;
}

@end
