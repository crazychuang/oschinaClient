//
//  oschinaTool.m
//  oschinaClient
//
//  Created by boai on 13-6-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "oschinaTool.h"
#import "ErrorModel.h"
#import "config.h"
#import "UserModel.h"
#import "searchResultModel.h"
#import "moreResultsCell.h"
#import "softwareCatalogModel.h"
#import "softwareModel.h"
#import "newsModel.h"
#import "noteModel.h"
#import "postModel.h"
#import "tweetModel.h"
#import "TweetImgDetail.h"
#import "ASIFormDataRequest.h"
#import "commentModel.h"

#define TAG_ALERT_BASE     0

@implementation oschinaTool
static oschinaTool *sharedInstance = nil;
+ (oschinaTool *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [[oschinaTool alloc] init];
        }
    }
    return sharedInstance;
}

 + (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(NSURLRequest *, id))success
        failure:(void (^)(NSURLRequest *, NSError *))failure
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
    [request setHTTPMethod:@"GET"];
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        success(request,response);
        return;
    }
    failure(request,error);
}

+ (NSString *)NSStringSrc:(NSString *)strSrc removeThe:(NSString *)str
{
    return [strSrc stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (bool)requestWebWithUrl:(NSURL *)url RetRespone:(NSData **)respone
{
    bool bRet = false;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    request.timeoutInterval = nTimeoutInterval;
    NSError *error = nil;
    *respone = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        DLog(@"respone:%@",*respone);
        bRet = true;
    }
    return bRet;
}


+ (void)showMsgWithTitle:(NSString *)strTitle Msg:(NSString *)strMsg delegate:(id)delegate cancelBtn:(NSString *)strCancelTitle otherBtn:(NSString *)strOtherBtn
{
    [self showMsgWithTitle:strTitle Msg:strMsg delegate:delegate cancelBtn:strCancelTitle otherBtn:strOtherBtn tag:TAG_ALERT_BASE];
}

+ (void)showMsgWithTitle:(NSString *)strTitle Msg:(NSString *)strMsg delegate:(id)delegate cancelBtn:(NSString *)strCancelTitle otherBtn:(NSString *)strOtherBtn tag:(int)nTag
{
    UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:delegate cancelButtonTitle:strCancelTitle otherButtonTitles:strOtherBtn, nil];
    _alert.tag = nTag;
    [_alert show];
    [_alert release]; _alert = nil;
}

+ (void)showActionWithTitle:(NSString *)_strTitle
                   delegate:(id)_delegate
             cancelBtnTitle:(NSString *)_strBtnTitle
         destruciveBtnTitle:(NSString *)_strDestTitle
              otherBtnTitle:(NSString *)_strOtherTitle, ...
{
    
}

+ (void)showLoadingToast:(MBProgressHUD *)HUD ToastTxt:(NSString *)txt dimBackground:(bool)dimBackground
{
    HUD.dimBackground = dimBackground;
    HUD.labelText = txt;
    [HUD show:YES];
}

+ (void)HideToast:(MBProgressHUD *)HUD
{
    if (HUD) {
        [HUD hide:YES];
    }
}

+ (void)showToast:(NSString *)txt onView:(UIView *)view dimBackground:(bool)dimBackground
{
    
    __block MBProgressHUD *_HUD = [[MBProgressHUD alloc]init];
    _HUD.dimBackground = dimBackground;
    _HUD.labelText = txt;
    _HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    _HUD.mode = MBProgressHUDModeCustomView;
    [_HUD show:YES];
    [view addSubview:_HUD];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_HUD hide:YES];
            [_HUD removeFromSuperview];
            [_HUD release];_HUD = nil;
        });
    });
}

+ (NSString *)getAppVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
}

+ (int)getAppVersion:(NSString *)strVersion
{
    NSArray *arr = [strVersion componentsSeparatedByString:@"."];
    if ([arr count] >= 3) {
        NSString *a = [arr objectAtIndex:0];
        NSString *b = [arr objectAtIndex:1];
        NSString *c = [arr objectAtIndex:2];
        return a.intValue * 100 + b.intValue * 10 + c.intValue;
    }
    return 0;
}


