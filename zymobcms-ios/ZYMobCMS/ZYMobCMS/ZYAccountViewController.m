//
//  ZYAccountViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYAccountViewController.h"
#import "ZYMyCommentViewController.h"
#import "ZYMyFavoriteViewController.h"
#import "ZYLoginViewController.h"
#import "ZYButtonCell.h"
#import "ZYSwitchCell.h"
#import "ZYShareSettingViewController.h"
#import "ZYUserInfoCell.h"

@interface ZYAccountViewController ()

@end

@implementation ZYAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    [sourceArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    sourceArray = [[NSMutableArray alloc]init];
    [sourceArray addObject:@"我的评论"];
    [sourceArray addObject:@"我的收藏"];
    [sourceArray addObject:@"分享设置"];
    [sourceArray addObject:@"是否分享我的活动"];
    
    
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44) style:UITableViewStyleGrouped];
    UIView *tableBack = [[UIView alloc]initWithFrame:CGRectMake(0,0,listTable.frame.size.width,listTable.frame.size.height)];
    tableBack.backgroundColor = [UIColor whiteColor];
    listTable.backgroundView = tableBack;
    [tableBack release];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];
    
    //logo header
    ZYPullHeaderView *headView = [[ZYPullHeaderView alloc]
                                  initWithFrame:
                                  CGRectMake(0.0f, 0.0f - listTable.bounds.size.height, self.view.frame.size.width,listTable.bounds.size.height)];
    [listTable addSubview:headView];
    [headView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return [sourceArray count];
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else{
        return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"UserInfoCell";
        ZYUserInfoCell *cell = (ZYUserInfoCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (!cell) {
            cell = [[[ZYUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;

    }else if (indexPath.section == 1){
        if (indexPath.row!=sourceArray.count-1) {
            static NSString *CellIdentifier = @"NormalCell";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (!cell) {
                cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                UIImageView *cellNormalBack = [[UIImageView alloc]init];
                cellNormalBack.backgroundColor = [BFUitils rgbColor:212 green:212 blue:212];
                cell.selectedBackgroundView = cellNormalBack;
                [cellNormalBack release];
            }
            cell.textLabel.text = [sourceArray objectAtIndex:indexPath.row];
            
            return cell;
        }else{
            static NSString *CellIdentifier = @"Cell";
            ZYSwitchCell *cell = (ZYSwitchCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            // Configure the cell...
            if (!cell) {
                cell = [[[ZYSwitchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setTapSwitchAction:^(BOOL switchState) {
                    [ZYUserManager changeUserActiveOpenState:switchState];
                }];
            }
            [cell setTitle:[sourceArray objectAtIndex:indexPath.row]];
            
            return cell;
        }
        
    }else{
        static NSString *CellIdentifier = @"ButtonCell";
        ZYButtonCell *cell = (ZYButtonCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[ZYButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withTapOnBtn:^{
                [self loginOutCurrentUser];
            }]autorelease];
        }
        [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        [cell.actionBtn setTitle:@"注销当前账号" forState:UIControlStateNormal];
        
        return cell;
        
    }
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                ZYMyCommentViewController *commentVC = [[ZYMyCommentViewController alloc]init];
                commentVC.mainTitle = [sourceArray objectAtIndex:indexPath.row];
                [ZYMobCMSUitil setBFNNavItemForReturn:commentVC];
                [self.navigationController pushViewController:commentVC animated:YES];
                [commentVC refresh];
                [commentVC release];
            }
                break;
            case 1:
            {
                ZYMyFavoriteViewController *favoriteVC = [[ZYMyFavoriteViewController alloc]init];
                favoriteVC.mainTitle = [sourceArray objectAtIndex:indexPath.row];
                [ZYMobCMSUitil setBFNNavItemForReturn:favoriteVC];
                [self.navigationController pushViewController:favoriteVC animated:YES];
                [favoriteVC release];
                [favoriteVC setNavigationControllerForSubViewControllers:self.navigationController];
            }
                break;
            case 2:
            {
                ZYShareSettingViewController *shareVC = [[ZYShareSettingViewController alloc]init];
                shareVC.mainTitle = [sourceArray objectAtIndex:indexPath.row];
                [ZYMobCMSUitil setBFNNavItemForReturn:shareVC];
                [self.navigationController pushViewController:shareVC animated:YES];
                [shareVC release];
            }
                break;
            default:
                break;
        }

    }else{
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loginOutCurrentUser
{
    [ZYUserManager loginOutCurrentUser];
    [[NSNotificationCenter defaultCenter]postNotificationName:ZYCMS_LOGIN_OUT_SUCCESS_NOTI object:nil];
    
    ZYMobCMSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    ZYLoginViewController *loginVC = [[ZYLoginViewController alloc]init];
    loginVC.mainTitle = @"账号管理";
    [loginVC setSuccessLoginAction:^{
        ZYMobCMSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        
        ZYAccountViewController *accoutVC = [[ZYAccountViewController alloc]init];
        accoutVC.mainTitle = @"账号管理";
        [ZYMobCMSUitil setBFNNavItemForMenu:accoutVC];
        
        appDelegate.rootViewController.detailViewController = nil;
        
        UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:accoutVC];
        [accoutVC release];
        
        if ([BFUitils isIOSVersionOver5]) {
            [newNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
        }else {
            [newNav.navigationBar drawRect:newNav.navigationBar.frame];
        }
        newNav.view.frame = appDelegate.rootViewController.view.frame;
        appDelegate.rootViewController.detailViewController = newNav;
        [newNav release];
        
        [appDelegate hiddenMaster];
        [BFAnimationHelper animationBasicFadeView:appDelegate.rootViewController.view duration:0.3];

    }];
    [ZYMobCMSUitil setBFNNavItemForMenu:loginVC];
    
    appDelegate.rootViewController.detailViewController = nil;
    
    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [loginVC release];
    
    if ([BFUitils isIOSVersionOver5]) {
        [newNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
    }else {
        [newNav.navigationBar drawRect:newNav.navigationBar.frame];
    }
    newNav.view.frame = appDelegate.rootViewController.view.frame;
    appDelegate.rootViewController.detailViewController = newNav;
    [newNav release];
    [appDelegate hiddenMaster];
    
    [BFAnimationHelper animationBasicFadeView:appDelegate.rootViewController.view duration:0.3];

    
}


@end
