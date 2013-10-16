//
//  oschinaTool.h
//  oschinaClient
//
//  Created by boai on 13-6-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "NdUncaughtExceptionHandler.h"
#import "UserModel.h"
#import "MBProgressHUD.h"
#import "userActivePage.h"
#import "userBlogsPage.h"
#import "blogModel.h"
#import <QuartzCore/QuartzCore.h>
#import "SQLiteDatabase.h"
#import "SQLiteResultSet.h"
#import "UIViewController+KNSemiModal.h"
@interface oschinaTool : NSObject
+ (oschinaTool *)sharedInstance;

+ (NSString *)NSStringSrc:(NSString *)strSrc removeThe:(NSString *)str;


+ (void)getPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(NSURLRequest *request, id responseObject)) success
        failure:(void (^)(NSURLRequest *request, NSError *error))failure;


+ (void)showMsgWithTitle:(NSString *)strTitle
                     Msg:(NSString *)strMsg
                delegate:(id)delegate
               cancelBtn:(NSString *)strCancelTitle
                otherBtn:(NSString *)strOtherBtn;



+ (void)showMsgWithTitle:(NSString *)strTitle
                     Msg:(NSString *)strMsg
                delegate:(id)delegate
               cancelBtn:(NSString *)strCancelTitle
                otherBtn:(NSString *)strOtherBtn tag:(int)nTag;

+ (void)showActionWithTitle:(NSString *)_strTitle
                   delegate:(id)_delegate
             cancelBtnTitle:(NSString *)_strBtnTitle
         destruciveBtnTitle:(NSString *)_strDestTitle
              otherBtnTitle:(NSString *)_strOtherTitle,...;

+ (void)showLoadingToast:(MBProgressHUD *)HUD ToastTxt:(NSString *)txt dimBackground:(bool)dimBackground;




+ (void)showToast:(NSString *)txt onView:(UIView *)view dimBackground:(bool)dimBackground;



+ (void)HideToast:(MBProgressHUD *)HUD;


+ (NSString *)getAppVersion;



+ (int)getAppVersion:(NSString *)strVersion;



+ (void)checkVersionNeedUpdate:(NSString *)strUrl
                       success:(void (^)(bool bNeedUpdate,NSString *strLastestV))success
                       failure:(void (^)(NSString *strMsg)) failure;



+ (NSString *)getXibName:(NSString *)strXibName;




+ (void)clearWebViewBackgrount:(UIWebView *)webView;




+ (void)loginWithUser:(NSString *)strUser
                  Pwd:(NSString *)strPwd
            keepLogin:(NSString *)strKeepLogin
              success:(void (^)(bool bLogin,NSString *LoginMsg,UserModel *user))success
              failure:(void (^)(NSString *failureMsg))failure;




+ (void)searchList:(NSString *)strContent
           catalog:(NSString *)strCatalog
         pageIndex:(int)nPageIndex
          pageSize:(int)nPageSize
           success:(void (^)(bool b,NSMutableArray *list)) success
           failure:(void (^)(NSString *errMsg))failure;




+ (void)getSoftwareCatalogs:(int)nTag success:(void (^)(bool b,NSMutableArray *list)) success failure:(void (^)(NSString *errMsg))failure;




+ (UIColor *)getBackgroundColor;




+ (UITableViewCell *)getLoadMoreCell:(UITableView *)tableView
                            loadOver:(bool)_bLoadOver
                      loadOverString:(NSString *)_strLoadOver
                             loading:(bool)_bLoading
                       loadingString:(NSString *)_strLoading;




+ (void)getSoftwareList:(NSString *)strSearchTag
                    tag:(int)nTag
              pageIndex:(int)nPageIndex
               pageSize:(int)nPageSize
                success:(void(^)(bool b,NSMutableArray *)) success
                failure:(void(^)(NSString *errMsg))failure;



+ (void)getNoteList:(NSString *)strUrl
            catalog:(int)nCatalog
            success:(void(^)(bool b,NSMutableArray *list))success
            failure:(void(^)(NSString *errDes))failure;



+ (void)getPostList:(int)nCatalog
          pageIndex:(int)nPageIndex
           pageSize:(int)nPageSize
            success:(void(^)(bool b,NSMutableArray *list))success
            failure:(void(^)(NSString *errDes))failure;




+ (void)getTwitterList:(int)nUID
             pageIndex:(int)nPageIndex
              pageSize:(int)nPageSize
               success:(void(^)(bool b,NSMutableArray *list))success
               failure:(void(^)(NSString *errDes,NSMutableArray *list)) failure;


+ (void)pushTweetImgDetail:(NSString *)strImgUrl parent:(UIViewController *)parent;


+ (void)pushTweetUser:(int)tag title:(NSString *)strTitle nav:(UINavigationController *)navController;



+ (void)getMyBlogs:(int)authorUID
         pageIndex:(int)nPageIndex
          pageSize:(int)nPageSize
               UID:(int)uid
           success:(void (^)(bool b,NSMutableArray *list)) success
           failure:(void (^)(NSString *errDes))failure;

+ (void)roundTextView:(UITextView *)txtView;

+ (void)roundWebView:(UIWebView *)web;

+ (void)pubTweet:(int)nUID
             Msg:(NSString *)strMsg
         success:(void (^)(bool b,NSString *strErrorMsg)) success
         failure:(void (^)(NSString *strDes)) failure;

+ (void)pubTweet:(int)nUID
             Msg:(NSString *)strMsg
             img:(NSData *)img
         success:(void (^)(bool b,NSString *strErrorMsg)) success
         failure:(void (^)(NSString *strDes)) failure;

+ (UIImage*)getGrayImage:(UIImage*)sourceImage;

+ (NSString *)getAppClient:(int)appClient;

+ (void)getCommentList:(int)nCatalog
                   uid:(NSString *)strUID
             pageIndex:(int)nPageIndex
              pageSize:(int)nPageSize
               success:(void (^)(bool, NSMutableArray *)) success
               failure:(void (^)(NSString *))failure;

+ (NSString *)sandBoxPath:(NSString *)_dbName;

+ (SQLiteDatabase *)initDB:(NSString *)_nameDB;

+ (bool)createTable:(NSString *)_nameTable;

+ (bool)createTweetTable:(SQLiteDatabase *)_db nametable:(NSString *)_nameTable;

+ (UIImage *)renderImageFromView:(UIView *)theView;
@end
