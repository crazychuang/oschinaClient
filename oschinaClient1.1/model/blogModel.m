//
//  blogModel.m
//  oschinaClient
//
//  Created by boai on 13-7-11.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "blogModel.h"

@implementation blogModel
@synthesize strBlogID = _strBlogID;
@synthesize strTitle = _strTitle;
@synthesize strUrl = _strUrl;
@synthesize strPubDate = _strPubDate;
@synthesize strAuthorName = _strAuthorName;
@synthesize strAuthorUID = _strAuthorUID;
@synthesize nCommentCount = _nCommentCount;
@synthesize nDocumentType = _nDocumentType;


- (id)initWithXML:(TBXMLElement *)xml
{
    if (self = [super init]) {
        TBXMLElement *blogID = [TBXML childElementNamed:@"id" parentElement:xml];
        TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:xml];
        TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:xml];
        TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:xml];
        TBXMLElement *authoruid = [TBXML childElementNamed:@"authoruid" parentElement:xml];
        TBXMLElement *authorname = [TBXML childElementNamed:@"authorname" parentElement:xml];
        TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:xml];
        TBXMLElement *documentType = [TBXML childElementNamed:@"documentType" parentElement:xml];
        
        self.strBlogID = [TBXML textForElement:blogID];
        self.strTitle = [TBXML textForElement:title];
        self.strUrl = [TBXML textForElement:url];
        self.strPubDate = [TBXML textForElement:pubDate];
        self.strAuthorUID = [TBXML textForElement:authoruid];
        self.strAuthorName = [TBXML textForElement:authorname];
        self.nCommentCount = [[TBXML textForElement:commentCount] intValue];
        self.nDocumentType = [[TBXML textForElement:documentType] intValue];
        
        
    }
    return self;
}

- (void)dealloc
{
    [_strBlogID release];
    [_strTitle release];
    [_strUrl release];
    [_strPubDate release];
    [_strAuthorName release];
    [_strAuthorUID release];
    [super dealloc];
}
@end
