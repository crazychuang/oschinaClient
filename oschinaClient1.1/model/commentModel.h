//
//  commentModel.h
//  oschinaClient
//
//  Created by boai on 13-7-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface commentModel : NSObject
{
    NSString *_strID;
    NSString *_strPortrait;
    NSString *_strAuthor;
    NSString *_strAuthorID;
    NSString *_strContent;
    NSString *_strPubDate;
    int      _nAppclient;
}
@property (copy, nonatomic) NSString *strID;
@property (copy, nonatomic) NSString *strPortrait;
@property (copy, nonatomic) NSString *strAuthor;
@property (copy, nonatomic) NSString *strAuthorID;
@property (copy, nonatomic) NSString *strContent;
@property (copy, nonatomic) NSString *strPubDate;
@property (assign, nonatomic) int nAppclient;

- (id)initWithXML:(TBXMLElement *)xml;
@end
