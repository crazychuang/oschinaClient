//
//  blogModel.h
//  oschinaClient
//
//  Created by boai on 13-7-11.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface blogModel : NSObject
{
    NSString *_strBlogID;
    NSString *_strTitle;
    NSString *_strUrl;
    NSString *_strPubDate;
    NSString *_strAuthorUID;
    NSString *_strAuthorName;
    int       _nCommentCount;
    int       _nDocumentType;
}
@property (retain, nonatomic) NSString *strBlogID;
@property (retain, nonatomic) NSString *strTitle;
@property (retain, nonatomic) NSString *strUrl;
@property (retain, nonatomic) NSString *strPubDate;
@property (retain, nonatomic) NSString *strAuthorUID;
@property (retain, nonatomic) NSString *strAuthorName;
@property (assign, nonatomic) int nCommentCount;
@property (assign, nonatomic) int nDocumentType;

- (id)initWithXML:(TBXMLElement *)xml;
@end
