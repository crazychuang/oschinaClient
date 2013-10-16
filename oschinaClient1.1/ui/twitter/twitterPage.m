//
//  twitterPage.m
//  oschinaClient
//
//  Created by boai on 13-7-8.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "twitterPage.h"
#import "config.h"
#import "writeTweetPage.h"
#import "tweetDetail/tweetDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface twitterPage ()

@end

@implementation twitterPage
@synthesize arrTwitters = _arrTwitters;
@synthesize bLoading = _bLoading;
@synthesize bLoadOver = _bLoadOver;
@synthesize breloading = _breloading;
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
    
    UIButton *_rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 37, 33)];
    [_rightBtn.titleLabel setFont:[UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:13]];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_post_enable"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(writeTweet:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:_rightBtn] autorelease];
    
    
    WXJSliderSwitch *_slider = [[WXJSliderSwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 68 * 3 - 4, 29)];
    [_slider setSliderSwitchBg:[UIImage imageNamed:@"top_tab_background3"]];
    _slider.nLabelCount = 3;
    _slider.nTabWidth = 68;
    _slider.delegate = self;
    [_slider initSliderSwitch:@"最新动弹",@"热门动弹",@"我的动弹"];
    
    self.navigationItem.titleView = _slider;
    [_slider release];
    
    
    [self.table_list setDelegate:self];
    [self.table_list setDataSource:self];
    self.table_list.separatorColor = [UIColor grayColor];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -320, self.view.frame.size.width,320)];
        view.delegate = self;
        [_table_list addSubview:view];
        _refreshHeaderView = [view retain];
        [view release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    _bLoading = false;
    _bLoadOver = true;
    _nTab = 0;
    self.arrTwitters = [[NSMutableArray alloc] initWithCapacity:5];
    
    
    [self doGetTweetsList:[self getUidBySegment:_nTab] pageIndex:self.arrTwitters.count / 20 pageSize:20];
    
}

- (void)writeTweet:(id)sender
{
    if (![config instance].isCookie) {
        [oschinaTool showMsgWithTitle:@"提示" Msg:@"请先登陆后再发表动弹" delegate:self cancelBtn:@"确定" otherBtn:@"取消"];
        return;
    }
    writeTweetPage *pubTweet = [[[writeTweetPage alloc] initWithNibName:[oschinaTool getXibName:@"writeTweetPage"] bundle:nil] autorelease];
    [self.navigationController pushViewController:pubTweet animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return [self.arrTwitters count];
    }
    return self.arrTwitters.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.arrTwitters.count) {
        return 40.0f;
    }
    return [tweetCell resizeTheCellHeight:(tweetModel *)[self.arrTwitters objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrTwitters.count > 0) {
        if (indexPath.row >= self.arrTwitters.count) {
            return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"更多"];
        }else{
            tweetCell *cell = (tweetCell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_TWEET];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"tweetCell" owner:self options:nil] objectAtIndex:0];
            }
            tweetModel *tweet = (tweetModel *)[self.arrTwitters objectAtIndex:indexPath.row];
            [cell initTheTweetCell:tweet];
            [cell addTweetTap:&cell action:@selector(clickTheTweetImg:) target:self tweetModel:tweet];
            [cell addHeadTap:cell.imgView_head action:@selector(clickTheHeadImg:) target:self tweetModel:tweet];
            return cell;
        }
    }else{
        return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
}

- (void)reloadTableViewDataSrc
{
    _breloading = true;
}

- (void)doneLoadingTableViewData
{
    [self clearBuffer];
    [self doGetTweetsList:[self getUidBySegment:_nTab] pageIndex:self.arrTwitters.count / 20 pageSize:20];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSrc];
    
    [self doneLoadingTableViewData];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _breloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
}


- (void)clickTheTweetImg:(UITap *)tap
{
    if (tap) {
        [oschinaTool pushTweetImgDetail:tap.strTagString parent:self];
    }
}

- (void)clickTheHeadImg:(UITap *)tap
{
    if (tap) {
        [oschinaTool pushTweetUser:tap.nTag title:tap.strTagString nav:self.navigationController];
    }
}

- (void)doGetTweetsList:(int)nUid pageIndex:(int)nPageIndex pageSize:(int)nPageSize
{
    _bLoadOver  = false;
    _bLoading = true;
    [oschinaTool getTwitterList:nUid pageIndex:nPageIndex pageSize:nPageSize
                        success:^(bool b, NSMutableArray *list) {
                            _breloading = NO;
                            [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_table_list];
                            
                            _bLoading = false;
                            if (b) {
                                if (list.count < 20) {
                                    _bLoadOver = true;
                                }
                                [self.arrTwitters addObjectsFromArray:list];
                            }else{
                                _bLoadOver = true;
                                if (![_arrTwitters count]) {
                                    [self.arrTwitters addObjectsFromArray:list];
                                }
                            }
                            [self.table_list reloadData];
    }
                        failure:^(NSString *errDes,NSMutableArray *list) {
                            _breloading = NO;
                            [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_table_list];
                            
                            
                            _bLoadOver = true;
                            _bLoading = false;
                            
                            if (![_arrTwitters count]) {
                                [self.arrTwitters addObjectsFromArray:list];
                            }
                            
                            [self.table_list reloadData];
                            [oschinaTool showMsgWithTitle:@"提示" Msg:errDes delegate:nil cancelBtn:@"确定" otherBtn:nil];
    }];
    [self.table_list reloadData];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.arrTwitters.count) {
        if (!_bLoading && !_bLoadOver) {
            [self doGetTweetsList:[self getUidBySegment:_nTab] pageIndex:self.arrTwitters.count / 20 pageSize:20];
            return;
        }
    }
    tweetDetailViewController *_tweetDetailPage = [[[tweetDetailViewController alloc] initWithNibName:[oschinaTool getXibName:@"tweetDetailViewController"]bundle:nil] autorelease];
    _tweetDetailPage.tweet = [_arrTwitters objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:_tweetDetailPage animated:YES];
}


-(void)reloadTableViewDataSource
{
    _breloading = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [_arrTwitters release];
    [_table_list release];
    [super dealloc];
}


- (void)viewDidUnload {
    
    [self setTable_list:nil];
    [super viewDidUnload];
}


- (int)getUidBySegment:(int)segment
{
    switch (segment) {
        case 0:
        {
            return 0;
        }
            break;
        case 1:
        {
            return -1;
        }
            break;
        case 2:
        {
            int nUID = [[config instance] getUID];
            if (nUID == 0 || [config instance].isCookie == NO) {
                return 0;
            }else{
                return nUID;
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

- (void)clearBuffer
{
    if (_arrTwitters && [_arrTwitters count] > 0) {
        [_arrTwitters removeAllObjects];
        [_table_list reloadData];
    }
    _bLoading = false;
    _bLoadOver = true;
}

- (void)slideView:(WXJSliderSwitch *)slideSwitch switchChangedAtIndex:(NSInteger)index
{
    _nTab = index;
    [self clearBuffer];
    if (![self getUidBySegment:index] && index == 2) {
        [oschinaTool showMsgWithTitle:@"提示" Msg:@"错误 你还未登录,将显示最新动弹" delegate:nil cancelBtn:@"确定" otherBtn:nil];
        return;
    }
    [self doGetTweetsList:[self getUidBySegment:index] pageIndex:self.arrTwitters.count / 20 pageSize:20];
}

@end