+ (void)checkVersionNeedUpdate:(NSString *)strUrl
                       success:(void (^)(bool bNeedUpdate,NSString *strLastestV))success
                       failure:(void (^)(NSString *strMsg))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:strUrl];
        bool bRet = false;
        NSData *responeData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responeData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"网络连接失败,请检查网络");
                return ;
            }
            @try {
                TBXML *xml = [[TBXML alloc] initWithXMLData:responeData error:nil];
                TBXMLElement *root = xml.rootXMLElement;
                if (!root) {
                    failure(@"获取版本信息失败");
                    return ;
                }
                TBXMLElement *update =  [TBXML childElementNamed:@"update" parentElement:root];
                if (!update) {
                    failure (@"获取版本信息失败");
                    return;
                }
                TBXMLElement *ios = [TBXML childElementNamed:@"ios" parentElement:update];
                NSString *version = [TBXML textForElement:ios];
                if ([oschinaTool getAppVersion:version] > [oschinaTool getAppVersion:[oschinaTool getAppVersion]]) {
                    success(true,version);
                }else{
                    success(false,version);
                }
            }
            @catch (NSException *exception) {
                [NdUncaughtExceptionHandler TakeException:exception];
            }
            @finally {
            }
        });
    });
}


+ (NSString *)getXibName:(NSString *)strXibName
{
    NSString *strRet = nil;
    if (!strXibName) {
        return strRet;
    }
    if (iPhone5) {
        strRet = [NSString stringWithFormat:@"%@_iphone5",strXibName];
    }else{
        strRet = strXibName;
    }
    return strRet;
}

+ (void)clearWebViewBackgrount:(UIWebView *)webView
{
    UIWebView *web = webView;
    for (id v in web.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            [v setBounces:NO];
        }
    }
}

+ (void)loginWithUser:(NSString *)strUser
                  Pwd:(NSString *)strPwd
            keepLogin:(NSString *)strKeepLogin
              success:(void (^)(bool,NSString *LoginMsg,UserModel *user))success
              failure:(void (^)(NSString *failureMsg))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:URL_LOGIN(strUser, strPwd, strKeepLogin)];
        bool bRet = false;
        NSData *responeData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responeData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"连接服务器失败,请检查网络");
                return ;
            }
            ErrorModel *error = [oschinaTool getError:responeData];
            switch (error.nErrorCode) {
                case -1:
                    failure (error.strErrorMsg);
                    break;
                case 0:
                    success(false,error.strErrorMsg,nil);
                    break;
                case 1:
                {
                    [[config instance] saveCookie:true];
                    UserModel *user = [[[UserModel alloc] initWithXml:[[[TBXML alloc] initWithXMLData:responeData error:nil] autorelease]] autorelease];
                    [oschinaSingleton sharedInstance].user = user;
                    
                    [[config instance] saveUID:[user.strUid intValue]];
                    success(true,error.strErrorMsg,user);
                }
                    break;
                default:
                    break;
            }
        });
        
    });
}

+ (ErrorModel *)getError:(NSData *)respone
{
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:respone error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        if (!root) {
            return nil;
        }
        TBXMLElement *result = [TBXML childElementNamed:@"result" parentElement:root];
        if (!result) {
            return nil;
        }
        TBXMLElement *errorCode = [TBXML childElementNamed:@"errorCode" parentElement:result];
        TBXMLElement *errorMsg = [TBXML childElementNamed:@"errorMessage" parentElement:result];
        ErrorModel *error = [[ErrorModel alloc] initWithErrorCode:[[TBXML textForElement:errorCode] intValue] ErrorMsg:[TBXML textForElement:errorMsg]];
        return [error autorelease];
        
    }
    @catch (NSException *exception) {
       [NdUncaughtExceptionHandler TakeException:exception];
        return [[ErrorModel alloc] initWithErrorCode:-1 ErrorMsg:@"出现异常"];
    }
    @finally {
    }
}

