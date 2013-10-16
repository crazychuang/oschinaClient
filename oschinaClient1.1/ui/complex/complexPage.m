//
//  complexPage.m
//  oschinaClient
//
//  Created by boai on 13-6-28.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "complexPage.h"
#import "newsModel.h"
#import "SearchPage.h"
#import "noteModel.h"
@interface complexPage ()

@end

@implementation complexPage
@synthesize dataList = _dataList;
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
    _bLoading = false;
    _bLoadOver = true;
    self.dataList = [[NSMutableArray alloc] initWithCapacity:2];
    [self.table_list setDelegate:self];
    [self.table_list setDataSource:self];
    
    WXJSliderSwitch *_slider = [[WXJSliderSwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 65 * 3, 29)];
    [_slider setSliderSwitchBg:[UIImage imageNamed:@"top_tab_background3"]];
    _slider.nLabelCount = 3;
    _slider.nTabWidth = 65;
    _slider.nTabOffset = 0;
    _slider.delegate = self;
    [_slider initSliderSwitch:@"质讯",@"博客",@"推荐阅读"];
    self.navigationItem.titleView = _slider;
    [_slider release];
    
    
    
    UIBarButtonItem *btnSearch = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    btnSearch.image = [UIImage imageNamed:@"searchWhite"];
    [btnSearch setAction:@selector(searchBtnPressed:)];
    self.navigationItem.rightBarButtonItem = btnSearch;
    _nTab = 0;
    
    [self getNotes:[NSString stringWithFormat:@"%d",1] pageIndex:[self.dataList count] / 20 pagesize:20 Segment:_nTab + 1];
}

- (void)searchBtnPressed:(id)sender
{
    SearchPage *search = [[[SearchPage alloc] initWithNibName:[oschinaTool getXibName:@"SearchPage"] bundle:nil] autorelease];
    [self.navigationController pushViewController:search animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return [_dataList count];
    }
    return [_dataList count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataList count]) {
        return 40.0f;
    }
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataList count] > 0) {
        if (indexPath.row >= [self.dataList count]) {
            return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"更多"];
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_CELL_SOFTWARE_COMPLEX_CELL];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID_CELL_SOFTWARE_COMPLEX_CELL];
            }
            id obj = [self.dataList objectAtIndex:indexPath.row];
            newsModel *news = nil;
            noteModel *note = nil;
            switch (_nTab) {
                case 0:
                {
                    news = (newsModel *)obj;
                    cell.textLabel.text = news.strTitle;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 发布于 %@", news.strAuthor,news.strPubDate];
                }
                    
                    break;
                case 1:
                case 2:
                {
                    note = (noteModel *)obj;
                    cell.textLabel.text = note.strTitle;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 发布于 %@", note.strAuthor,note.strPubDate];
                }
                    break;
                default:
                    break;
            }
            
            cell.textLabel.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:14];
            return cell;
        }
    }else{
        return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataList count]) {
        if (!_bLoading && !_bLoadOver ) {
            switch (_nTab) {
                case 0:
                {
                    [self getNotes:[NSString stringWithFormat:@"%d",0] pageIndex:[self.dataList count] / 20 pagesize:20 Segment:_nTab + 1];
                }
                    break;
                case 1:
                case 2:
                {
                    [self getNotes:_nTab > 1 ? @"recommend":@"latest" pageIndex:[self.dataList count] / 20 pagesize:20 Segment:_nTab + 1];
                }
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)getNotes:(NSString  *)str pageIndex:(int)nPageIndex pagesize:(int)nPageSize Segment:(int)nSelected
{
    _bLoading = true;
    _bLoadOver = false;
    NSString *strUrl = nil;
    switch (nSelected) {
        case 1:
        {
            strUrl = URL_NEWS_LIST([str intValue], nPageIndex, nPageSize);
        }
            break;
        case 2:
        case 3:
        {
            strUrl = URL_NOTE_LIST(str, nPageIndex, nPageSize);
        }
            break;
        default:
            break;
    }
    [oschinaTool getNoteList:strUrl catalog:nSelected
                     success:^(bool b, NSMutableArray *list) {
                         _bLoading = false;
                         if(b){
                             if([list count] < 20)
                                 _bLoadOver = true;
                             [self.dataList addObjectsFromArray:list];
                         }else{
                         }
                         [self.table_list reloadData];
    }
                     failure:^(NSString *errMsg){
                         _bLoadOver = true;
                         _bLoading = false;
                         [self.table_list reloadData];
                         [oschinaTool showMsgWithTitle:@"提示" Msg:errMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
                         
    }];
    [self.table_list reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_dataList release];
    [_table_list release];
    
    [super dealloc];
}

- (void)clearBuffer
{
    if (_dataList && [_dataList count]) {
        [_dataList removeAllObjects];
        
    }
    _bLoadOver = true;
    _bLoading = false;
}

- (void)slideView:(WXJSliderSwitch *)slideSwitch switchChangedAtIndex:(NSInteger)index
{
    _nTab = index;
    
    [self clearBuffer];
    switch (index) {
        case 0:
        {
            [self getNotes:[NSString stringWithFormat:@"%d",0] pageIndex:[self.dataList count] / 20 pagesize:20 Segment:index + 1];
        }
            break;
        case 1:
        case 2:
        {
            [self getNotes:index > 1 ? @"recommend":@"latest" pageIndex:[self.dataList count] / 20 pagesize:20 Segment:index + 1];
        }
            break;
        default:
            break;
    }
}

@end
