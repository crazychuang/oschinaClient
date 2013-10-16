//
//  leftSideViewPage.m
//  oschinaClient
//
//  Created by boai on 13-7-18.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "leftSideViewPage.h"
#import "leftSideCell.h"
#import "SettingView.h"
#import "complexPage.h"
#import "queAnswPage.h"
#import "twitterPage.h"
#import  "locateMePage.h"
#import "setUIPage.h"
#import "superPage.h"
#import "mePage.h"
@interface leftSideViewPage ()
@end

@implementation leftSideViewPage
@synthesize arrBusiness = _arrBusiness;
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
    
    
    UIImageView *imgViewBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG"]];
    imgViewBg.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imgViewBg.frame = CGRectMake(00.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imgViewBg];
    [imgViewBg release];
    
    UILabel *lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(-15.0, 0.0f, 320, 60)];
    lbl_title.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:28];
    lbl_title.textAlignment = UITextAlignmentCenter;
    lbl_title.backgroundColor = [UIColor clearColor];
    lbl_title.textColor = [UIColor whiteColor];

    lbl_title.text = @"开源中国";
    [self.view addSubview:lbl_title];
    [lbl_title release];
    
    UIButton *_btnSetting = [[UIButton alloc] initWithFrame:CGRectMake(220, 10.0f, 45.0f, 45.0f)];
    [_btnSetting setImage:[UIImage imageNamed:@"side_setting_icon@2x.png"] forState:UIControlStateNormal];
    [_btnSetting addTarget:self action:@selector(settingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnSetting];
    [_btnSetting release];
    
    _table_list = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 60.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _table_list.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _table_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table_list.delegate = self;
    self.table_list.dataSource = self;
    _table_list.backgroundColor = [UIColor clearColor];
    _table_list.backgroundView = nil;
    [self.view addSubview:_table_list];
    
     _arrBusiness = [[NSArray alloc] initWithObjects:@"综合",@"问答",@"动弹",@"我", @"更多",@"定位",nil];
}

- (void)settingBtnPressed:(id)sender
{
    setUIPage *setUI = [[[setUIPage alloc] initWithNibName:[oschinaTool getXibName:@"setUIPage"] bundle:nil] autorelease];
    [self presentSemiViewController:setUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrBusiness.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    leftSideCell *cell = (leftSideCell *)[tableView dequeueReusableCellWithIdentifier:ID_CELL_BUSINESS_CELL];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"leftSideCell" owner:self options:nil] objectAtIndex:0];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        lineView.frame = CGRectMake(0.0, cell.contentView.frame.size.height - lineView.frame.size.height/2 , cell.contentView.frame.size.width, lineView.frame.size.height);
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell addSubview:lineView];
    }
    cell.lbl_name.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:18];
    cell.lbl_name.text = [_arrBusiness objectAtIndex:indexPath.row];
    cell.imgView_head.image = [UIImage imageNamed:[NSString stringWithFormat:@"leftSide_cell_%d",indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //页面跳转
    switch (indexPath.row) {
        case 0:
        {
            [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                complexPage *complex = [[complexPage alloc] initWithNibName:[oschinaTool getXibName:@"complexPage"] bundle:nil];
                UINavigationController *complexNav = [[UINavigationController alloc] initWithRootViewController:complex];
                self.viewDeckController.centerController = complexNav;
                self.view.userInteractionEnabled = YES;
            }];
        }
            break;
        case 1:
        {
            [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                queAnswPage *queAnsw = [[queAnswPage alloc] initWithNibName:[oschinaTool getXibName:@"queAnswPage"] bundle:nil];
                UINavigationController *queAnswNav = [[UINavigationController alloc] initWithRootViewController:queAnsw];
                self.viewDeckController.centerController = queAnswNav;
                self.view.userInteractionEnabled = YES;
            }];
        }
            break;
        case 2:
        {
            [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                twitterPage *tweetpage = [[twitterPage alloc] initWithNibName:[oschinaTool getXibName:@"twitterPage"] bundle:nil];
                UINavigationController *tweetNav = [[UINavigationController alloc] initWithRootViewController:tweetpage];
                self.viewDeckController.centerController = tweetNav;
                self.view.userInteractionEnabled = YES;
            }];
           
        }
            break;
        case 3:
        {
            [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                mePage *_me = [[[mePage alloc] initWithNibName:[oschinaTool getXibName:@"mePage"]  bundle:nil] autorelease];
                UINavigationController *_meNav = [[UINavigationController alloc] initWithRootViewController:_me];
                [_me.navigationController setNavigationBarHidden:YES];
                self.viewDeckController.centerController = _meNav;
                self.view.userInteractionEnabled = YES;
            }];
        }
            break;
        case 4:
        {
            [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                
                SettingView *_settingView = [[SettingView alloc] init];
            UINavigationController *settingNav = [[[UINavigationController alloc] initWithRootViewController:_settingView] autorelease];
            [_settingView release];_settingView = nil;
                self.viewDeckController.centerController = settingNav;
                self.view.userInteractionEnabled = YES;
            }];
        }
            break;
        case 5:
        {
            [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                
                locateMePage *_locatePage = [[locateMePage alloc] init];
                UINavigationController *locateNav = [[[UINavigationController alloc] initWithRootViewController:_locatePage] autorelease];
                [_locatePage release];_locatePage = nil;
                self.viewDeckController.centerController = locateNav;
                self.view.userInteractionEnabled = YES;
            }];
        }
             break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_table_list release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTable_list:nil];
    [super viewDidUnload];
}
@end
