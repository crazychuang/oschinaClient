//
//  queAnswPage.h
//  oschinaClient
//
//  Created by boai on 13-7-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXJSliderSwitch.h"
@interface queAnswPage : superNavPage<UITableViewDataSource,UITableViewDelegate,WXJSliderSwitchDelegate>
{
    int _nTab;
    NSMutableArray *_arrPosts;
    bool _bLoadOver;
    bool _bLoading;
}
@property (retain, nonatomic) NSMutableArray *arrPosts;
@property (assign, nonatomic) bool bLoadOver;
@property (assign, nonatomic) bool bLoading;

@property (retain, nonatomic) IBOutlet UITableView *table_list;

@end