+(void)searchList:(NSString *)strContent
          catalog:(NSString *)strCatalog
        pageIndex:(int)nPageIndex
         pageSize:(int)nPageSize
          success:(void (^)(bool b,NSMutableArray *))success
          failure:(void (^)(NSString *errMsg))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:URL_SEARCH_LIST(strContent, strCatalog, nPageIndex, nPageSize)];
        bool bRet = false;
        NSData *responeData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responeData];
        dispatch_async(dispatch_get_main_queue(), ^{
             if (!bRet) {
                 failure(@"请求服务器失败,请检查网络");
                 return ;
             }
            NSMutableArray *arr = [oschinaTool analyTheSearchXMLData:responeData];
            if (arr==nil || [arr count] <=0) {
                success(false,arr);
            }else{
                success(true,arr);
            }
        });
    });
}


+ (NSMutableArray *)analyTheSoftwareCatalogsXNLData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:2]autorelease];
    @try {
        TBXML *xml = [[[TBXML alloc] initWithXMLData:responseData error:nil] autorelease];
        TBXMLElement *root = xml.rootXMLElement;
        TBXMLElement *softwareTypes = [TBXML childElementNamed:@"softwareTypes" parentElement:root];
        if (!softwareTypes) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"softwareType" parentElement:softwareTypes];
        if (!first) {
            return nil;
        }
        softwareCatalogModel *softwareType = [[softwareCatalogModel alloc] initWithXML:first];
        [arr addObject:softwareType];
        [softwareType release];softwareType = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"softwareType" searchFromElement:first];
            if (first) {
                softwareType = [[softwareCatalogModel alloc] initWithXML:first];
                [arr addObject:softwareType];
                [softwareType release];softwareType = nil;
            }
        }
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        
    }
    return arr;
}

+ (NSMutableArray *)analytheSoftwareXMLData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
    @try {
        TBXML *xml = [[[TBXML alloc] initWithXMLData:responseData error:nil] autorelease];
        TBXMLElement *root = xml.rootXMLElement;
        TBXMLElement *softwares = [TBXML childElementNamed:@"softwares" parentElement:root];
        if (!softwares) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"software" parentElement:softwares];
        if (!first) {
            return nil;
        }
        softwareModel *softMode = [[softwareModel alloc] initWith:first];
        [arr addObject:softMode];
        [softMode release];softMode = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"software" searchFromElement:first];
            if (first) {
                
                softMode = [[softwareModel alloc] initWith:first];
                NSLog(@"%@",softMode.strName);
                [arr addObject:softMode];
                [softMode release];softMode = nil;
            }
        }
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        
    }
    return arr;
}

+ (void)getSoftwareCatalogs:(int)nTag
                    success:(void (^)(bool, NSMutableArray *))success
                    failure:(void (^)(NSString *))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:URL_GET_SOFTWARE_CATALOG(nTag)];
        bool bRet = false;
        NSData *responeData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responeData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"请求服务器失败");
                return ;
            }
            NSMutableArray *arr = [oschinaTool analyTheSoftwareCatalogsXNLData:responeData];
            if (!arr || [arr count] <=0) {
                success(false,arr);
            }else{
                success(true,arr);
            }
        });
    });
}



+ (UIColor *)getBackgroundColor
{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
}

