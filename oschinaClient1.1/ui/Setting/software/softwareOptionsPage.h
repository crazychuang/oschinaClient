//
//  softwareOptionsPage.h
//  oschinaClient
//
//  Created by boai on 13-6-27.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "softwareModel.h"
#import "oschinaTool.h"
@interface softwareOptionsPage : superNavBackPage<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_softwares;
    bool _bLoading;
    bool _bLoadOver;
    NSString *_strSearchTag;
    int _nTag;
    NSString *_strTitle;
}
@property (copy, nonatomic) NSString *strTitle;
@property (assign, nonatomic) int nTag;
@property (copy, nonatomic) NSString *strSearchTag;
@property (retain, nonatomic) NSMutableArray *softwares;
@property (assign, nonatomic) bool bLoading;
@property (assign, nonatomic) bool bLoadOver;
@property (retain, nonatomic) IBOutlet UITableView *table_list;

- (void)reloadData;
@end
