//
//  softwareTypesPage.h
//  oschinaClient
//
//  Created by boai on 13-6-26.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface softwareTypesPage : superNavBackPage<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_softTypes;
    bool _bLoading;
    bool _bLoadOver;
    int _nTag;
    NSString *_strTitle;
}
@property (copy, nonatomic) NSString *strTitle;
@property (assign, nonatomic) int nTag;
@property (assign, nonatomic) bool bLoading;
@property (assign, nonatomic) bool bLoadOver;
@property (retain, nonatomic) NSMutableArray *softTypes;
@property (retain, nonatomic) IBOutlet UITableView *table_list;
@end
