//
//  userBlogsPage.m
//  oschinaClient
//
//  Created by boai on 13-7-11.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "userBlogsPage.h"
@interface userBlogsPage ()
@end
@implementation userBlogsPage
@synthesize arrblogs = _arrblogs;
@synthesize bLoading = _bLoading;
@synthesize bLoadOver = _bLoadOver;
@synthesize strAuthorID = _strAuthorID;
@synthesize strUID = _strUID;
@synthesize strAuthor = _strAuthor;

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
    [self setNavTxt:_strAuthor];
    _bLoading = false;
    _bLoadOver = true;
    self.arrblogs = [[NSMutableArray alloc] initWithCapacity:2];
    [self.table_list setDelegate:self];
    [self.table_list setDataSource:self];
    
    [self doGetMyBlogs:[self.strAuthorID intValue] pageIndex:_arrblogs.count / 20 pageSize:20 UID:[self.strUID intValue] ];
    [self te];
}


-(void)te
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
        [fontNames release];
    }
    [familyNames release];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return _arrblogs.count;
    }
    return _arrblogs.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= _arrblogs.count) {
        return 40.0f;
    }
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrblogs.count) {
        if (indexPath.row >= _arrblogs.count) {
             return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"更多"];
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_CELL_MY_BLOG];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID_CELL_MY_BLOG];
            }
            blogModel *model = [_arrblogs objectAtIndex:indexPath.row];
            cell.textLabel.text = model.strTitle;
            cell.textLabel.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:14];
            cell.detailTextLabel.text = model.strAuthorName;
            return cell;
        }
    }else{
        return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)doGetMyBlogs:(int)authorUID pageIndex:(int)nPageIndex pageSize:(int)nPageSize UID:(int)uid
{
    [oschinaTool getMyBlogs:authorUID pageIndex:nPageIndex pageSize:nPageSize UID:uid
                    success:^(bool b, NSMutableArray *list) {
                        _bLoading = false;
                        if (b) {
                            if (list.count < 20) {
                                _bLoadOver = true;
                            }
                            [self.arrblogs addObjectsFromArray:list];
                        }else{
                            _bLoadOver = true;
                            if (!_arrblogs.count) {
                                [oschinaTool showMsgWithTitle:@"提示" Msg:@"此用户未发表博客" delegate:nil cancelBtn:@"确定" otherBtn:nil];
                            }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_arrblogs release];
    [_strAuthorID release];
    [_table_list release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTable_list:nil];
    [super viewDidUnload];
}
@end
