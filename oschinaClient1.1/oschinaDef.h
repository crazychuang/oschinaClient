//
//  oschinaDef.h
//  oschinaClient
//
//  Created by boai on 13-6-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#ifndef oschinaClient_oschinaDef_h
#define oschinaClient_oschinaDef_h

#ifdef DEBUG
#define DLog(fmt,...) NSLog((fmt),##__VA_ARGS__);
#else
#define DLog(...);
#endif

#define DB_OSCHINA_CLIENT  @"ochinaClient.db"
/*
    ------------------tweetCache-------------------------------------------------------------------------------------------
    | tweetid | portrait | author | authorid | body | appclientcount | commentcount | pubdate | url_imgsmall | url_imgbig |
    |----------------------------------------------------------------------------------------------------------------------
    |                                                                                                                     |
    |----------------------------------------------------------------------------------------------------------------------

 
 
*/
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define SETTINGTABLEID          @"SETTINGTABLEID"
#define URL_OSCHINA_APP_VERSION @"http://www.oschina.net/MobileAppVersion.xml"
#define NAME_FILE_EXCEPTION     @"exception.txt"
#define APPID                   @"524298520"
#define URL_UPDATE_APP(APPID)          [NSString stringWithFormat:@"itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",APPID]

#define nTimeoutInterval 15

#define HTML_ABOUT_USER @"<body style='background-color:#EBEBF3'>1, 您可以在 <a href='http://www.oschina.net'>http://www.oschina.net</a> 上免费注册一个账号用来登陆<p />2, 如果您的账号是使用OpenID的方式注册的，那么建议您在网页上为账号设置密码<p />3, 您可以点击 <a href='http://www.oschina.net/question/12_52232'>这里</a> 了解更多关于手机客户端登录的问题</body>"

#define URL_LOGIN(USER,PWD,KEEPLOGIN) [NSString stringWithFormat:@"https://www.oschina.net/action/api/login_validate?username=%@&pwd=%@&keep_login=%@",USER,PWD,KEEPLOGIN]
#define URL_SEARCH_LIST(CONTENT,CATALOG,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/search_list?content=%@&catalog=%@&pageIndex=%d&pageSize=%d",CONTENT,CATALOG,PAGEINDEX,PAGESIZE]
#define URL_GET_SOFTWARE_CATALOG(TAG) [NSString stringWithFormat:@"http://www.oschina.net/action/api/softwarecatalog_list?tag=%d",TAG]

#define URL_SOFTWARE_LIST_BY_OPTION(SEARCHTAG,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/software_list?searchTag=%@&pageIndex=%d&pageSize=%d",SEARCHTAG,PAGEINDEX,PAGESIZE]
#define URL_SOFTWRE_LIST_BY_TYPE(TAG,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/softwaretag_list?searchTag=%d&pageIndex=%d&pageSize=%d",TAG,PAGEINDEX,PAGESIZE]

#define URL_NEWS_LIST(CATALOG,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/news_list?catalog=%d&pageIndex=%d&pageSize=%d",CATALOG,PAGEINDEX,PAGESIZE]
#define URL_NOTE_LIST(TYPE,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/blog_list?type=%@&pageIndex=%d&pageSize=%d",TYPE,PAGEINDEX,PAGESIZE]

#define URL_POST_LIST(CATALOG,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/post_list?catalog=%d&pageIndex=%d&pageSize=%d",CATALOG,PAGEINDEX,PAGESIZE]

#define URL_TWITTER_LIST(UID,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/tweet_list?uid=%d&pageIndex=%d&pageSize=%d",UID,PAGEINDEX,PAGESIZE]

#define URL_MY_BLOGS_LIST(AUTHORID,PAGEINDEX,PAGESIZE,UID) [NSString stringWithFormat:@"http://www.oschina.net/action/api/userblog_list?authoruid=%d&pageIndex=%d&pageSize=%d&uid=%d",AUTHORID,PAGEINDEX,PAGESIZE,UID]

#define URL_PUB_TWEET(UID,MSG) [NSString stringWithFormat:@"http://www.oschina.net/action/api/tweet_pub?uid=%d&msg=%@",UID,MSG]
#define URL_PUB_TWEET_IMG @"http://www.oschina.net/action/api/tweet_pub"

#define URL_BLOG_COMMENT_LIST(ID,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/blogcomment_list?id=%d&pageIndex=%d&pageSize=%d",ID,PAGEINDEX,PAGESIZE]

#define URL_COMMENT_LIST(CATALOG,ID,PAGEINDEX,PAGESIZE) [NSString stringWithFormat:@"http://www.oschina.net/action/api/comment_list?catalog=%d&id=%@&pageIndex=%d&pageSize=%d",CATALOG,ID,PAGEINDEX,PAGESIZE]

#define FONT_NAME_HUA_KANG_SHAO_NV_W5 @"DFShaoNvW5-GB"

#define ID_CELL_NORMAL @"ID_CELL_NORMAL"
#define ID_CELL_MORE_RESULTS_CELL @"_D_CELL_MORE_RESULTS_CELL"
#define ID_CELL_SOFTWARE_CATALOG_ID @"ID_CELL_SOFTWARE_CATALOG_ID"
#define ID_CELL_SOFTWARE_CELL @"ID_CELL_SOFT_WARE_CELL"
#define ID_CELL_SOFTWARE_COMPLEX_CELL @"ID_CELL_SOFTWARE_COMPLEX_CELL"
#define ID_CELL_POST_CELL @"ID_CELL_POST_CELL"
#define ID_CELL_TWEET @"ID_CELL_TWEET"
#define ID_CELL_MY_BLOG @"ID_CELL_MY_BLOG"
#define ID_CELL_HEAD_NAME_CELL @"ID_CELL_HEAD_NAME_CELL"
#define ID_CELL_INFO_CELL @"ID_CELL_INFO_CELL"
#define ID_CELL_BUSINESS_CELL @"ID_CELL_BUSINESS_CELL"
#define ID_CELL_COMMENT_CELL @"ID_CELL_COMMENT_CELL"
#define ERROR_BASE -1

#define HTML_STYLE @"<style>#oschina_title {color: #000000; margin-bottom: 6px; font-weight:bold;}#oschina_title img{vertical-align:middle;margin-right:6px;}#oschina_title a{color:#0D6DA8;}#oschina_outline {color: #707070; font-size: 12px;}#oschina_outline a{color:#0D6DA8;}#oschina_software{color:#808080;font-size:12px}#oschina_body img {max-width: 300px;}#oschina_body {font-size:16px;max-width:300px;line-height:24px;} #oschina_body table{max-width:300px;}#oschina_body pre { font-size:9pt;font-family:Courier New,Arial;border:1px solid #ddd;border-left:5px solid #6CE26C;background:#f6f6f6;padding:5px;}</style>"
#define HTML_BOTTOM @"<div style='margin-bottom:60px'/>"

enum{
    TAG_SKIN_DAYTIME,
    TAG_SKIN_NIGHT,
    TAG_SKIN_BLUE,
    TAG_SKIN_RED,
    TAG_SKIN_BLACK
};
#define TAG_CHANGE_NAV_THEME_NOT @"TAG_CHANGE_NAV_THEME_NOT"
#define TAG_CHANGE_BG_THEME_NOT @"TAG_CHANGE_BG_THEME_NOT"

#endif
