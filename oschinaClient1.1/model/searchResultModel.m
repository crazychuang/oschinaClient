//
//  searchResultModel.m
//  oschinaClient
//
//  Created by boai on 13-6-17.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "searchResultModel.h"

@implementation searchResultModel
@synthesize strObjid = _strObjid;
@synthesize strType = _strType;
@synthesize strTitle = _strTitle;
@synthesize strUrl = _strUrl;
@synthesize strPubDate = _strPubDate;
@synthesize strAuthor = _strAuthor;


- (id)initWithXml:(TBXMLElement *)xml
{
    if (self = [super init]) {
        TBXMLElement *objid = [TBXML childElementNamed:@"objid" parentElement:xml];
        TBXMLElement *type = [TBXML childElementNamed:@"type" parentElement:xml];
        TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:xml];
        TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:xml];
        TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:xml];
        TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:xml];
        self.strObjid = [TBXML textForElement:objid];
        self.strType  = [TBXML textForElement:type];
        self.strTitle = [TBXML textForElement:title];
        self.strUrl   = [TBXML textForElement:url];
        self.strPubDate = [TBXML textForElement:pubDate];
        self.strAuthor = [TBXML textForElement:author];
    }
    return self;
}

- (void)dealloc
{
    [_strObjid release];
    [_strType release];
    [_strTitle release];
    [_strUrl release];
    [_strPubDate release];
    [_strAuthor release];
    [super dealloc];
}

@end
