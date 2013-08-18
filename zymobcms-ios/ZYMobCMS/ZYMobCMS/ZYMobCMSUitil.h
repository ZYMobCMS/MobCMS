//
//  ZYMobCMSUitil.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYMobCMSUitil : NSObject
+ (void)setNavItem:(UIViewController *)viewObj;
+ (void)setBFNNavItemForMenu:(UIViewController *)viewObj;

+ (void)setBFNNavItemForReturn:(UIViewController *)viewObj;
+ (NSString*)replaceNBSP:(NSString*)sourceString;
@end
