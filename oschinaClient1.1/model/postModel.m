//
//  postModel.m
//  oschinaClient
//
//  Created by boai on 13-7-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "postModel.h"

@implementation postModel
@synthesize strID = _strID;
@synthesize strPortrait = _strPortrait;
@synthesize strAuthor = _strAuthor;
@synthesize strAuthorID = _strAuthorID;
@synthesize strTitle = _strTitle;
@synthesize nAnswerCount = _nAnswerCount;
@synthesize nViewCount = _nViewCount;
@synthesize strPubDate = _strPubDate;


- (id)initWithXML:(TBXMLElement *)xml
{
    if (self = [super init]) {
        TBXMLElement *postID = [TBXML childElementNamed:@"id" parentElement:xml];
        TBXMLElement *portrait = [TBXML childElementNamed:@"portrait" parentElement:xml];
        TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:xml];
        TBXMLElement *authorid = [TBXML childElementNamed:@"authorid" parentElement:xml];
        TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:xml];
        TBXMLElement *answerCount = [TBXML childElementNamed:@"answerCount" parentElement:xml];
        TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:xml];
        
        self.strID = [TBXML textForElement:postID];
        self.strPortrait = [TBXML textForElement:portrait];
        self.strAuthor = [TBXML textForElement:author];
        self.strAuthorID = [TBXML textForElement:authorid];
        self.strTitle = [TBXML textForElement:title];
        self.nAnswerCount = [[TBXML textForElement:answerCount] intValue];
        self.strPubDate = [TBXML textForElement:pubDate];
    }
    return self;
}

- (void)dealloc
{
    [_strID release];
    [_strPortrait release];
    [_strAuthor release];
    [_strAuthorID release];
    [_strTitle release];
    [_strPubDate release];
    [super dealloc];
}
@end
