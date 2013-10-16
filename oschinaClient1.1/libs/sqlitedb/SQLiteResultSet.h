//
//  SQLiteResultSet.h
//  SQLiteDatabase
//
//  Created by crazychuang on 13-1-10.
//  Copyright (c) 2013年 __chuang__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface SQLiteResultSet : NSObject
{
    sqlite3_stmt *statement;
    NSMutableDictionary *columNameToIndexMap;          //sql查询结构字段名称
}
+ (id)initResultSetWithstatement:(sqlite3_stmt *)stmt;
- (void)setStateMent:(sqlite3_stmt *)stmt;
- (void)setupColumnNames;
- (BOOL)next;

- (int)intForColumn:(NSString *)columnName;            //根据字段名获取整形数据
- (int)intForColumnIndex:(int) columIdx;               //根据字段序号获取整形数据

- (BOOL)boolForColumn:(NSString *)columnName;          //根据字段名获取布尔型数据
- (BOOL)boolForColumnIndex:(int)columnIdx;             //根据字段序号获取布尔型数据

- (NSString *)stringForColumn:(NSString *)columnName;  //根据字段名获取字符串数据
- (NSString *)stringForColumnIndex:(int)columnIdx;     //根据字段序号获取字符串数据


- (void)close;                                         //释放资源
@end
