//
//  SearchPage.m
//  oschinaClient
//
//  Created by boai on 13-6-17.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "SearchPage.h"
#import "oschinaTool.h"
#import "searchResultModel.h"
@interface SearchPage ()

@end

@implementation SearchPage
@synthesize results = _results;
@synthesize bLoadOver = _bLoadOver;
@synthesize bLoading  = _bLoading;
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
    
    WXJSliderSwitch *_slider = [[WXJSliderSwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 55 * 4, 29)];
    [_slider setSliderSwitchBg:[UIImage imageNamed:@"top_tab_background3"]];
    _slider.nLabelCount = 4;
    _slider.nTabWidth = 55;
    _slider.nTabOffset = 0;
    _slider.delegate = self;
    [_slider initSliderSwitch:@"搜软件",@"搜问答",@"搜博客",@"搜咨询"];
    self.navigationItem.titleView = _slider;
    [_slider release];
    
    
    [_searchBar becomeFirstResponder];
    [self.tableResult setDelegate:self];
    [self.tableResult setDataSource:self];
    [self.tableResult setBackgroundColor:[UIColor clearColor]];
    
    [self.searchBar setDelegate:self];
    _bLoadOver = true;
    _bLoading  = false;
    _results = [[NSMutableArray alloc] initWithCapacity:2];
    
    _nTab = 0;
    
}

- (void)slideView:(WXJSliderSwitch *)slideSwitch switchChangedAtIndex:(NSInteger)index
{
    _nTab = index;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if (searchBar.text.length <=0) {
        return;
    }
    
    [self clear];
    
    [self doSearchWithContent:searchBar.text catalog:[self getSearchKey:_nTab]  pageIndex:[self.results count] / 20 pageSize:20];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void)clear
{
    _bLoadOver = true;
    _bLoading  = false;
    [self.results removeAllObjects];
    [self.tableResult reloadData];
}

- (NSString *)getSearchKey:(int)segment
{
    switch (segment) {
        case 0:
            return @"software";
            break;
        case 1:
            return @"post";
            break;
        case 2:
            return @"blog";
        case 3:
            return @"news";
        default:
            break;
    }
    return nil;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return _results.count;
    }
    return [self.results count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.results count]) {
        return 40.0f;
    }
    return 110.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.results count] > 0) {
        if (indexPath.row >= [self.results count]) {
           
            return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"更多"];
        }else{
            searchResultCell *cell = (searchResultCell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_NORMAL];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"searchResultCell" owner:self options:nil] objectAtIndex:0];
            }
            searchResultModel *searchResult = [self.results objectAtIndex:indexPath.row];
            
            cell.lbl_id.text = searchResult.strObjid;
            cell.lbl_content.text = searchResult.strTitle;
            cell.lbl_content.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:16];
            if (_nTab !=0) {
                cell.lbl_author.text = [NSString stringWithFormat:@"%@ ",searchResult.strAuthor];
                cell.lbl_pubDate.text = [NSString stringWithFormat:@"发表于:%@",searchResult.strPubDate];
            }
            return cell;
        }
    }else{
        return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= self.results.count) {
        if (!_bLoading && !_bLoadOver) {
            [self doSearchWithContent:self.searchBar.text catalog:[self getSearchKey:_nTab]  pageIndex:[self.results count] / 20 pageSize:20];
        }
    }
}

- (void)doSearchWithContent:(NSString *)content catalog:(NSString *)catalog pageIndex:(int)nPageIndex pageSize:(int)nPageSize
{
    _bLoading = true;
    _bLoadOver = false;
    [oschinaTool searchList:content catalog:catalog pageIndex:nPageIndex pageSize:nPageSize
                    success:^(bool b, NSMutableArray *list) {
                        _bLoading = false;
                        if (b) {
                            if ([list count] <20) {
                                _bLoadOver = true;
                            }
                            [self.results addObjectsFromArray:list];
                            
                        }else{
                           _bLoadOver = true;
                        }
                        [self.tableResult reloadData];
    }
                    failure:^(NSString *errMsg) {
                        _bLoading = false;
                        _bLoadOver = true;
                        [self.tableResult reloadData];
                        [oschinaTool showMsgWithTitle:@"提示" Msg:errMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
    }];
    [self.tableResult reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_results release];
    [_searchBar release];
    [_tableResult release];
    [super dealloc];
}
@end
