//
//  config.h
//  oschinaClient
//
//  Created by boai on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface config : NSObject

+ (config *)instance;
+ (id)allocWithZone:(NSZone *)zone;

- (void)saveCookie:(bool)_isLogin;
- (bool)isCookie;

- (void)saveLoginInfo:(NSString *)strUser pwd:(NSString *)strPwd;

- (NSString *)getUserName;
- (NSString *)getUserPwd;

-(void)saveUID:(int)uid;
-(int)getUID;
@end
