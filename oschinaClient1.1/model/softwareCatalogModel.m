//
//  softwareCatalogModel.m
//  oschinaClient
//
//  Created by boai on 13-6-25.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "softwareCatalogModel.h"
#import "NdUncaughtExceptionHandler.h"
@implementation softwareCatalogModel
@synthesize strName = _strName;
@synthesize nTag = _nTag;


- (id)initWithXML:(TBXMLElement *)xml
{
    @try {
        TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:xml];
        TBXMLElement *tag = [TBXML childElementNamed:@"tag" parentElement:xml];
        self.strName = [TBXML textForElement:name];
        self.nTag = [[TBXML textForElement:tag] intValue];
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        
    }
    return self;
}

-(void)dealloc
{
    [_strName release];
    [super dealloc];
}
@end
