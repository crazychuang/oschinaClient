//
//  queAnswPage.m
//  oschinaClient
//
//  Created by boai on 13-7-3.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "queAnswPage.h"
#import "postModel.h"
#import "PostCell.h"
#import "UIImageView+WebCache.h"
@interface queAnswPage ()

@end

@implementation queAnswPage
@synthesize arrPosts = _arrPosts;
@synthesize bLoading = _bLoading;
@synthesize bLoadOver = _bLoadOver;
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
    
    WXJSliderSwitch *_slider = [[WXJSliderSwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 45 * 5, 29)];
    [_slider setSliderSwitchBg:[UIImage imageNamed:@"top_tab_background3"]];
    _slider.nLabelCount = 5;
    _slider.nTabWidth = 45;
    _slider.nTabOffset = 0;
    _slider.delegate = self;
    [_slider initSliderSwitch:@"回答",@"分享",@"综合",@"职业",@"站务"];
    self.navigationItem.titleView = _slider;
    [_slider release];
    
    [self.table_list setDataSource:self];
    [self.table_list setDelegate:self];
    
    self.arrPosts = [[NSMutableArray alloc] initWithCapacity:5];
    _nTab = 0;
    [self doGetPostList:_nTab + 1 pageIndex:[self.arrPosts count] / 20 pageSize:20];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return [self.arrPosts count];
    }
    return  [self.arrPosts count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.arrPosts count]) {
        return 40.0f;
    }
    return [PostCell resizeTheCellHeight:((postModel *)[self.arrPosts objectAtIndex:indexPath.row]).strTitle];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.arrPosts count] > 0) {
        if (indexPath.row >= [self.arrPosts count]) {
            return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"更多"];
        }else{
            PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_POST_CELL];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PostCell" owner:self options:nil] objectAtIndex:0];
            }
            
            postModel *post = [self.arrPosts objectAtIndex:indexPath.row];
            [cell initTheCell:post.strTitle];
            [cell.img_Head setImageWithURL:[NSURL URLWithString:post.strPortrait] placeholderImage:[UIImage imageNamed:@"avatar_loading.png"]];
            cell.txt_Other.text = [NSString stringWithFormat:@"%@ 发表于 %@",post.strAuthor,post.strPubDate ];
            cell.txt_Count_Answer.text = [NSString stringWithFormat:@"%d",post.nAnswerCount];
            cell.txt_Count_Answer.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:14];
            return cell;
        }
    }else{
        return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.arrPosts count]) {
        if (!_bLoading && !_bLoadOver) {
            [self doGetPostList:_nTab + 1 pageIndex:[self.arrPosts count] / 20 pageSize:20];
        }
    }
}

- (void)doGetPostList:(int)nCatalog pageIndex:(int)nPageIndex pageSize:(int)nPageSize
{
    _bLoadOver  = false;
    _bLoading = true;
    [oschinaTool getPostList:nCatalog pageIndex:nPageIndex pageSize:nPageSize
                     success:^(bool b, NSMutableArray *list) {
                         _bLoading = false;
                         if (b) {
                             if ([list count] < 20) {
                                 _bLoadOver = true;
                             }
                             [self.arrPosts addObjectsFromArray:list];
                         }else{
                             
                         }
                         [self.table_list reloadData];
    }
                     failure:^(NSString *errDes) {
                         _bLoadOver = true;
                         _bLoading = false;
                         [self.table_list reloadData];
                         [oschinaTool showMsgWithTitle:@"提示" Msg:errDes delegate:nil cancelBtn:@"确定" otherBtn:nil];
    }];
    [self.table_list reloadData];
}

- (void)clearBuffer
{
    if (_arrPosts && [_arrPosts count] > 0) {
        [_arrPosts removeAllObjects];
    }
    _bLoadOver = true;
    _bLoading = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_arrPosts release];
    [_table_list release];
    [super dealloc];
}

- (void)slideView:(WXJSliderSwitch *)slideSwitch switchChangedAtIndex:(NSInteger)index
{
    _nTab = index;
    [self clearBuffer];
    [self doGetPostList:index + 1 pageIndex:[_arrPosts count] / 20 pageSize:20];
}

@end
