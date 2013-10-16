//
//  noteModel.m
//  oschinaClient
//
//  Created by boai on 13-6-29.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "noteModel.h"

@implementation noteModel
@synthesize strNoteID = _strNoteID;
@synthesize strTitle = _strTitle;
@synthesize strUrl = _strUrl;
@synthesize strPubDate = _strPubDate;
@synthesize strAuthorUID = _strAuthorUID;
@synthesize strAuthor = _strAuthor;
@synthesize nCoummentCount = _nCommentCount;
@synthesize strDocumentType = _strDocumentType;


- (id)initWithXML:(TBXMLElement *)xml
{
    if (self = [super init]) {
        @try {
            TBXMLElement *noteID = [TBXML childElementNamed:@"id" parentElement:xml];
            TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:xml];
            TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:xml];
            TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:xml];
            TBXMLElement *authoruid = [TBXML childElementNamed:@"authoruid" parentElement:xml];
            TBXMLElement *authorname = [TBXML childElementNamed:@"authorname" parentElement:xml];
            //TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:xml];
            //TBXMLElement *documentType = [TBXML childElementNamed:@"documentType" parentElement:xml];
            
            self.strNoteID = [TBXML textForElement:noteID];
            self.strTitle = [TBXML textForElement:title];
            self.strUrl = [TBXML textForElement:url];
            self.strPubDate = [TBXML textForElement:pubDate];
            self.strAuthorUID = [TBXML textForElement:authoruid];
            self.strAuthor = [TBXML textForElement:authorname];
            //self.nCoummentCount = [[TBXML textForElement:commentCount] intValue];
           // self.strDocumentType = [TBXML textForElement:documentType];
        }
        @catch (NSException *exception) {
            [NdUncaughtExceptionHandler TakeException:exception];
        }
        @finally {
            
        }
    }
    return self;
}

-(void)dealloc
{
    [_strNoteID release];
    [_strTitle release];
    [_strUrl release];
    [_strPubDate release];
    [_strAuthorUID release];
    [_strAuthor release];
    [_strDocumentType release];
    [super dealloc];
}
@end
