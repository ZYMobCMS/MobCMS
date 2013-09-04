//
//  ZYUserManager.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYUserModel.h"

#define ZY_USER_UDF @"ZY_USER_UDF"
#define ZY_USER_ACTIVE_OPEN_UDF @"user_active_open"

@interface ZYUserManager : NSObject

+ (void)addNewUser:(ZYUserModel *)newUser;
+ (void)removeUser:(ZYUserModel *)user;
+ (void)loginOutCurrentUser;
+ (void)changeUserActiveSettingState:(BOOL)state;
+ (ZYUserModel*)getCurrentUser;
+ (BOOL)isCurrentUserLogined;
+ (void)loginNewUser:(ZYUserModel*)newUser;
+ (NSString*)getCurrentUserId;
+ (BOOL)getUserActiveRecordState;

@end
