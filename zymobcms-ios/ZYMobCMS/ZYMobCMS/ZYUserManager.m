//
//  ZYUserManager.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYUserManager.h"

@implementation ZYUserManager


+ (NSString*)getCurrentUserId
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSString *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"status"]boolValue]) {
            
            userResult = [userItem objectForKey:@"id"];
            break;
        }
        
    }
    return userResult;
}

+ (NSString*)getCurrentUserLoginName
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSString *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"status"]boolValue]) {
            
            userResult = [userItem objectForKey:@"login_name"];
            break;
        }
        
    }
    return userResult;
}

+ (BOOL)loginOutThisUserById:(NSString*)userId
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return NO;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    BOOL userResult = NO;
    for (NSMutableDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"id"]isEqualToString:userId]) {
            
            [userItem setObject:@"0" forKey:@"status"];
            userResult = YES;
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
    
    return userResult;
}

+ (BOOL)loginOutThisUserByLoginName:(NSString*)loginName
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return NO;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    BOOL userResult = NO;
    for (NSMutableDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"login_name"]isEqualToString:loginName]) {
            
            [userItem setObject:@"0" forKey:@"status"];
            userResult = YES;
            
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
    
    return userResult;
}

+ (BOOL)loginThisUserById:(NSString*)userId
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return NO;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    BOOL userResult = NO;
    for (NSMutableDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"id"]isEqualToString:userId]) {
            
            [userItem setObject:@"1" forKey:@"status"];
            userResult = YES;
            
        }else{
            [userItem setObject:@"0" forKey:@"status"];
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
    
    return userResult;

}

+ (BOOL)loginThisUserByLoginName:(NSString*)loginName
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return NO;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    BOOL userResult = NO;
    for (NSMutableDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"login_name"]isEqualToString:loginName]) {
            
            [userItem setObject:@"1" forKey:@"status"];
            userResult = YES;
            
        }else{
            [userItem setObject:@"0" forKey:@"status"];
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
    
    return userResult;
}

+ (NSString*)getCurrentUserLoginNameById:(NSString *)userId
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSString *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"id"]isEqualToString:userId]) {
            
            userResult = [userItem objectForKey:@"login_name"];
            break;
        }
        
    }
    return userResult;
}

+ (void)saveLoginUser:(NSDictionary *)userDict
{
    [ZYUserManager saveLoginUser:userDict loginState:NO];
}

+ (void)saveLoginUser:(NSDictionary *)userDict loginState:(BOOL)state
{
    NSMutableArray *userList = nil;
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        
        userList = [NSMutableArray array];
    }else{
        userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    }
    
    NSMutableDictionary *newUser = [NSMutableDictionary dictionaryWithDictionary:userDict];
    [newUser setObject:[NSString stringWithFormat:@"%d",state] forKey:@"status"];
    [userList addObject:newUser];
    [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
}

+ (NSDictionary*)getUserDictWithLoginName:(NSString *)loginName
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSDictionary *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"login_name"]isEqualToString:loginName]) {
            
            userResult = userItem;
            break;
        }
        
    }
    return userResult;
}

+ (NSDictionary*)getUserDictWithUserId:(NSString *)userId
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSDictionary *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"id"]isEqualToString:userId]) {
            
            userResult = userItem;
            break;
        }
        
    }
    return userResult;
}

+ (BOOL)userIsLogined
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return NO;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    BOOL userResult = NO;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"status"]boolValue]) {
            
            userResult = YES;
            break;
        }
        
    }
    return userResult;
}

@end
