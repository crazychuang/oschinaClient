//
//  setUIPage.m
//  oschinaClient
//
//  Created by boai on 13-8-9.
//  Copyright (c) 2013年 bravetorun. All rights reserved.
//

#import "setUIPage.h"
#import "aboutMePage.h"
@interface setUIPage ()

@end

@implementation setUIPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)configureNavViews
{
    switch ([oschinaSingleton sharedInstance].nSkin_Nav) {
        case TAG_SKIN_DAYTIME:
        {
            [_img_nav setImage:[UIImage imageNamed:@"navBg"]];
        }
            break;
        case TAG_SKIN_NIGHT:
        {
            [_img_nav setImage:[UIImage imageNamed:@"head_background"]];
        }
            break;
        default:
            break;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arr = [[NSArray alloc] initWithObjects:@"夜间模式",@"清除缓存",@"我的资料", @"更换背景",nil];
    [_table_list setDelegate:self];
    [_table_list setDataSource:self];
    [_table_list setBackgroundView:nil];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            break;
        case 1:
        {
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            [oschinaTool showToast:@"清除成功" onView:self.view dimBackground:YES];
        }
            break;
        case 2:
        {
            aboutMePage *about = [[[aboutMePage alloc] initWithNibName:[oschinaTool getXibName:@"aboutMePage"] bundle:nil] autorelease];
            [self presentModalViewController:about animated:YES];
        }
            break;
        case 3:
        {

            WXJChangeBgView *changeView = [[WXJChangeBgView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
            changeView.delegate = self;
            [self.view addSubview:changeView];
            [changeView fadeIn];
            [changeView release];
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)changeBgView:(WXJChangeBgView *)changeBgView didClickBtnAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [oschinaSingleton sharedInstance].nSkin_BG = TAG_SKIN_BLUE;
        }
            break;
        case 1:
        {
            [oschinaSingleton sharedInstance].nSkin_BG = TAG_SKIN_RED;
        }
            break;
        case 2:
        {
            [oschinaSingleton sharedInstance].nSkin_BG = TAG_SKIN_BLACK;
        }
            break;
        default:
            break;
    }
    
     [[NSNotificationCenter defaultCenter] postNotificationName:TAG_CHANGE_BG_THEME_NOT object:nil];
    [changeBgView fadeOut];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_SET_UI"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL_SET_UI"];
    }
    
    cell.textLabel.font = [UIFont fontWithName:FONT_NAME_HUA_KANG_SHAO_NV_W5 size:16];
    cell.textLabel.text = [_arr objectAtIndex:indexPath.section];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.accessoryView = _modelSwitch;
        if ([oschinaSingleton sharedInstance].nSkin_Nav == TAG_SKIN_DAYTIME) {
            [_modelSwitch setOn:NO];
        }else{
            [_modelSwitch setOn:YES];
        }
        cell.accessoryType = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)closeThePage:(id)sender {
     [self dismissSemiModalViewWithCompletion:nil];
}
- (void)dealloc {
    [_table_list release];
    [_modelSwitch release];
    [_img_nav release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTable_list:nil];
    [self setModelSwitch:nil];
    [self setImg_nav:nil];
    [super viewDidUnload];
}

- (IBAction)change:(id)sender {
    
    
    UISwitch *_switch = (UISwitch *)sender;
    if (_switch.isOn) {
        [[oschinaSingleton sharedInstance] setNSkin_Nav:TAG_SKIN_NIGHT];
    }else{
        [[oschinaSingleton sharedInstance] setNSkin_Nav:TAG_SKIN_DAYTIME];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:TAG_CHANGE_NAV_THEME_NOT object:nil];
}
@end
