//
//  tweetDetailViewController.m
//  oschinaClient
//
//  Created by boai on 13-7-24.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "tweetDetailViewController.h"
#import "commentCell.h"
#import "commentModel.h"
@interface tweetDetailViewController ()

@end

@implementation tweetDetailViewController
@synthesize tweet = _tweet;
@synthesize arrComments = _arrComments;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
        //btnSearch.image = [UIImage imageNamed:@"tweet24"];
        btnRight.title = @"发表";
        [btnRight setAction:@selector(commentTheTweet:)];
        self.navigationItem.rightBarButtonItem = btnRight;
    }
    return self;
}

- (void)commentTheTweet:(UIBarButtonItem *)sender
{
    if ([_txt_comment isEditable]) {
        [_txt_comment resignFirstResponder];
    }
    
    if ([_txt_comment.text isEqualToString:@""]) {
        [oschinaTool showMsgWithTitle:@"提示" Msg:@"请输入评论" delegate:nil cancelBtn:@"确定" otherBtn:@"取消"];
        return;
    }
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavTxt:@"动弹一下 详情"];
    self.web_tweetDetail.backgroundColor = [oschinaTool getBackgroundColor];
    [self.view setBackgroundColor:[oschinaTool getBackgroundColor]];
    
    [oschinaTool roundTextView:_txt_comment];
    [_txt_comment setDelegate:self];
    _txt_comment.autocorrectionType = UITextAutocorrectionTypeNo;
    _txt_comment.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    NSString *pubTime = [NSString stringWithFormat:@"在%@ 更新了动态 %@",_tweet.strPubDate,[oschinaTool getAppClient:_tweet.nAppClient]];
    NSString *strImgHtml = @"";
    if ([_tweet.strUrlImgBig isEqualToString:@""] == NO) {
        strImgHtml = [NSString stringWithFormat:@"<br/><a href='http://fuck'><img style='max-width:300px;' src='%@'/></a>", _tweet.strUrlImgBig];
    }
    NSString *html = [NSString stringWithFormat:@"%@<body style='background-color:#EBEBF3'><div id='oschina_title'><a href='http://my.oschina.net/u/%@'>%@</a></div><div id='oschina_outline'>%@</div><br/><div id='oschina_body' style='font-weight:normal;font-size:16px;line-height:21px;'>%@</div>%@%@</body>",HTML_STYLE,_tweet.strAuthorID,_tweet.strAuthor,pubTime,_tweet.strBody,strImgHtml,HTML_BOTTOM];
    [self.web_tweetDetail setDelegate:self];
    [self.web_tweetDetail loadHTMLString:html baseURL:nil];
    [oschinaTool roundWebView:_web_tweetDetail];
    [oschinaTool clearWebViewBackgrount:_web_tweetDetail];
    
    _arrComments = [[NSMutableArray alloc] initWithCapacity:2];
    _bLoading = false;
    _bLoadOver = true;
    [_table_comment_list setDelegate:self];
    [_table_comment_list setDataSource:self];
    [_table_comment_list setBackgroundView:nil];
    [[_table_comment_list layer] setCornerRadius:10];
    [_table_comment_list setClipsToBounds:YES];
    [[_table_comment_list layer] setBorderColor:[[UIColor colorWithRed:0.52f green:0.09f blue:0.07f alpha:1] CGColor]];
    [[_table_comment_list layer] setBorderWidth:1.75f];
    if (!_tweet.nCommentCount) {
        _table_comment_list.hidden = YES;
    }
    [self doGetComments:3 pageIndex:_arrComments.count / 5  pageSize:5];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return [self.arrComments count];
    }
    return  [self.arrComments count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.arrComments count]) {
        return 40.0f;
    }
    return [commentCell resizeTheCellHeight:((commentModel *)[self.arrComments objectAtIndex:indexPath.row]).strContent];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.arrComments count] > 0) {
        if (indexPath.row >= [self.arrComments count]) {
            return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"更多"];
        }else{
            commentCell *cell = (commentCell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_COMMENT_CELL];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"commentCell" owner:self options:nil] objectAtIndex:0];
            }
            
            commentModel *comment = [self.arrComments objectAtIndex:indexPath.row];
            [cell initTheCell:comment.strContent];
            
            cell.lbl_other.text = [NSString stringWithFormat:@"%@ 发表于 %@",comment.strAuthor,comment.strPubDate ];
            
            return cell;
        }
    }else{
        return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.arrComments count]) {
        if (!_bLoading && !_bLoadOver) {
            [self doGetComments:3 pageIndex:_arrComments.count / 5  pageSize:5];
        }
    }
}

- (void)doGetComments:(int)nCatalog pageIndex:(int)nPageIndex pageSize:(int)nPageSize
{
    _bLoadOver = false;
    _bLoading = true;
    [oschinaTool getCommentList:nCatalog
                            uid:_tweet.strTweetID
                      pageIndex:nPageIndex
                       pageSize:nPageSize
                        success:^(bool b, NSMutableArray *list) {
                            _bLoading = false;
                            if (b) {
                                if (list.count < 5) {
                                    _bLoadOver = true;
                                }
                                [self.arrComments addObjectsFromArray:list];
                            }else{
                                _bLoadOver = true;
                                
                            }
                            [self.table_comment_list reloadData];
    }
                        failure:^(NSString *errDes) {
                            _bLoadOver = true;
                            _bLoading = false;
                            [self.table_comment_list reloadData];
                            [oschinaTool showMsgWithTitle:@"提示" Msg:errDes delegate:nil cancelBtn:@"确定" otherBtn:nil];
    }];
     [self.table_comment_list reloadData];
}

// iOS 禁用UIWebView 加载 网页的长按事件
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_web_tweetDetail stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    [_web_tweetDetail stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString isEqualToString:@"http://fuck/"]) {
        [oschinaTool pushTweetImgDetail:_tweet.strUrlImgBig parent:self];
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-210, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+210, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_arrComments release];
    [_tweet release];
    [_web_tweetDetail release];
    [_txt_comment release];
    [_table_comment_list release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setWeb_tweetDetail:nil];
    [self setTxt_comment:nil];
    [self setTable_comment_list:nil];
    [super viewDidUnload];
}
- (IBAction)bgPressed:(id)sender {
    [self.txt_comment resignFirstResponder];
}
@end
