//
//  writeTweetPage.h
//  oschinaClient
//
//  Created by boai on 13-7-13.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface writeTweetPage : superNavBackPage <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD *_HUD;
}
@property (retain, nonatomic) MBProgressHUD *HUD;
@property (retain, nonatomic) IBOutlet UILabel *lbl_des3;
@property (retain, nonatomic) IBOutlet UILabel *lbl_des2;
@property (retain, nonatomic) IBOutlet UILabel *lbl_des1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_desTitle;
@property (retain, nonatomic) IBOutlet UIButton *btn_AddImgs;

@property (retain, nonatomic) IBOutlet UITextView *txt_TweetContent;
@property (retain, nonatomic) IBOutlet UIImageView *imgView_TweetImg;
- (IBAction)pubTheTweet:(id)sender;
- (IBAction)bgPressed:(id)sender;
- (IBAction)addTweetImgs:(id)sender;
@end
