//
//  tweetCell.h
//  oschinaClient
//
//  Created by boai on 13-7-9.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweetModel.h"
#import "UITap.h"
@interface tweetCell : UITableViewCell
{
    bool _bTweetImg;
}
@property (assign, nonatomic) bool bTweetImg;
@property (retain, nonatomic) IBOutlet UILabel *lbl_author;
@property (retain, nonatomic) IBOutlet UILabel *lbl_content;
@property (retain, nonatomic) IBOutlet UIImageView *imgView_tweetImg;
@property (retain, nonatomic) IBOutlet UILabel *lbl_time;
@property (retain, nonatomic) IBOutlet UIImageView *imgView_head;
@property (retain, nonatomic) IBOutlet UIImageView *imgView_MsgCount;
@property (retain, nonatomic) IBOutlet UILabel *lbl_MsgCount;

+ (CGFloat) resizeTheCellHeight:(tweetModel *)model;
- (void)initTheTweetCell:(tweetModel *)model;
- (void)addTweetTap:(tweetCell **)cell action:(SEL)action target:(id)target tweetModel:(tweetModel *)model;
- (void)addHeadTap:(UIImageView *)headImg action:(SEL)action target:(id)target tweetModel:(tweetModel *)model;
@end
