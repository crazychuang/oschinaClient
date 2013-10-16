//
//  myInfoPage.m
//  oschinaClient
//
//  Created by boai on 13-7-16.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "myInfoPage.h"
#import "head_name_Cell.h"
#import "infoCell.h"
@interface myInfoPage ()

@end

@implementation myInfoPage
@synthesize user = _user;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 4;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 100.0f;
            break;
        case 1:
        case 2:
        case 3:
            return 50.0f;
            break;
        default:
            break;
    }
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            head_name_Cell *headCell = (head_name_Cell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_HEAD_NAME_CELL];
            if (!headCell) {
                headCell = [[[NSBundle mainBundle] loadNibNamed:@"head_name_Cell" owner:self options:nil] objectAtIndex:0];
            }
            headCell.lbl_name.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:15];
            headCell.lbl_name.text = [oschinaSingleton sharedInstance].user.strUser;
            return headCell;
        }
            break;
        case 1:
        case 2:
        case 3:
        {
            infoCell *Cell = (infoCell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_INFO_CELL];
            if (!Cell) {
                Cell = [[[NSBundle mainBundle] loadNibNamed:@"infoCell" owner:self options:nil] objectAtIndex:0];
            }
            Cell.lbl_label.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:15];
            Cell.lbl_content.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:15];
            if (indexPath.section == 1) {
                switch (indexPath.row) {
                    case 0:
                    {
                        Cell.lbl_label.text = @"收藏";
                        Cell.lbl_content.text = [ NSString stringWithFormat:@"%d",[oschinaSingleton sharedInstance].user.nScore];
                    }
                        break;
                    default:
                        break;
                }
            }else if (indexPath.section == 2){
                switch (indexPath.row) {
                    case 0:
                    {
                        Cell.lbl_label.text = @"粉丝";
                        Cell.lbl_content.text = [ NSString stringWithFormat:@"%d",[oschinaSingleton sharedInstance].user.nFans];
                    }
                        break;
                    case 1:
                    {
                        Cell.lbl_label.text = @"关注";
                        
                    }
                    default:
                        break;
                }
            }else if (indexPath.section == 3){
                switch (indexPath.row) {
                    case 0:
                    {
                        Cell.lbl_label.text = @"加入时间";
                    }
                        break;
                    case 1:
                    {
                        Cell.lbl_label.text = @"所在地区";
                        Cell.lbl_content.text = [oschinaSingleton sharedInstance].user.strLocation;
                        
                    }
                        break;
                    case 2:
                    {
                        Cell.lbl_label.text = @"发布平台";
                       
                    }
                        break;
                    case 3:
                    {
                        Cell.lbl_label.text = @"专长领域";
                    }
                        break;
                    default:
                        break;
                }
            }
            return Cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.table_list setDataSource:self];
    [self.table_list setDelegate:self];
    [self setNavTxt:@"我的资料"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_table_list release];
    [_user release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTable_list:nil];
    [super viewDidUnload];
}
@end
