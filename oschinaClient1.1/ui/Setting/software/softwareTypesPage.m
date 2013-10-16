//
//  softwareTypesPage.m
//  oschinaClient
//
//  Created by boai on 13-6-26.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "softwareTypesPage.h"
#import "oschinaTool.h"
#import "softwareCatalogModel.h"
#import "softwareOptionsPage.h"
#import "softwareModel.h"
@interface softwareTypesPage ()

@end

@implementation softwareTypesPage
@synthesize softTypes = _softTypes;
@synthesize bLoading = _bLoading;
@synthesize bLoadOver = _bLoadOver;
@synthesize nTag = _nTag;
@synthesize strTitle = _strTitle;
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
    
    [self setNavTxt:_strTitle];
    
    [self.table_list setDelegate:self];
    [self.table_list setDataSource:self];
    _bLoadOver = true;
    _bLoading = false;
    _softTypes = [[NSMutableArray alloc] initWithCapacity:2];
    [self doGetSoftwareCatalogs:_nTag];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bLoadOver) {
        return [_softTypes count];
    }
    return [_softTypes count] + 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.softTypes count] >0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_CELL_SOFTWARE_CATALOG_ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID_CELL_SOFTWARE_CATALOG_ID];
        }
        softwareCatalogModel *softwareCatalog = [self.softTypes objectAtIndex:indexPath.row];
        cell.textLabel.text = softwareCatalog.strName;
        cell.textLabel.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:16];
        return cell;
    }else{
         return [oschinaTool getLoadMoreCell:tableView loadOver:_bLoadOver loadOverString:@"没有了" loading:_bLoading loadingString:@"加载中"];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_bLoadOver) {
        softwareCatalogModel *softwareCatalog = [self.softTypes objectAtIndex:indexPath.row];
        if (softwareCatalog && self.nTag == 0) {
            softwareTypesPage *softwareType = [[[softwareTypesPage alloc] initWithNibName:[oschinaTool getXibName:@"softwareTypesPage"] bundle:nil] autorelease];
            
            softwareType.nTag = softwareCatalog.nTag;
            softwareType.strTitle = softwareCatalog.strName;
            [self.navigationController pushViewController:softwareType animated:YES];
        }else{
            softwareOptionsPage *software = [[[softwareOptionsPage alloc] initWithNibName:[oschinaTool getXibName:@"softwareOptionsPage"] bundle:nil] autorelease];
            software.strSearchTag = nil;
            software.nTag = softwareCatalog.nTag;
            software.strTitle = softwareCatalog.strName;
            [self.navigationController pushViewController:software animated:YES];
        }
    }
}

- (void)doGetSoftwareCatalogs:(int)nTag
{
    _bLoading = true;
    _bLoadOver = false;
    [oschinaTool getSoftwareCatalogs:nTag
                             success:^(bool b, NSMutableArray *list) {
                                 _bLoading = false;
                                 _bLoadOver = true;
                                 if (b) {
                                     [self.softTypes addObjectsFromArray:list];
                                 }
                                 [self.table_list reloadData];
                             }
                             failure:^(NSString *errMsg) {
                                 _bLoadOver = true;
                                 _bLoading = false;
                                 [self.table_list reloadData];
                                 [oschinaTool showMsgWithTitle:@"提示" Msg:errMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
                             }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_strTitle release];
    [_table_list release];
    [super dealloc];
}
@end
