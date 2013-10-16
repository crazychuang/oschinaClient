//
//  loginPage.h
//  oschinaClient
//
//  Created by boai on 13-6-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface loginPage : superNavBackPage<UIWebViewDelegate>
{
    MBProgressHUD *_HUD;
    UIButton *_rightBtn;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UILabel *lbl_user;
@property (retain, nonatomic) IBOutlet UILabel *lbl_pwd;
@property (retain, nonatomic) IBOutlet UILabel *lbl_remember;


@property (retain, nonatomic) MBProgressHUD *HUD;
@property (retain, nonatomic) IBOutlet UITextField *txt_User;
@property (retain, nonatomic) IBOutlet UITextField *txt_Pwd;
@property (retain, nonatomic) IBOutlet UIWebView *web_aboutUser;
@property (retain, nonatomic) IBOutlet UISwitch *switch_remember;
@property (retain, nonatomic) IBOutlet UIView *view_txtBg;
@property (retain, nonatomic) IBOutlet UILabel *inputViewBackground;
@property (retain, nonatomic) IBOutlet UIButton *btn_next;
@property (retain, nonatomic) IBOutlet UIImageView *signBackgroundImgView;
@property (retain, nonatomic) IBOutlet UITextField *txt_register_user;
@property (retain, nonatomic) IBOutlet UITextField *txt_register_pwd;
@property (retain, nonatomic) IBOutlet UILabel *registerViewBackground;
@property (retain, nonatomic) IBOutlet UIImageView *gotoLoginBg;
@property (retain, nonatomic) IBOutlet UIView *registerView;
- (IBAction)loginBgPressed:(id)sender;
- (IBAction)register_next:(id)sender;
- (void)gotoRegister:(id)sender;
@end
