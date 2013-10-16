//
//  twitterPage.h
//  oschinaClient
//
//  Created by boai on 13-7-8.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweetCell.h"
#import "tweetModel.h"
#import "TweetImgDetail.h"
#import "UITap.h"
#import "EGORefreshTableHeaderView.h"
#import "WXJSliderSwitch.h"
#import "UIViewController+KNSemiModal.h"
@interface twitterPage : superNavPage<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,WXJSliderSwitchDelegate>
{
    int _nTab;
    
    NSMutableArray *_arrTwitters;
    bool _bLoadOver;
    bool _bLoading;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    bool _breloading;
}

@property (assign, nonatomic) bool breloading;
@property (retain, nonatomic) NSMutableArray *arrTwitters;
@property (assign, nonatomic) bool bLoadOver;
@property (assign, nonatomic) bool bLoading;
@property (retain, nonatomic) IBOutlet UITableView *table_list;


- (void)reloadTableViewDataSrc;
- (void)doneLoadingTableViewData;
@end
