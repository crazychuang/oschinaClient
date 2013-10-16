//
//  loginPage.m
//  oschinaClient
//
//  Created by boai on 13-6-14.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "loginPage.h"
#import "oschinaTool.h"
#import "config.h"
@interface loginPage ()

@end

@implementation loginPage
@synthesize HUD = _HUD;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setNavTxt:@"登陆"];
    
    [_scrollview setContentSize:CGSizeMake(320, 900)];
    [_scrollview setDecelerationRate:-1];
    [self.txt_User setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14]];
    [self initTextField:_txt_User withImg:@"row_username.png"];
    
    [self.txt_Pwd setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14]];
    [self initTextField:_txt_Pwd withImg:@"row_password.png"];
    UIImage *image = [UIImage imageNamed:@"row_forgot"];
    UIButton *forgotBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [forgotBtn setImage:image forState:UIControlStateNormal];
    _txt_Pwd.rightView = forgotBtn;
    _txt_Pwd.rightViewMode = UITextFieldViewModeAlways;
    _txt_Pwd.secureTextEntry = YES;
    [_txt_register_user setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14]];
    [_txt_register_pwd setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14]];
    _txt_register_pwd.secureTextEntry = YES;
    [_btn_next.titleLabel setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:15]];
    [self initInputViewBackground:_inputViewBackground];
    
    [self.lbl_remember setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:16]];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [_HUD hide:YES];
    [self.view addSubview:_HUD];
    
    NSString *strName = [[config instance] getUserName];
    NSString *strPwd = [[config instance] getUserPwd];
    if (!strName && [strName length] >0) {
        self.txt_User.text = strName;
    }
    if (!strPwd && [strPwd length] > 0) {
        self.txt_Pwd.text = strPwd;
    }
    
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 33)];
    [_rightBtn.titleLabel setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:13]];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"head_button"] forState:UIControlStateNormal];
    [_rightBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(click_Login:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:_rightBtn] autorelease];
    
    [oschinaTool clearWebViewBackgrount:self.web_aboutUser];
    [self.web_aboutUser setDelegate:self];
    self.web_aboutUser.backgroundColor = [UIColor clearColor];
    [self.web_aboutUser loadHTMLString:HTML_ABOUT_USER baseURL:nil];
    
    [_signBackgroundImgView setImage:[self resizableImge:[UIImage imageNamed:@"row_sign_bg"]]];
    _signBackgroundImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoRegister:)];
    [_signBackgroundImgView addGestureRecognizer:tap];
    [tap release];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLogin:)];
    _gotoLoginBg.userInteractionEnabled = YES;
    [_gotoLoginBg addGestureRecognizer:tap];
    [tap release];
    
    
    
    UIImage *nextImg = [UIImage imageNamed:@"row_button"];
    nextImg = [nextImg resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [_btn_next setBackgroundImage:nextImg forState:UIControlStateNormal];
    nextImg = [UIImage imageNamed:@"row_button_active"];
    nextImg = [nextImg resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [_btn_next setBackgroundImage:nextImg forState:UIControlStateHighlighted];
    
    [self initInputViewBackground:_registerViewBackground];
    [self initTextField:_txt_register_user withImg:@"row_username.png"];
    [self initTextField:_txt_register_pwd withImg:@"row_password.png"];
    
}

- (void)gotoLogin:(id)sender
{
    [_scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    [self setNavTxt:@"登陆"];
    [_rightBtn setHidden:NO];
}

- (void)gotoRegister:(id)sender
{
    [_scrollview setContentOffset:CGPointMake(0, 510) animated:YES];
    [self setNavTxt:@"注册"];
    [_rightBtn setHidden:YES];
}

- (UIImage *)resizableImge:(UIImage *)img
{
    UIImage *signImage = nil;
    UIEdgeInsets insets = UIEdgeInsetsMake(17, 160, 0, 160);
    signImage = [img resizableImageWithCapInsets:insets];
    return signImage;
}

- (void)initTextField:(UITextField *)textField withImg:(NSString *)imgName
{
    UIImage *image = [UIImage imageNamed:imgName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [imageView release];
}

- (void)initInputViewBackground:(UILabel *)lbl
{
    CALayer *viewLayer = lbl.layer;
    [viewLayer setBorderColor:[[UIColor lightGrayColor] CGColor] ];
    [viewLayer setBorderWidth:1];
    [viewLayer setMasksToBounds:YES];
    [viewLayer setCornerRadius:5];
    
}

- (void)animateIncorrectMessage:(UIView *)view
{
    //输入信息有误，晃动文本框
    CGAffineTransform moveRight = CGAffineTransformTranslate(CGAffineTransformIdentity, 30, 0);
    CGAffineTransform moveLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -30, 0);
    CGAffineTransform resetTransform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    
    [UIView animateWithDuration:0.1 animations:^{
        view.transform = moveLeft;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            view.transform = moveRight;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                view.transform = moveLeft;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    view.transform = moveRight;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        view.transform = resetTransform;
                    }];
                }];
            }];
        }];
    }];
}

