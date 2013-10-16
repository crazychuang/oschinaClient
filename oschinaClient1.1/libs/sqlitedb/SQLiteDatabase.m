//
//  SQLiteDatabase.m
//  SQLiteDatabase
//
//  Created by crazychuang on 13-1-10.
//  Copyright (c) 2013年 __com.chuang__. All rights reserved.
//

#import "SQLiteDatabase.h"

@implementation SQLiteDatabase

+(id)databaseWithPath:(NSString *)aPath
{
    return [[self alloc] initWithPath:aPath];
}

- (id) initWithPath: (NSString *)aPath
{
    self = [super init];
    if (self) {
        _databasePath = [aPath copy];
    }
    return self;
}

-(BOOL)open
{
    int err = sqlite3_open([_databasePath fileSystemRepresentation], &_db);
    if (err != SQLITE_OK) {
        return NO;
    }
    return YES;
}

-(BOOL)createTable:(NSString *)sql
{
    int rc;
    rc = sqlite3_exec(_db, [sql UTF8String], NULL,NULL, NULL);
    if (rc == SQLITE_OK) {
        return true;
    }
    return false;
}


-(BOOL)executeSql:(NSString *)sql
{
    int rc;
    rc = sqlite3_exec(_db, [sql UTF8String], NULL, NULL, NULL);
    if (rc == SQLITE_OK) {
        return true;
    }
    return false;
}

-(BOOL)executeUpdate:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    
    BOOL result = [self executeUpdate:sql withArgumentsInArray: nil orVAList: args];
    va_end(args);
    return result;
}

- (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    return [self executeUpdate:sql withArgumentsInArray:arguments orVAList:nil];
}

- (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray*)arrayArgs orVAList:(va_list)args {
    sqlite3_stmt *pStmt = NULL;
    int rc;
    bool retry = false;
    do{
        retry = false;
         rc = sqlite3_prepare_v2(_db, [sql UTF8String], -1, &pStmt, 0);
        if (rc == SQLITE_BUSY) {
            retry = true;
            usleep(20);
        }else if(rc != SQLITE_OK)
        {
            sqlite3_finalize(pStmt);
            return NO;
        }
    }while (retry);
    
    id obj;
    int idx = 0;
    int queryCount = sqlite3_bind_parameter_count(pStmt);
    while (idx < queryCount) {
        if (arrayArgs) {
            obj = [arrayArgs objectAtIndex:idx];
        }else {
            obj = va_arg(args, id);
        }
        idx ++;
        [self bindObject:obj toColumn:idx inStatement:pStmt];
    }
    if (idx != queryCount) {
        sqlite3_finalize(pStmt);
        return NO;
    }
    rc = sqlite3_step(pStmt);
    sqlite3_finalize(pStmt);
    return (rc == SQLITE_DONE);
        
}

-(id)executeQuery:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    
    id result = [self executeQuery:sql withArgumentsInArray:nil orVAList:args];
    
    va_end(args);
    return result;
}

-(id)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    return [self executeQuery:sql withArgumentsInArray:arguments orVAList:nil];
}

-(id) executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arrayArgs orVAList:(va_list) args
{
    sqlite3_stmt *pStmt = 0x00;
    int rc;
    bool retry = false;
    do{
        retry = false;
        rc = sqlite3_prepare_v2(_db, [sql UTF8String], -1, &pStmt, 0);
        if (rc == SQLITE_BUSY) {
            retry = true;
            struct timeval delay;
            delay.tv_sec   = 0;
            delay.tv_usec = 20*1000;
            select(0, NULL, NULL, NULL, &delay);

        }else if(rc != SQLITE_OK)
        {
            sqlite3_finalize(pStmt);
            return nil;
        }
    }while (retry);
    
    id objc;
    int idx = 0;
    int queryCount = sqlite3_bind_parameter_count(pStmt);
    
    while (idx < queryCount) {
        if (arrayArgs) {
            objc = [arrayArgs objectAtIndex:idx];
        }else {
            objc = va_arg(args, id);
        }
        idx ++;
        [self bindObject:objc toColumn:idx inStatement:pStmt];
    }
    if (idx != queryCount) {
        sqlite3_finalize(pStmt);
        return nil;
    }
    SQLiteResultSet *resultSet = nil;
    if (!resultSet) {
        resultSet = [SQLiteResultSet initResultSetWithstatement:pStmt];
    }
    return resultSet;
}

-(void) bindObject: (id)obj toColumn:(int)idx inStatement:(sqlite3_stmt *)pStmt
{
    if ((!obj)) {
        sqlite3_bind_null(pStmt, idx);
        return;
    }
    if ((NSNull *)obj == [NSNull null]) {
        sqlite3_bind_null(pStmt, idx);
        return;
    }
    if ([obj isKindOfClass:[NSData class]]) {
        sqlite3_bind_blob(pStmt, idx, [obj bytes], [obj length], SQLITE_STATIC);
        return;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        if (strcmp([obj objCType], @encode(BOOL)) == 0) {
            sqlite3_bind_int(pStmt, idx, ([obj boolValue] ? 1 : 0));
            return;
        }
        if (strcmp([obj objCType], @encode(int)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longValue]);
            return;
        }
        if (strcmp([obj objCType], @encode(long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longValue]);
            return;
        }
        if (strcmp([obj objCType], @encode(long long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longLongValue]);
            return;
        }
        if (strcmp([obj objCType], @encode(float)) == 0) {
            sqlite3_bind_double(pStmt, idx, [obj floatValue]);
            return;
        }
        if (strcmp([obj objCType], @encode(double)) == 0) {
            sqlite3_bind_double(pStmt, idx, [obj doubleValue]);
            return;
        }else {
            sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
            return;
        }
    }else {
        sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
        return;
    }
}

-(void)close
{
    if (!_db) {
        return;
    }
    int rc;
    bool retry = false;
    do{
        retry = false;
        rc = sqlite3_close(_db);
        if (rc == SQLITE_BUSY) {
            retry = true;
            usleep(20);
        }else if (rc != SQLITE_OK){
        }
    }while(retry);
    _db = nil;
}

-(void)dealloc
{
    [self close];
    [_databasePath release];
    [super dealloc];
}

@end
