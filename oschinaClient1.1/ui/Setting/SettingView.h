//
//  SettingView.h
//  oschinaClient
//
//  Created by chuang on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : superNavPage<
           UITableViewDataSource,
           UITableViewDelegate,
           UIAlertViewDelegate>
{
    NSArray *_settings;
    NSMutableDictionary *_settingInSection;
    UITableView *_tableSetting;
}
@property (retain, nonatomic) NSArray *setting;
@property (retain, nonatomic) NSMutableDictionary *settingInSection;
@property (retain, nonatomic) UITableView *tableSetting;

- (void)refresh;
- (void)checkVersionNeedUpdate;
@end
