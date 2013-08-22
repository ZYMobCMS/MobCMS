//
//  ZYMobCMSAdminAppDelegate.h
//  ZYMobCMSAdmin
//
//  Created by barfoo2 on 13-8-22.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYLoginViewController.h"

@class ZYMobCMSAdminViewController;

@interface ZYMobCMSAdminAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ZYMobCMSAdminViewController *viewController;
@property (nonatomic,retain)ZYLoginViewController *loginViewController;

@end
