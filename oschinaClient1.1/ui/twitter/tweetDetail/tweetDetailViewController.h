//
//  tweetDetailViewController.h
//  oschinaClient
//
//  Created by boai on 13-7-24.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "superNavBackPage.h"
#import "tweetModel.h"
@interface tweetDetailViewController : superNavBackPage <UIWebViewDelegate,
                                                         UITextViewDelegate,
                                                         UIActionSheetDelegate,
                                                         UITableViewDataSource,
                                                         UITableViewDelegate>
{
    tweetModel *_tweet;
    NSMutableArray *_arrComments;
    bool _bLoadOver;
    bool _bLoading;
}
@property (retain, nonatomic) NSMutableArray *arrComments;
@property (retain, nonatomic) tweetModel *tweet;
@property (retain, nonatomic) IBOutlet UIWebView *web_tweetDetail;
@property (retain, nonatomic) IBOutlet UITextView *txt_comment;
@property (retain, nonatomic) IBOutlet UITableView *table_comment_list;
- (IBAction)bgPressed:(id)sender;
@end
