//
//  softwareCatalogModel.h
//  oschinaClient
//
//  Created by boai on 13-6-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface softwareCatalogModel : NSObject
{
    NSString *_strName;
    int      _nTag;
}
@property (nonatomic, copy) NSString *strName;
@property (assign, nonatomic) int nTag;

- (id)initWithXML:(TBXMLElement *)xml;
@end