- (void)click_Login:(id)sender
{
    [self closeKeyboard];
    
    if (_txt_User.text.length >0 && _txt_Pwd.text.length > 0) {
        
    }else{
        [self animateIncorrectMessage:_view_txtBg];
        return;
    }
    
    
    if (self.txt_User.text == nil || [self.txt_User.text length] <= 0) {
        [oschinaTool showMsgWithTitle:@"提示" Msg:@"用户名为空" delegate:nil cancelBtn:@"确定" otherBtn:nil];
        return;
    }
    if (self.txt_Pwd.text == nil || [self.txt_Pwd.text length] <= 0) {
        [oschinaTool showMsgWithTitle:@"提示" Msg:@"密码为空" delegate:nil cancelBtn:@"确定" otherBtn:nil];
        return;
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [oschinaTool showLoadingToast:_HUD ToastTxt:@"正在加载,请稍候..." dimBackground:YES];
    [oschinaTool loginWithUser:self.txt_User.text
                           Pwd:self.txt_Pwd.text
                     keepLogin:@"1" success:^(bool bLogin, NSString *LoginMsg, UserModel *user) {
                         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                         [oschinaTool HideToast:_HUD];
                         if (!bLogin) {
                             [oschinaTool showMsgWithTitle:@"提示" Msg:LoginMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
                         }else{
                             self.switch_remember.isOn ? [[config instance] saveLoginInfo:self.txt_User.text pwd:self.txt_Pwd.text]:[[config instance]saveLoginInfo:@"" pwd:@""];
                             [oschinaTool showToast:@"登陆成功" onView:self.navigationController.view dimBackground:YES];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
    }
                       failure:^(NSString *failureMsg) {
                           [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                           [oschinaTool HideToast:_HUD];
                           [oschinaTool showMsgWithTitle:@"提示" Msg:failureMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_web_aboutUser stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [_web_aboutUser stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [[UIApplication sharedApplication] openURL:request.URL];
    DLog(@"%@",request.URL.absoluteString);
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return YES;
    }
    return NO;
}

- (void)closeKeyboard
{
    if ([self.txt_User isEditing]) {
        [self.txt_User resignFirstResponder];
    }
    if ([self.txt_Pwd isEditing]) {
        [self.txt_Pwd resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_txt_User release];
    [_txt_Pwd release];
    [_web_aboutUser release];
    [_switch_remember release];
    [_lbl_user release];
    [_lbl_pwd release];
    [_lbl_remember release];
    [_view_txtBg release];
    [_inputViewBackground release];
    [_signBackgroundImgView release];
    [_btn_next release];
    [_registerViewBackground release];
    [_txt_register_user release];
    [_txt_register_pwd release];
    [_scrollview release];
    [_gotoLoginBg release];
    [_registerView release];
    [super dealloc];
}
- (IBAction)loginBgPressed:(id)sender {
    [self closeKeyboard];
}

- (IBAction)register_next:(id)sender {
    if ([_txt_register_user.text length] <= 0 || [_txt_register_pwd.text length] <= 0) {
        [self animateIncorrectMessage:_registerView];
        return;
    }
}
- (void)viewDidUnload {
    [self setLbl_user:nil];
    [self setLbl_pwd:nil];
    [self setLbl_remember:nil];
    [self setView_txtBg:nil];
    [self setInputViewBackground:nil];
    [self setSignBackgroundImgView:nil];
    [self setBtn_next:nil];
    [self setRegisterViewBackground:nil];
    [self setTxt_register_user:nil];
    [self setTxt_register_pwd:nil];
    [self setScrollview:nil];
    [self setGotoLoginBg:nil];
    [self setRegisterView:nil];
    [super viewDidUnload];
}
@end
