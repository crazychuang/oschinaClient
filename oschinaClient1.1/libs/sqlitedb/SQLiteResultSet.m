//
//  SQLiteResultSet.m
//  SQLiteDatabase
//
//  Created by crazychuang on 13-1-10.
//  Copyright (c) 2013年 __chuang__. All rights reserved.
//

#import "SQLiteResultSet.h"

@implementation SQLiteResultSet

+(id)initResultSetWithstatement:(sqlite3_stmt *)stmt
{
    SQLiteResultSet *rs = [[[SQLiteResultSet alloc] init] autorelease];
    [rs setStateMent:stmt];
    [rs setupColumnNames];
    
    return rs;
}

-(void)setStateMent:(sqlite3_stmt *)stmt
{
    statement = stmt;
}

-(void)setCoulumnNameToIndexMap:(NSMutableDictionary *)value
{
    [columNameToIndexMap release];
    columNameToIndexMap = value;
    [value retain];
}

-(void)setupColumnNames
{
    if (!columNameToIndexMap) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:25];
        [self setCoulumnNameToIndexMap:tempDic];
        [tempDic release];
    }
    
    int columnCount = sqlite3_column_count(statement);
    int columnIdx = 0;
    for (columnIdx = 0; columnIdx < columnCount; columnIdx ++) {
        const char *c = sqlite3_column_name(statement, columnIdx);
        NSString *column_name = [[NSString stringWithUTF8String: c] lowercaseString];
        [columNameToIndexMap setObject:[NSNumber numberWithInt:columnIdx] forKey:column_name];
    }
}

-(BOOL)next
{
    int rc;
    rc = sqlite3_step(statement);
    return (rc == SQLITE_ROW);
}

-(int)columnIndexForName:(NSString *)columnName
{
    columnName = [columnName lowercaseString];
    NSNumber *n = [columNameToIndexMap objectForKey:columnName];
    if (n) {
        return [n intValue];
    }
    return -1;
}

-(int)intForColumn:(NSString *)columnName
{
    return [self intForColumnIndex:[self columnIndexForName:columnName]];
}

-(int)intForColumnIndex:(int)columIdx
{
    return sqlite3_column_int(statement, columIdx);
}

- (BOOL)boolForColumn:(NSString *)columnName
{
    return [self boolForColumnIndex:[self columnIndexForName:columnName ]];
}

-(BOOL)boolForColumnIndex:(int)columnIdx
{
    return ([self intForColumnIndex:columnIdx] != 0);
}

- (NSString *)stringForColumn:(NSString *)columnName
{
    return [self stringForColumnIndex:[self columnIndexForName:columnName]];
}

- (NSString *)stringForColumnIndex:(int)columnIdx
{
    if (sqlite3_column_type(statement, columnIdx) == SQLITE_NULL || (columnIdx < 0)) {
        return nil;
    }
    const char *c = (const char *)sqlite3_column_text(statement, columnIdx);
    if (!c) {
        return nil;
    }
    return [NSString stringWithUTF8String:c];
}

-(void)close
{
    if (statement) {
        sqlite3_finalize(statement);
        statement = nil;
    }
}

-(void)dealloc
{
    [self close];
    [columNameToIndexMap release];
    columNameToIndexMap = nil;
    [super dealloc];
}


@end
