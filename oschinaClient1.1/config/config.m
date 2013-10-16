//
//  config.m
//  oschinaClient
//
//  Created by boai on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "config.h"
#import "AESCrypt.h"
@implementation config
static config *instance = nil;
+ (config *)instance
{
    @synchronized(self)
    {
        if (nil == instance) {
            [self new];
        }
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

- (void)saveCookie:(bool)_isLogin
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"cookie"];
    [setting setObject:_isLogin ? @"1":@"0" forKey:@"cookie"];
    [setting synchronize];
}

- (bool)isCookie
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString *value = [setting objectForKey:@"cookie"];
    if (value && [value isEqualToString:@"1"]) {
        return true;
    }
    return false;
}


- (NSString *)getUserName
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    NSString *temp = [setting objectForKey:@"UseName"];
    return temp;
}

- (NSString *)getUserPwd
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString * temp = [settings objectForKey:@"Password"];
    return [AESCrypt decrypt:temp password:@"pwd"];
}

- (void)saveLoginInfo:(NSString *)strUser pwd:(NSString *)strPwd
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"UserName"];
    [settings removeObjectForKey:@"Password"];
    [settings setObject:strUser forKey:@"UserName"];
    strPwd = [AESCrypt encrypt:strPwd password:@"pwd"];
    [settings setObject:strPwd forKey:@"Password"];
    [settings synchronize];
}

-(void)saveUID:(int)uid
{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting removeObjectForKey:@"UID"];
    [setting setObject:[NSString stringWithFormat:@"%d", uid] forKey:@"UID"];
    [setting synchronize];
}

-(int)getUID
{
    NSUserDefaults * setting = [NSUserDefaults standardUserDefaults];
    NSString *value = [setting objectForKey:@"UID"];
    if (value && [value isEqualToString:@""] == NO)
    {
        return [value intValue];
    }
    else
    {
        return 0;
    }
}

@end
