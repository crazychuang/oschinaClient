//
//  writeTweetPage.m
//  oschinaClient
//
//  Created by boai on 13-7-13.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "writeTweetPage.h"
#import "config.h"
@interface writeTweetPage ()
@end

@implementation writeTweetPage
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
    [oschinaTool roundTextView:_txt_TweetContent];
    [self.lbl_des3 setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14]];
    [self.lbl_des2 setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14]];
    [self.lbl_des1 setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14]];
    [self.lbl_desTitle setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:20]];
    [self.txt_TweetContent setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:18]];
    self.txt_TweetContent.autocorrectionType = UITextAutocorrectionTypeNo;
    _txt_TweetContent.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self setNavTxt:@"动弹一下"];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [_HUD hide:YES];
    [self.view addSubview:_HUD];
    
    UIBarButtonItem *pubTweet = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    pubTweet.title = @"动弹一下";
    [pubTweet setAction:@selector(pubTweet:)];
    self.navigationItem.rightBarButtonItem = pubTweet;
    
    self.btn_AddImgs.titleLabel.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:16];
}


- (void)pubTweet:(id)sender
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [oschinaTool showLoadingToast:_HUD ToastTxt:@"正在加载,请稍候..." dimBackground:YES];
    __block __typeof__(self) blockSelf = self;
        [oschinaTool pubTweet:[[config instance] getUID]
                          Msg:blockSelf.txt_TweetContent.text
                          img:UIImageJPEGRepresentation(blockSelf.imgView_TweetImg.image, 0.7f)
                      success:^(bool b, NSString *strErrorMsg) {
                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                          [oschinaTool HideToast:_HUD];
                          if (b) {
                              [oschinaTool showToast:@"动弹一下下，你成功啦" onView:blockSelf.navigationController.view dimBackground:YES];
                              [self.navigationController popViewControllerAnimated:YES];
                          }else{
                              [oschinaTool showMsgWithTitle:@"提示" Msg:strErrorMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
                          }
                      }
                      failure:^(NSString *strDes) {
                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                          [oschinaTool HideToast:_HUD];
                          [oschinaTool showMsgWithTitle:@"提示" Msg:strDes delegate:nil cancelBtn:@"确定" otherBtn:nil];
                      }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
   
    [_imgView_TweetImg release];
    [_txt_TweetContent release];
    [_lbl_des3 release];
    [_lbl_des2 release];
    [_lbl_des1 release];
    [_lbl_desTitle release];
    [_btn_AddImgs release];
    [super dealloc];
}
- (void)viewDidUnload {
    
    [self setImgView_TweetImg:nil];
    [self setTxt_TweetContent:nil];
    [self setLbl_des3:nil];
    [self setLbl_des2:nil];
    [self setLbl_des1:nil];
    [self setLbl_desTitle:nil];
    [self setBtn_AddImgs:nil];
    [super viewDidUnload];
}
- (IBAction)pubTheTweet:(id)sender {
    [self closekeyBoard];
}

- (void)closekeyBoard
{
    if ([self.txt_TweetContent isEditable]) {
        [self.txt_TweetContent resignFirstResponder];
    }
}

- (IBAction)bgPressed:(id)sender {
    [self closekeyBoard];
    
    NSString *strTweet = self.txt_TweetContent.text;
    if ([strTweet isEqualToString:@""]) {
        
    }
}

- (IBAction)addTweetImgs:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"返回" otherButtonTitles:@"图库",@"拍照",nil];
    [sheet showInView:self.view];
    [sheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"cancel this action");
        }
            break;
        case 1:
        {
            [self localPhoto];
        }
            break;
        case 2:
        {
            [self takePhoto];
        }
            break;
        default:
            break;
    }
}

- (void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
        [picker release];
    }else{
        NSLog(@"该设备无摄像头");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imgView_TweetImg.image = image;
    [picker dismissModalViewControllerAnimated:YES];
}

@end