+ (UITableViewCell *)getLoadMoreCell:(UITableView *)tableView loadOver:(bool)_bLoadOver loadOverString:(NSString *)_strLoadOver loading:(bool)_bLoading loadingString:(NSString *)_strLoading
{
    moreResultsCell *moreCell = (moreResultsCell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_MORE_RESULTS_CELL];
    if (!moreCell) {
        moreCell = [[[NSBundle mainBundle] loadNibNamed:@"moreResultsCell" owner:self options:nil] objectAtIndex:0];
    }
    moreCell.act_Loading.hidden = YES;
    moreCell.lbl_content.text   = _bLoadOver ? _strLoadOver : _strLoading;
    [moreCell.lbl_content setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:18]];
    if (_bLoading) {
        moreCell.act_Loading.hidden = NO;
        [moreCell.act_Loading startAnimating];
    }
    if (_bLoadOver) {
        moreCell.act_Loading.hidden = YES;
        [moreCell.act_Loading stopAnimating];
    }
    return moreCell;
}
+ (void)getNoteList:(NSString *)strUrl
            catalog:(int)nCatalog
            success:(void (^)(bool, NSMutableArray *))success
            failure:(void (^)(NSString *errDes))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:strUrl];
        bool bRet = false;
        NSData *responseData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"请求服务器失败,请检查网络");
                return ;
            }
            NSMutableArray *arr = nil;
            switch (nCatalog) {
                case 1:
                    arr = [oschinaTool analytheNewsXMLData:responseData];
                    break;
                case 2:
                case 3:
                    arr = [oschinaTool analytheNoteXMLData:responseData];
                    break;
                default:
                    break;
            }
            if (arr == nil || [arr count] <= 0) {
                success(false,arr);
            }else{
                success(true,arr);
            }
        });
    });
}

+ (NSMutableArray *)analytheNewsXMLData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:responseData error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        [xml release];xml = nil;
        TBXMLElement *newslist = [TBXML childElementNamed:@"newslist" parentElement:root];
        if (!newslist) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"news" parentElement:newslist];
        if (!first) {
            return nil;
        }
        newsModel *news = [[newsModel alloc] initWithXML:first];
        [arr addObject:news];
        [news release]; news = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"news" searchFromElement:first];
            if (first) {
                news = [[newsModel alloc] initWithXML:first];
                [arr addObject:news];
                [news release];news = nil;
            }else{
                break;
            }
        }
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
    }
    return arr;
}

+ (NSMutableArray *)analytheNoteXMLData:(NSData *)responseData
{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:2];
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:responseData error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        [xml release];xml = nil;
        TBXMLElement *blogs = [TBXML childElementNamed:@"blogs" parentElement:root];
        if (!blogs) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"blog" parentElement:blogs];
        if (!first) {
            return nil;
        }
        noteModel *note = [[noteModel alloc] initWithXML:first];
        [arr addObject:note];
        [note release]; note = nil;
        while (first) {
            first  = [TBXML nextSiblingNamed:@"blog" searchFromElement:first];
            if (first) {
                note = [[noteModel alloc] initWithXML:first];
                [arr addObject:note];
                [note release];note = nil;
            }else{
                break;
            }
        }
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
    }
    return arr;
}

+ (void)getSoftwareList:(NSString *)strSearchTag
                    tag:(int)nTag
              pageIndex:(int)nPageIndex
               pageSize:(int)nPageSize
                success:(void(^)(bool b,NSMutableArray *list)) success
                failure:(void(^)(NSString *errMsg))failure
{
    NSString *strUrl = nil;
    if (!strSearchTag && nTag != ERROR_BASE) {
        strUrl = URL_SOFTWRE_LIST_BY_TYPE(nTag, nPageIndex, nPageSize);
    }else{
        strUrl = URL_SOFTWARE_LIST_BY_OPTION(strSearchTag, nPageIndex, nPageSize);
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:strUrl];
        bool bRet = false;
        NSData *responseData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"请求服务器失败,请检查网络");
                return ;
            }
            NSMutableArray *arr = [oschinaTool analytheSoftwareXMLData:responseData];
            if (arr==nil || [arr count] <=0) {
                success(false,arr);
            }else{
                success(true,arr);
            }
        });
    });
}



