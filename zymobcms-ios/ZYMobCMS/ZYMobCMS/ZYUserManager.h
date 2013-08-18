//
//  ZYUserManager.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZY_USER_UDF @"ZY_USER_UDF"

@interface ZYUserManager : NSObject
{
    
}

+ (void)userLoginWithName:(NSString*)loginName withPassword:(NSString*)password;

+ (void)userRigistWithName:(NSString*)loginName withPassword:(NSString*)password;

+ (void)loginOutUserWithUserName:(NSString*)loginName;

+ (NSString *)getCurrentUserId;

+ (NSString*)getCurrentUserLoginNameById:(NSString*)userId;

+ (BOOL)userIsLogined;

@end
