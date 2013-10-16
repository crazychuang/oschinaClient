//
//  searchResultModel.h
//  oschinaClient
//
//  Created by boai on 13-6-17.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface searchResultModel : NSObject
{
    NSString *_strObjid;
    NSString *_strType;
    NSString *_strTitle;
    NSString *_strUrl;
    NSString *_strPubDate;
    NSString *_strAuthor;
}
@property (copy, nonatomic)NSString *strObjid;
@property (copy, nonatomic)NSString *strType;
@property (copy, nonatomic)NSString *strTitle;
@property (copy, nonatomic)NSString *strUrl;
@property (copy, nonatomic)NSString *strPubDate;
@property (copy, nonatomic)NSString *strAuthor;

- (id)initWithXml:(TBXMLElement *)xml;

@end
