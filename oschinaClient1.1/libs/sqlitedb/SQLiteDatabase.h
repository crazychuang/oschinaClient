//
//  SQLiteDatabase.h
//  SQLiteDatabase
//
//  Created by crazychuang on 13-1-10.
//  Copyright (c) 2013年 __chuang__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "SQLiteResultSet.h"
@interface SQLiteDatabase : NSObject
{
    sqlite3 *_db;                //数据库
    NSString *_databasePath;     //数据库路径
}

+ (id) databaseWithPath: (NSString *)aPath;    //创建数据库

- (BOOL)open;                                  //打开数据库

- (BOOL)createTable: (NSString *)sql;          //创建表

- (BOOL)executeSql:(NSString *)sql;

- (BOOL)executeUpdate:(NSString *)sql,...;     //执行sql语句
- (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;

- (id)executeQuery: (NSString *)sql, ...;      //执行sql语句,获取数据
- (id)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;

- (void)close;                                 //关闭数据库,释放资源
@end
