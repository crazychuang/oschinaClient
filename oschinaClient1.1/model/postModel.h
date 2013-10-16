//
//  postModel.h
//  oschinaClient
//
//  Created by boai on 13-7-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface postModel : NSObject
{
    NSString *_strID;
    NSString *_strPortrait;
    NSString *_strAuthor;
    NSString *_strAuthorID;
    NSString *_strTitle;
    int _nAnswerCount;
    int _nViewCount;
    NSString *_strPubDate;
}
@property (copy, nonatomic) NSString *strID;
@property (copy, nonatomic) NSString *strPortrait;
@property (copy, nonatomic) NSString *strAuthor;
@property (copy, nonatomic) NSString *strAuthorID;
@property (copy, nonatomic) NSString *strTitle;
@property (assign, nonatomic) int nAnswerCount;
@property (assign, nonatomic) int nViewCount;
@property (copy, nonatomic) NSString *strPubDate;

- (id)initWithXML:(TBXMLElement *)xml;
@end
