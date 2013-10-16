//
//  newsModel.m
//  oschinaClient
//
//  Created by boai on 13-6-28.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "newsModel.h"
#import "NdUncaughtExceptionHandler.h"
@implementation newsModel
@synthesize strID = _strID;
@synthesize strTitle = _strTitle;
@synthesize strAuthor = _strAuthor;
@synthesize strAuthorID = _strAuthorID;
@synthesize nCommentCount = _nCommentCount;
@synthesize strPubDate = _strPubDate;


- (id)initWithXML:(TBXMLElement *)xml
{
    if (self = [super init]) {
        @try {
            TBXMLElement *newsID = [TBXML childElementNamed:@"id" parentElement:xml];
            TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:xml];
            TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:xml];
            //TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:xml];
            //TBXMLElement *authorID = [TBXML childElementNamed:@"authorid" parentElement:xml];
           // TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:xml];
            
            self.strID = [TBXML textForElement:newsID];
            self.strTitle = [TBXML textForElement:title];
            self.nCommentCount = [[TBXML textForElement:commentCount] intValue];
           // self.strAuthor = [TBXML textForElement:author];
            //self.strAuthorID = [TBXML textForElement:authorID];
            //self.strPubDate = [TBXML textForElement:pubDate];
        
        }
        @catch (NSException *exception) {
            [NdUncaughtExceptionHandler TakeException:exception];
        }
        @finally {
            
        }
    }
    return self;
}

- (void)dealloc
{
    [_strID release];
    [_strTitle release];
    [_strAuthorID release];
    [_strPubDate release];
    [super dealloc];
}
@end
