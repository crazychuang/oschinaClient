//
//  SearchPage.h
//  oschinaClient
//
//  Created by boai on 13-6-17.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchResultCell.h"
#import "moreResultsCell.h"
#import "WXJSliderSwitch.h"
@interface SearchPage : superNavBackPage <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,WXJSliderSwitchDelegate>
{
    int _nTab;
    NSMutableArray *_results;
    bool _bLoadOver;
    bool _bLoading;
}
@property (retain, nonatomic) NSMutableArray *results;
@property (assign, nonatomic) bool bLoadOver;
@property (assign, nonatomic) bool bLoading;

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet UITableView *tableResult;
@end
