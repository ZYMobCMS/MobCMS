//
//  ZYXMPPClientAppDelegate.h
//  ZYXMPPClient
//
//  Created by barfoo2 on 13-9-5.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYXMPPClientViewController;

@interface ZYXMPPClientAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ZYXMPPClientViewController *viewController;

@end
