//
//  newsModel.h
//  oschinaClient
//
//  Created by boai on 13-6-28.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface newsModel : NSObject
{
    NSString *_strID;
    NSString *_strTitle;
    int _nCommentCount;
    NSString *_strAuthor;
    NSString *_strAuthorID;
    NSString *_strPubDate;
}
@property (copy, nonatomic)NSString *strID;
@property (copy, nonatomic)NSString *strTitle;
@property (assign, nonatomic)int  nCommentCount;
@property (copy, nonatomic)NSString *strAuthor;
@property (copy, nonatomic)NSString *strAuthorID;
@property (copy, nonatomic)NSString *strPubDate;

- (id)initWithXML:(TBXMLElement *)xml;
@end