+ (NSMutableArray *)analyTheSearchXMLData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:responseData error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        TBXMLElement *results = [TBXML childElementNamed:@"results" parentElement:root];
        if (!results) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"result" parentElement:results];
        if (!first) {
            return nil;
        }
        searchResultModel *searchResult = [[searchResultModel alloc] initWithXml:first];
        [arr addObject:searchResult];
        [searchResult release];searchResult = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"result" searchFromElement:first];
            if (!first) {
                break;
            }else{
                searchResult = [[searchResultModel alloc] initWithXml:first];
                [arr addObject:searchResult];
                [searchResult release];searchResult = nil;
            }
        }
    }
    @catch (NSException *exception) {
        [NdUncaughtExceptionHandler TakeException:exception];
    }
    @finally {
        
    }
    return arr;
}



+ (void)getPostList:(int)nCatalog
          pageIndex:(int)nPageIndex
           pageSize:(int)nPageSize
            success:(void (^)(bool, NSMutableArray *))success
            failure:(void (^)(NSString *))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:URL_POST_LIST(nCatalog, nPageIndex, nPageSize)];
        bool bRet = false;
        NSData *responseData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"请求服务器失败,请检查网络");
                return ;
            }
            NSMutableArray *arr = [oschinaTool analyThePOSTXmlData:responseData];
            if (arr == nil || [arr count] <=0) {
                success(false,arr);
            }else{
                success(true,arr);
            }
        });
    });
}

+ (NSMutableArray *)analyThePOSTXmlData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:responseData error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        TBXMLElement *posts = [TBXML childElementNamed:@"posts" parentElement:root];
        if (!posts) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"post" parentElement:posts];
        postModel *post = [[postModel alloc] initWithXML:first];
        [arr addObject:post];
        [post release]; post = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"post" searchFromElement:first];
            if (first) {
                post = [[postModel alloc] initWithXML:first];
                [arr addObject:post];
                [post release]; post = nil;
            }else{
                break;
            }
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return arr;
}



+ (void)pushTweetImgDetail:(NSString *)strImgUrl parent:(UIViewController *)parent
{
    TweetImgDetail *imgDetail = [[[TweetImgDetail alloc] initWithNibName:[oschinaTool getXibName:@"TweetImgDetail"] bundle:nil] autorelease];
    imgDetail.strImgHref = strImgUrl;
    [parent presentSemiViewController:imgDetail];
}

+ (void)pushTweetUser:(int)uid title:(NSString *)strTitle nav:(UINavigationController *)navController
{
    if (!uid) {
        return ;
    }
    userBlogsPage *blog = [[[userBlogsPage alloc] initWithNibName:[oschinaTool getXibName:@"userBlogsPage"] bundle:nil] autorelease];
    blog.strAuthorID = [NSString stringWithFormat:@"%d",uid];
    blog.strUID = @"0";
    blog.strAuthor = strTitle;
    userActivePage *active = [[[userActivePage alloc] initWithNibName:[oschinaTool getXibName:@"userActivePage"] bundle:nil] autorelease];
    UITabBarController *userTab = [[UITabBarController alloc] init];
    userTab.hidesBottomBarWhenPushed = YES;
    userTab.viewControllers = [NSArray arrayWithObjects:blog, active,nil];
    [navController pushViewController:userTab animated:YES];
}


