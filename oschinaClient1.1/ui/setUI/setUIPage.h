//
//  setUIPage.h
//  oschinaClient
//
//  Created by boai on 13-8-9.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXJChangeBgView.h"
#import "UIViewController+KNSemiModal.h"
@interface setUIPage : superPage <UITableViewDataSource,UITableViewDelegate,WXJChangeBgViewDelegate>
{
    NSArray *_arr;
}

- (IBAction)closeThePage:(id)sender;
@property (retain, nonatomic) IBOutlet UITableView *table_list;
@property (retain, nonatomic) IBOutlet UISwitch *modelSwitch;
@property (retain, nonatomic) IBOutlet UIImageView *img_nav;
- (IBAction)change:(id)sender;

@end
