//
//  userBlogsPage.h
//  oschinaClient
//
//  Created by boai on 13-7-11.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "superNavBackPage.h"
@interface userBlogsPage : superNavBackPage <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_arrblogs;
    bool _bLoading;
    bool _bLoadOver;
    NSString *_strAuthorID;
    NSString *_strUID;
    NSString *_strAuthor;
}
@property (copy, nonatomic) NSString *strAuthor;
@property (copy, nonatomic) NSString *strUID;
@property (copy, nonatomic) NSString *strAuthorID;
@property (retain, nonatomic) NSMutableArray *arrblogs;
@property (assign, nonatomic) bool bLoading;
@property (assign, nonatomic) bool bLoadOver;
@property (retain, nonatomic) IBOutlet UITableView *table_list;
@end
