//
//  noteModel.h
//  oschinaClient
//
//  Created by boai on 13-6-29.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "NdUncaughtExceptionHandler.h"
@interface noteModel : NSObject
{
    NSString *_strNoteID;
    NSString *_strTitle;
    NSString *_strUrl;
    NSString *_strPubDate;
    NSString *_strAuthorUID;
    NSString *_strAuthor;
    int    _nCommentCount;
    NSString *_strDocumentType;
}

@property (copy, nonatomic) NSString *strNoteID;
@property (copy, nonatomic) NSString *strTitle;
@property (copy, nonatomic) NSString *strUrl;
@property (copy, nonatomic) NSString *strPubDate;
@property (copy, nonatomic) NSString *strAuthorUID;
@property (copy, nonatomic) NSString *strAuthor;
@property (assign, nonatomic) int nCoummentCount;
@property (copy, nonatomic) NSString *strDocumentType;


- (id)initWithXML:(TBXMLElement *)xml;
@end
