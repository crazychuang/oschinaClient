//
//  leftSideViewPage.h
//  oschinaClient
//
//  Created by boai on 13-7-18.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "UIViewController+KNSemiModal.h"
@interface leftSideViewPage : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_arrBusiness;
}
@property (retain, nonatomic) NSArray *arrBusiness;
@property (retain, nonatomic) UITableView *table_list;

@end
