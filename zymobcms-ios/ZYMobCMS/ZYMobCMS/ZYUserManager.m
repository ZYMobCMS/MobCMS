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
    NSLog(@"userList --->%@",userList);
    NSString *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"status"]boolValue]) {
            
            userResult = [userItem objectForKey:@"id"];
            break;
        }
        
    }
    NSLog(@"current UserId--->%@",userResult);
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
        
        NSMutableDictionary *newUser = [NSMutableDictionary dictionaryWithDictionary:userDict];
        [newUser setObject:[NSString stringWithFormat:@"%d",state] forKey:@"status"];
        [newUser setObject:@"1" forKey:ZY_USER_ACTIVE_OPEN_UDF];
        [userList addObject:newUser];
        [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
        
    }else{
        userList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]] ;
        
        BOOL userExist = NO;
        for (int i=0; i<userList.count; i++) {
            
            NSDictionary *userItem = [userList objectAtIndex:i];
            NSMutableDictionary *newUser = [NSMutableDictionary dictionaryWithDictionary:userItem];
            
            if ([[newUser objectForKey:@"login_name"]isEqualToString:[userDict objectForKey:@"login_name"]]) {
                [newUser setObject:@"1" forKey:@"status"];
                [userList replaceObjectAtIndex:i withObject:newUser];
                userExist = YES;
                break;
            }
        }
        if (!userExist) {
            NSMutableDictionary *newUser = [NSMutableDictionary dictionaryWithDictionary:userDict];
            [newUser setObject:[NSString stringWithFormat:@"%d",state] forKey:@"status"];
            [newUser setObject:@"1" forKey:ZY_USER_ACTIVE_OPEN_UDF];
            [userList addObject:newUser];
        }
        [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
        return;
    }
    
}

+ (NSDictionary*)getUserDictWithLoginName:(NSString *)loginName
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]];
    NSDictionary *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"login_name"]isEqualToString:loginName]) {
            
            userResult = userItem;
            break;
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
    return userResult;
}

+ (NSDictionary*)getUserDictWithUserId:(NSString *)userId
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]];
    NSDictionary *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"id"]isEqualToString:userId]) {
            
            userResult = userItem;
            break;
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userList forKey:ZY_USER_UDF];
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

+ (void)loginOutCurrentUser
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return;
    }
    
    NSArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSMutableArray *userMutil = [NSMutableArray arrayWithArray:userList];
    for (int i=0;i<userMutil.count;i++) {
        
        NSDictionary *userItem = [userList objectAtIndex:i];
        NSMutableDictionary *newUser = [NSMutableDictionary dictionaryWithDictionary:userItem];
        if ([[newUser objectForKey:@"status"]boolValue]) {
            
            [newUser setObject:@"0" forKey:@"status"];
            
            [userMutil replaceObjectAtIndex:i withObject:newUser];
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userMutil forKey:ZY_USER_UDF];
}

+ (void)changeUserActiveOpenState:(BOOL)state
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return;
    }
    
    NSArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSMutableArray *userMutil = [NSMutableArray arrayWithArray:userList];
    for (int i=0;i<userMutil.count;i++) {
        
        NSDictionary *userItem = [userList objectAtIndex:i];
        NSMutableDictionary *newUser = [NSMutableDictionary dictionaryWithDictionary:userItem];
        if ([[newUser objectForKey:@"status"]boolValue]) {
            
            [newUser setObject:[NSString stringWithFormat:@"%d",state] forKey:ZY_USER_ACTIVE_OPEN_UDF];
            
            [userMutil replaceObjectAtIndex:i withObject:newUser];
        }
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:userMutil forKey:ZY_USER_UDF];
}

+ (BOOL)getUserActiveRecordState
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        return nil;
    }
    
    NSMutableArray *userList = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSLog(@"userList --->%@",userList);
    NSString *userResult = nil;
    for (NSDictionary *userItem in userList) {
        
        if ([[userItem objectForKey:@"status"]boolValue]) {
            
            userResult = [userItem objectForKey:ZY_USER_ACTIVE_OPEN_UDF];
            break;
        }
        
    }
    NSLog(@"current UserId--->%@",userResult);
    return [userResult boolValue];
}

@end
