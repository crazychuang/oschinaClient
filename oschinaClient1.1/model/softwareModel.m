//
//  softwareModel.m
//  oschinaClient
//
//  Created by boai on 13-6-27.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "softwareModel.h"
#import "NdUncaughtExceptionHandler.h"
@implementation softwareModel
@synthesize strName = _strName;
@synthesize strDesc = _strDesc;
@synthesize strUrl = _strUrl;


- (id)initWith:(TBXMLElement *)xml
{
    if (self = [super init]) {
        @try {
            TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:xml];
            TBXMLElement *description = [TBXML childElementNamed:@"description" parentElement:xml];
            TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:xml];
            self.strName = [TBXML textForElement:name];
            self.strDesc = [TBXML textForElement:description];
            self.strUrl = [TBXML textForElement:url];
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
    [_strName release];
    [_strDesc release];
    [_strUrl release];
    [super dealloc];
}
@end
