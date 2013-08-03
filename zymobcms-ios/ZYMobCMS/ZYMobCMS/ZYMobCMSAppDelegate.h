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

@interface ZYMobCMSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)STMenuViewController *sMenuController;
@property (nonatomic,strong)ZYMenuViewController *zMenuController;

@end