+ (void)getTwitterList:(int)nUID
             pageIndex:(int)nPageIndex
              pageSize:(int)nPageSize
               success:(void (^)(bool, NSMutableArray *))success
               failure:(void(^)(NSString *errDes,NSMutableArray *list)) failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:URL_TWITTER_LIST(nUID, nPageIndex, nPageSize)];
        bool bRet = false;
        NSData *responseData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *arr = nil;
            if (!bRet) {
                
                SQLiteDatabase *_db = [oschinaTool initDB:DB_OSCHINA_CLIENT];
                SQLiteResultSet *_set = nil;
                if ([oschinaTool openTheDB:_db]) {
                    _set = [oschinaTool SelectTweetSet:_db nameTable:@"tweetCache"];
                    arr = [oschinaTool SelectTweetListFromSqlite:_set];
                }
                [_set close];
                [_db close];
                failure(@"请求服务器失败,请检查网络",arr);
                return ;
            }
            arr = [oschinaTool analyTheTwitterXmlData:responseData];
            if (arr == nil || [arr count] <=0) {
                success(false,arr);
            }else{
                
                SQLiteDatabase *_db = [oschinaTool initDB:DB_OSCHINA_CLIENT];
                if ([oschinaTool openTheDB:_db]) {
                    if (nPageIndex == 0) {
                        [oschinaTool clearTheTable:_db nameTable:@"tweetCache"];
                    }
                   
                    for (tweetModel *tweet in arr) {
                        if (![_db executeUpdate:@"insert into tweetCache (tweetid,portrait,author,authorid,body,appclientcount,commentcount,pubdate,url_imgsmall,url_imgbig) values (?,?,?,?,?,?,?,?,?,?)",tweet.strTweetID,tweet.strPortrait,tweet.strAuthor,tweet.strAuthorID,tweet.strBody,[NSNumber numberWithInt:tweet.nAppClient],[NSNumber numberWithInt:tweet.nCommentCount],tweet.strPubDate,tweet.strUrlImgSmall,tweet.strUrlImgBig]) {
                            [_db close];
                            NSLog(@"fcukfcukfcukfcukfc\nukfcukfcukfcukfcukfcukfcukfcukfcukfcukfcuk");
                            break;
                        };
                    }
                }
                [_db close];
                success(true,arr);
            }
        });
    });
}


+ (void)getCommentList:(int)nCatalog
                   uid:(NSString *)strUID
             pageIndex:(int)nPageIndex
              pageSize:(int)nPageSize
               success:(void (^)(bool, NSMutableArray *)) success
               failure:(void (^)(NSString *))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:URL_COMMENT_LIST(nCatalog, strUID, nPageIndex, nPageSize)];
        bool bRet = true;
        NSData *responseData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"请求服务器失败,请检查网络");
                return ;
            }
            NSMutableArray *arr = [oschinaTool analyTheCommentXmlData:responseData];
            if (arr == nil || [arr count] <= 0) {
                success(false,arr);
            }else{
                success(true,arr);
            }
        });
    });
}

+ (NSMutableArray *)analyTheCommentXmlData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:responseData error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        TBXMLElement *comments = [TBXML childElementNamed:@"comments" parentElement:root];
        if (!comments) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"comment" parentElement:comments];
        if (!first) {
            return nil;
        }
        commentModel *comment = [[commentModel alloc] initWithXML:first];
        [arr addObject:comment];
        [comment release]; comment = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"comment" searchFromElement:first];
            if (first) {
                comment = [[commentModel alloc] initWithXML:first];
                [arr addObject:comment];
                [comment release]; comment = nil;
            }else{
                break;
            }
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return arr;
}

+ (NSMutableArray *)analyTheTwitterXmlData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:responseData error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        TBXMLElement *tweets = [TBXML childElementNamed:@"tweets" parentElement:root];
        if (!tweets) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"tweet" parentElement:tweets];
        if (!first) {
            return nil;
        }
        tweetModel *tweet = [[tweetModel alloc] initWith:first];
        [arr addObject:tweet];
        [tweet release];tweet = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"tweet" searchFromElement:first];
            if (first) {
                tweet = [[tweetModel alloc] initWith:first];
                [arr addObject:tweet];
                [tweet release]; tweet = nil;
            }else{
                break;
            }
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
    return arr;
}
+ (NSMutableArray *)analytheMyBlogsXMLData:(NSData *)responseData
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
    @try {
        TBXML *xml = [[TBXML alloc] initWithXMLData:responseData error:nil];
        TBXMLElement *root = xml.rootXMLElement;
        TBXMLElement *blogs = [TBXML childElementNamed:@"blogs" parentElement:root];
        if (!blogs) {
            return nil;
        }
        TBXMLElement *first = [TBXML childElementNamed:@"blog" parentElement:blogs];
        if (!first) {
            return nil;
        }
        blogModel *blog = [[blogModel alloc] initWithXML:first];
        [arr addObject:blog];
        [blog release]; blog = nil;
        while (first) {
            first = [TBXML nextSiblingNamed:@"blog" searchFromElement:first];
            if (first) {
                blog = [[blogModel alloc] initWithXML:first];
                [arr addObject:blog];
                [blog release]; blog = nil;
            }else{
                break;
            }
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
        
    }
    return arr;
}

