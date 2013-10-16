//
//  complexPage.h
//  oschinaClient
//
//  Created by boai on 13-6-28.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXJSliderSwitch.h"
@interface complexPage : superNavPage<UITableViewDataSource,UITableViewDelegate,WXJSliderSwitchDelegate>
{
    int _nTab;
    NSMutableArray *_dataList;
    bool _bLoadOver;
    bool _bLoading;
}
@property (retain, nonatomic) NSMutableArray *dataList;
@property (assign, nonatomic) bool bLoadOver;
@property (assign, nonatomic) bool bLoading;
@property (retain, nonatomic) IBOutlet UITableView *table_list;

@end
