//
//  ZYMobCMSAppDelegate.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-7-27.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMenuViewController.h"
#import "ZTMenuViewController.h"
#import "ZYMenuViewController.h"
#import "IRSlidingSplitViewController.h"
#import "BFNMenuViewController.h"

#define useAppkey @"5219554b56240b5ade061e1f"
#define UmengAppKey @"5219554b56240b5ade061e1f"
#define MoGo_ID_IPhone @"9d12f0df93af44e38f5ca7fcc251b4d6"

#import "AdMoGoSplashAds.h"
#import "AdMoGoSplashAdsDelegate.h"

@interface ZYMobCMSAppDelegate : UIResponder <UIApplicationDelegate,AdMoGoSplashAdsDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)STMenuViewController *sMenuController;
@property (nonatomic,strong)ZYMenuViewController *zMenuController;
@property (nonatomic,strong)BFNMenuViewController *bMenuController;
@property (nonatomic,strong)IRSlidingSplitViewController *rootViewController;

- (void)showMaster;
- (void)hiddenMaster;
@end
