//
//  searchResultCell.h
//  oschinaClient
//
//  Created by boai on 13-6-24.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchResultCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *lbl_id;
@property (retain, nonatomic) IBOutlet UILabel *lbl_content;
@property (retain, nonatomic) IBOutlet UILabel *lbl_author;
@property (retain, nonatomic) IBOutlet UILabel *lbl_pubDate;
@end
