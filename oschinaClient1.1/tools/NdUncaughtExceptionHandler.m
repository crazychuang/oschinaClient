//
//  NdUncaughtExceptionHandler.m
//  oschinaClient
//
//  Created by boai on 13-6-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "NdUncaughtExceptionHandler.h"
NSString *applicationDocumentsDirectory()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
void UncaughtExceptionHandler(NSException *exception)
{
    
}
@implementation NdUncaughtExceptionHandler
+(void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler *)getHandler
{
    return NSGetUncaughtExceptionHandler();
}

+ (void)TakeException:(NSException *)exception
{
    NSArray *arr = [exception callStackSymbols];
    NSString *strReason = [exception reason];
    NSString *strName = [exception name];
    NSString *url = [NSString stringWithFormat:@"=========异常报告============\nname:%@\nreason:%@\ncallStackSymbols:\n%@",strName,strReason,[arr componentsJoinedByString:@"\n"]];
    NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:NAME_FILE_EXCEPTION];
    [url writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