+ (void)getMyBlogs:(int)authorUID
         pageIndex:(int)nPageIndex
          pageSize:(int)nPageSize
               UID:(int)uid
           success:(void (^)(bool, NSMutableArray *))success
           failure:(void (^)(NSString *))failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:URL_MY_BLOGS_LIST(authorUID, nPageIndex, nPageSize, uid)];
        bool bRet = false;
        NSData *responseData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"请求服务器失败,请检查网络");
                return ;
            }
            NSMutableArray *arr = [oschinaTool analytheMyBlogsXMLData:responseData];
            if (arr == nil || [arr count] <= 0) {
                success(false,arr);
            }else{
                success(true,arr);
            }
        });
    });
}

+ (void)pubTweet:(int)nUID
             Msg:(NSString *)strMsg
         success:(void (^)(bool b,NSString *strErrorMsg)) success
         failure:(void (^)(NSString *strDes)) failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *strUrl = URL_PUB_TWEET(nUID, strMsg);
        strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:strUrl];
        bool bRet = false;
        NSData *responseData = nil;
        bRet = [oschinaTool requestWebWithUrl:url RetRespone:&responseData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!bRet) {
                failure(@"动弹失败,请检查网络");
                return ;
            }
            ErrorModel *error = [oschinaTool getError:responseData];
            switch (error.nErrorCode) {
                case -1:
                    failure (error.strErrorMsg);
                    break;
                case 0:
                    success(false,error.strErrorMsg);
                    break;
                case 1:
                    success(true,error.strErrorMsg);
                    break;
                default:
                    break;
            }
        });
    });
}

+ (void)pubTweet:(int)nUID
             Msg:(NSString *)strMsg
             img:(NSData *)img
         success:(void (^)(bool b,NSString *strErrorMsg)) success
         failure:(void (^)(NSString *strDes)) failure
{
    
    if (img) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL_PUB_TWEET_IMG]];
            [request setUseCookiePersistence:YES];
            [request setPostValue:[NSString stringWithFormat:@"%d",[config instance].getUID] forKey:@"uid"];
            [request setPostValue:strMsg forKey:@"msg"];
            [request addData:img withFileName:@"img.jpg" andContentType:@"image/jpeg" forKey:@"img"];
            [request startSynchronous];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error = [request error];
                if (!error) {
                    NSData *responseData = [request responseData];
                    ErrorModel *errorModel = [oschinaTool getError:responseData];
                    switch (errorModel.nErrorCode) {
                        case 1:
                        {
                            success(true,errorModel.strErrorMsg);
                        }
                            break;
                        case 0:
                        case -1:
                        case -2:
                        {
                            success(false,errorModel.strErrorMsg);
                        }
                            break;
                        default:
                            break;
                    }
            }else{
                failure (@"动弹失败,请检查网络");
            }
            });
        });
        return;
    }
    [oschinaTool pubTweet:nUID Msg:strMsg success:success failure:failure];
}


+ (void)roundTextView:(UITextView *)txtView
{
    //txtView.layer.borderColor = UIColor.grayColor.CGColor;
    txtView.layer.borderColor = [[UIColor colorWithRed:0.52f green:0.09f blue:0.07f alpha:1] CGColor];
    txtView.layer.borderWidth = 1.75f;
    txtView.layer.cornerRadius = 10.0;
    txtView.layer.masksToBounds = YES;
    txtView.clipsToBounds = YES;
}

