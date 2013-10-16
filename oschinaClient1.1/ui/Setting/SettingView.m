//
//  SettingView.m
//  oschinaClient
//
//  Created by boai on 13-5-31.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "SettingView.h"
#import "SettingModel.h"
#import "config.h"
#import "oschinaTool.h"
#import "TBXML.h"
#import "NdUncaughtExceptionHandler.h"
#import "loginPage.h"
#import "SearchPage.h"
#import "softwarePage.h"
#import "aboutPage.h"
#import "myInfoPage.h"
#import <QuartzCore/QuartzCore.h>

#define TAG_ALERT_BASE          0
#define TAG_ALERT_UPDATE_APP    TAG_ALERT_BASE + 1
@interface SettingView ()

@end

@implementation SettingView
@synthesize setting = _settings;
@synthesize settingInSection = _settingInSection;
@synthesize tableSetting = _tableSetting;
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
    [self setNavTxt:@"设置"];
    
    
    self.tableSetting = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 30) style:UITableViewStyleGrouped];
    [self.tableSetting setBackgroundColor:[UIColor clearColor]];
    [self.tableSetting setBackgroundView:nil];
    
    [self.tableSetting setDelegate:self];
    [self.tableSetting setDataSource:self];

    self.tableSetting.separatorColor = [UIColor grayColor];
    [self.view addSubview:self.tableSetting];
    
    self.settingInSection = [[NSMutableDictionary alloc] initWithCapacity:3];
    bool bLogin = [[config instance] isCookie];
    NSArray *first = [[NSArray alloc] initWithObjects:
                      [[SettingModel alloc] initWith:bLogin ? @"我的资料(收藏/关注/粉丝)" : @"登陆" img:@"account" tag:1 title2:nil],
                      [[SettingModel alloc] initWith:@"注销" img:@"exit" tag:2 title2:nil],nil];
    NSArray *second = [[NSArray alloc] initWithObjects:
                       [[SettingModel alloc] initWith:@"软件" img:@"software" tag:3 title2:nil],
                       [[SettingModel alloc] initWith:@"搜索" img:@"search" tag:4 title2:nil],nil];
    
    NSArray *third = [[NSArray alloc] initWithObjects:
                     [[SettingModel alloc] initWith:@"意见反馈" img:@"feedback" tag:5 title2:nil],
                     [[SettingModel alloc] initWith:@"官方微博" img:@"weibo" tag:6 title2:nil],
                     [[SettingModel alloc] initWith:@"关于我们" img:@"logo" tag:7 title2:nil],
                     [[SettingModel alloc] initWith:@"检查更新" img:@"setting" tag:8 title2:nil],
                     [[SettingModel alloc] initWith:@"给我评分" img:@"rating" tag:9 title2:nil],
                      nil];
    [self.settingInSection setObject:first forKey:@"账号"];
    [self.settingInSection setObject:second forKey:@"反馈"];
    [self.settingInSection setObject:third forKey:@"关于"];
    self.setting = [[NSArray alloc] initWithObjects:@"账号", @"反馈",@"关于",nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self refresh];
}

- (void)refresh
{
    NSArray *first = [self.settingInSection objectForKey:@"账号"];
    SettingModel *firstLogin = [first objectAtIndex:0];
    firstLogin.strTitle = [config instance].isCookie ? @"我的资料(收藏/关注/粉丝)" : @"登陆";
    [self.tableSetting reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger nSection = [indexPath section];
    NSString *key = [_settings objectAtIndex:nSection];
    NSArray *sets = [_settingInSection objectForKey:key];
    SettingModel *action = [sets objectAtIndex:[indexPath row]];
    switch (action.nTag) {
        case 1:
        {
            if ([config instance].isCookie) {
                myInfoPage *infoPage = [[[myInfoPage alloc] initWithNibName:[oschinaTool getXibName:@"myInfoPage"] bundle:nil] autorelease];
                [self.navigationController pushViewController:infoPage animated:YES];
            }else{
                loginPage *login = [[[loginPage alloc] initWithNibName:[oschinaTool getXibName:@"loginPage"] bundle:nil] autorelease];
                [self.navigationController pushViewController:login animated:YES];
            }
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            softwarePage *softPage = [[[softwarePage alloc] initWithNibName:[oschinaTool getXibName:@"softwarePage"] bundle:nil] autorelease];
            [self.navigationController pushViewController:softPage animated:YES];
        }
            break;
        case 4:
        {
            SearchPage *searchPage = [[[SearchPage alloc] initWithNibName:[oschinaTool getXibName:@"SearchPage"] bundle:nil] autorelease];
            [self.navigationController pushViewController:searchPage animated:YES];
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            aboutPage *about = [[[aboutPage alloc] initWithNibName:[oschinaTool getXibName:@"aboutPage"] bundle:nil] autorelease];
            [self.navigationController pushViewController:about animated:YES];
        }
            break;
        case 8:
        {
            [self checkVersionNeedUpdate];
        }
            break;
        case 9:
        {
            
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_settings count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [_settings objectAtIndex:section];
    NSArray *set = [_settingInSection objectForKey:key];
    return  [set count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger nsection = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = [_settings objectAtIndex:nsection];
    NSArray *sets = [_settingInSection objectForKey:key];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SETTINGTABLEID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SETTINGTABLEID];
    }
    SettingModel *model = [sets objectAtIndex:row];
    cell.textLabel.text = model.strTitle;
    cell.textLabel.font = [UIFont fontWithName:@"DFShaoNvW5-GB" size:16];
    cell.imageView.image = [UIImage imageNamed:model.strImg];
    cell.tag = model.nTag;
    return cell;
}

- (void)checkVersionNeedUpdate
{
    [oschinaTool checkVersionNeedUpdate:URL_OSCHINA_APP_VERSION
                                success:^(bool bNeedUpdate,NSString *strlastestV) {
                                    [oschinaTool showMsgWithTitle:@"提示" Msg:bNeedUpdate ? @"检查到最新版本,请更新":@"已是最新版本，不需要更新" delegate:self cancelBtn:@"确定" otherBtn:@"取消" tag:bNeedUpdate ? TAG_ALERT_UPDATE_APP : TAG_ALERT_BASE];
        
    }
                                failure:^(NSString *strMsg) {
                                    [oschinaTool showMsgWithTitle:@"提示" Msg:strMsg delegate:nil cancelBtn:@"确定" otherBtn:nil];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case TAG_ALERT_BASE:
            break;
        case TAG_ALERT_UPDATE_APP:
        {
            if (buttonIndex == 0) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_UPDATE_APP(APPID)]];
            }
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

- (void)dealloc
{
    
    [super dealloc];
}

- (void)viewDidUnload
{
    
    [super dealloc];
}


@end
