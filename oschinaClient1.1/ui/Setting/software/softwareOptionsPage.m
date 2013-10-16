//
//  softwareOptionsPage.m
//  oschinaClient
//
//  Created by boai on 13-6-27.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "softwareOptionsPage.h"

@interface softwareOptionsPage ()

@end

@implementation softwareOptionsPage
@synthesize softwares = _softwares;
@synthesize bLoading = _bLoading;
@synthesize bLoadOver = _bLoadOver;
@synthesize strSearchTag = _strSearchTag;
@synthesize nTag = _nTag;
@synthesize strTitle = _strTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setNavTxt:_strTitle];
    
    _bLoadOver = true;
    _bLoading = false;
    self.softwares = [[NSMutableArray alloc] initWithCapacity:5];
    [self.table_list setDelegate:self];
    [self.table_list setDataSource:self];
    [self reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return _softwares.count;
    }
    return [_softwares count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.softwares count]) {
        return 40.0f;
    }
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.softwares count] >0) {
        if (indexPath.row >= [self.softwares count]) {
            return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"更多"];
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_CELL_SOFTWARE_CELL];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID_CELL_SOFTWARE_CATALOG_ID];
            }
            softwareModel *softModel = [self.softwares objectAtIndex:indexPath.row];
            cell.textLabel.text = softModel.strName;
            cell.detailTextLabel.text = softModel.strDesc;
            cell.textLabel.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:16];
            return cell;
        }
    }else{
        return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= [self.softwares count]) {
        if (!_bLoading && !_bLoadOver) {
            [self doGetSoftwareList:self.strSearchTag tag:_nTag pangeIndex:[self.softwares count] / 20 pageSize:20];
        }
    }else{
    }
}



- (void)doGetSoftwareList:(NSString *)strSearchTag tag:(int)nTag pangeIndex:(int)nPageIndex pageSize:(int)nPageSize
{
    _bLoading = true;
    _bLoadOver = false;
    [oschinaTool getSoftwareList:strSearchTag tag:nTag pageIndex:nPageIndex pageSize:nPageSize
                         success:^(bool b, NSMutableArray *list) {
                             _bLoading = false;
                             if (b) {
                                 if ([list count] < 20) {
                                     _bLoadOver = true;
                                 }
                                 [self.softwares addObjectsFromArray:list];
                                 
                             }else{
                                 
                             }
                             [self.table_list reloadData];
    }
                         failure:^(NSString *errMsg) {
                             _bLoadOver = true;
                             _bLoading = false;
                             [self.table_list reloadData];
                             [oschinaTool showMsgWithTitle:@"提示" Msg:errMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
    }];
    [self.table_list reloadData];
}

- (void)reloadData
{
    [self clearData];
    [self doGetSoftwareList:self.strSearchTag tag:_nTag pangeIndex:[self.softwares count] / 20 pageSize:20];
}

- (void)clearData
{
    if (self.softwares && [self.softwares count] >0) {
        [self.softwares removeAllObjects];
    }
    _bLoading = false;
    _bLoadOver = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_strTitle release];
    [_strSearchTag release];
    [_softwares release];
    [_table_list release];
    [super dealloc];
}
@end
