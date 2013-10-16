//
//  ErrorModel.m
//  oschinaClient
//
//  Created by boai on 13-6-15.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "ErrorModel.h"

@implementation ErrorModel
@synthesize nErrorCode = _nErrorCode;
@synthesize strErrorMsg = _strErrorMsg;

- (id)initWithErrorCode:(int)ErrorCode ErrorMsg:(NSString *)ErrorMsg
{
    if (self = [super init]) {
        self.nErrorCode = ErrorCode;
        self.strErrorMsg = ErrorMsg;
    }
    return self;
}

- (void)dealloc
{
    [_strErrorMsg release];
    [super dealloc];
}

@end
