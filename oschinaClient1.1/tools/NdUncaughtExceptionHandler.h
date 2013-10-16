//
//  NdUncaughtExceptionHandler.h
//  oschinaClient
//
//  Created by boai on 13-6-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NdUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler *)getHandler;
+ (void)TakeException:(NSException *)exception;
@end
