//
//  ErrorModel.h
//  oschinaClient
//
//  Created by boai on 13-6-15.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorModel : NSObject
{
    int _nErrorCode;
    NSString *_strErrorMsg;
}
@property (nonatomic,assign) int nErrorCode;
@property (nonatomic,retain) NSString *strErrorMsg;

- (id)initWithErrorCode:(int)ErrorCode ErrorMsg:(NSString *)ErrorMsg;
@end
