//
//  BFNMenuViewController.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYAboutViewController.h"
#import "ZYAccountViewController.h"
#import "ZYSettingViewController.h"
#import "ZYProductViewController.h"
#import "ZYPictureController.h"
#import "ZYCommentViewController.h"
#import "ZYCategoryViewController.h"
#import "ZYLoginViewController.h"
#import "BFNBaseViewController.h"


@interface BFNMenuViewController : BFNBaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UILabel                 *titleLabel;
    UITableView             *menuTableView;
    
    NSIndexPath *selectVCIndexPath;
    
    NSMutableArray *viewControllers;
    NSMutableArray *sysViewControllers;
    
    NSIndexPath *lastSelectIndexPath;
    BOOL isHaveMcmItem;

}
@property(retain, nonatomic)UITableView *menuTableView;
@property(retain, nonatomic)NSMutableArray *tableBasicData;
@property(retain, nonatomic)NSMutableArray *tableSysData;
@property (nonatomic,retain)NSIndexPath *selectVCIndexPath;
@property (nonatomic,retain)NSIndexPath *lastSelectIndexPath;

- (UIViewController*)currentVC;

- (void)reservToHomePage;//注销账号后调用这个方法来恢复默认回到首页

- (void)tryGetNewApplicationRights;//获取新的应用权限


@end
