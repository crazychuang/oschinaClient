//
//  myInfoPage.h
//  oschinaClient
//
//  Created by boai on 13-7-16.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface myInfoPage : superNavBackPage<UITableViewDataSource,UITableViewDelegate>
{
    UserModel *_user;
}
@property (copy, nonatomic) UserModel *user;
@property (retain, nonatomic) IBOutlet UITableView *table_list;
@end