+ (void)roundWebView:(UIWebView *)web
{
    [[web layer] setCornerRadius:10];
    [web setClipsToBounds:YES];
    [[web layer] setBorderColor:[[UIColor colorWithRed:0.52f green:0.09f blue:0.07f alpha:1] CGColor]];
    [[web layer] setBorderWidth:1.75f];
}

+ (UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

+ (NSString *)getAppClient:(int)appClient
{
    switch (appClient) {
        case 1:
            return @"";
        case 2:
            return @"来自手机";
        case 3:
            return @"来自Android";
        case 4:
            return @"来自iPhone";
        case 5:
            return @"来自Windows Phone";
        default:
        return @"";
    }
}

+ (NSString *)sandBoxPath:(NSString *)_dbName
{
    NSArray* paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ;
    NSLog(@"%@",[[paths objectAtIndex:0]stringByAppendingPathComponent:_dbName]);
    return [[paths objectAtIndex:0]stringByAppendingPathComponent:_dbName];
}

+ (SQLiteDatabase *)initDB:(NSString *)_nameDB
{
    
    SQLiteDatabase *_db = [SQLiteDatabase databaseWithPath:[oschinaTool sandBoxPath:_nameDB]];
    return _db;
}

+ (bool)openTheDB:(SQLiteDatabase *)_db
{
    bool _bRet = false;
    if ([_db open]) {
        _bRet = true;
    }
    return _bRet;
}

+ (bool)createTable:(SQLiteDatabase *)_db sql:(NSString *)_sql
{
    bool _bRet = false;
    if ([_db open]) {
        _bRet = [_db createTable:_sql];
    }else{
        [_db close];
    }
    return _bRet;
}

+ (bool)createTweetTable:(SQLiteDatabase *)_db nametable:(NSString *)_nameTable
{
    return [oschinaTool createTable:_db sql:[NSString stringWithFormat:@"create table if not exists %@ (tweetid text,portrait text,author text, authorid text,body text,appclientcount integer, commentcount integer,pubdate text,url_imgsmall text,url_imgbig text)",_nameTable]];
}


+ (SQLiteResultSet *)SelectSet:(SQLiteDatabase *)_db sql:(NSString *)_sql
{
    return [_db executeQuery:_sql];
}

+ (SQLiteResultSet *)SelectTweetSet:(SQLiteDatabase *)_db nameTable:(NSString *)_nameTable
{
    return [oschinaTool SelectSet:_db sql:[NSString stringWithFormat:@"select * from %@",_nameTable]];
}

+ (NSMutableArray *)SelectTweetListFromSqlite:(SQLiteResultSet*)set
{
    NSMutableArray *arr = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
    while ([set next]) {
        tweetModel *_tweet = [[tweetModel alloc] init];
        _tweet.strTweetID  = [set stringForColumn:@"tweetid"];
        _tweet.strPortrait = [set stringForColumn:@"portrait"];
        _tweet.strAuthor   = [set stringForColumn:@"author"];
        _tweet.strAuthorID = [set stringForColumn:@"authorid"];
        _tweet.strBody     = [set stringForColumn:@"body"];
        _tweet.nAppClient  = [set intForColumn:@"appclientcount"];
        _tweet.nCommentCount = [set intForColumn:@"commentcount"];
        _tweet.strPubDate  = [set stringForColumn:@"pubdate"];
        _tweet.strUrlImgSmall = [set stringForColumn:@"url_imgsmall"];
        _tweet.strUrlImgBig = [set stringForColumn:@"url_imgbig"];
        
        [arr addObject:_tweet];
        [_tweet release]; _tweet = nil;
    }
    return arr;
}

+ (bool)clearTheTable:(SQLiteDatabase *)_db nameTable:(NSString *)_nameTable
{
    return [_db executeSql:[NSString stringWithFormat:@"delete from %@",_nameTable]];
}

+ (UIImage *)renderImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, theView.opaque, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImg;
}



@end
