//
//  softwareModel.h
//  oschinaClient
//
//  Created by boai on 13-6-27.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface softwareModel : NSObject
{
    NSString *_strName;
    NSString *_strDesc;
    NSString *_strUrl;
}

@property (copy,nonatomic)NSString *strName;
@property (copy,nonatomic)NSString *strDesc;
@property (copy,nonatomic)NSString *strUrl;

- (id)initWith:(TBXMLElement *)xml;
@end
