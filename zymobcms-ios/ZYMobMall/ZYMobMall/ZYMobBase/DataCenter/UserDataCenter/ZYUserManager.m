//
//  ZYUserManager.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYUserManager.h"


@implementation ZYUserManager

+ (void)createUserData
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]==nil) {
        
        NSMutableArray *userList = [NSMutableArray array];
        
        NSData *userData = [ZYUserManager archieveArray:userList];
        
        [[NSUserDefaults standardUserDefaults]setObject:userData forKey:ZY_USER_UDF];
    }
}

+ (void)addNewUser:(ZYUserModel *)newUser
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        
        [ZYUserManager createUserData];
    }
    
    //
    NSData *userData = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSMutableArray *userList = [ZYUserManager unarchieveDataToArray:userData];
    
    if (userList) {
        [userList addObject:newUser];
    }
    
    NSData *reSaveData = [ZYUserManager archieveArray:userList];
    
    [[NSUserDefaults standardUserDefaults]setObject:reSaveData forKey:ZY_USER_UDF];
    
}
+ (void)loginNewUser:(ZYUserModel *)newUser
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        
        [ZYUserManager createUserData];
    }
    
    //
    NSData *userData = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSMutableArray *userList = [ZYUserManager unarchieveDataToArray:userData];
    
    if (![userList containsObject:newUser]) {
        newUser.status = @"1";
        [userList addObject:newUser];
    }else{
        for (ZYUserModel *userItem in userList) {
            
            if ([userItem.userId isEqualToString:newUser.userId]) {
                
                userItem.status = @"1";
            }else{
                userItem.status = @"0";
            }
            
        }
    }
    NSData *reSaveData = [self archieveArray:userList];
    [[NSUserDefaults standardUserDefaults]setObject:reSaveData forKey:ZY_USER_UDF];
}
+ (ZYUserModel *)getCurrentUser
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        
        [ZYUserManager createUserData];
    }
    
    //
    NSData *userData = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSMutableArray *userList = [ZYUserManager unarchieveDataToArray:userData];
    
    for (ZYUserModel *userItem in userList) {
        
        if ([userItem.status isEqualToString:@"1"]) {
            
            return userItem;
            break;
        }
        
    }
    return nil;
}
+ (void)loginOutCurrentUser
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        
        [ZYUserManager createUserData];
    }
    ZYUserModel *cUser = [self getCurrentUser];
    
    //
    NSData *userData = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSMutableArray *userList = [ZYUserManager unarchieveDataToArray:userData];
    
    for (ZYUserModel *userItem in userList) {
        
        if ([userItem.userId isEqualToString:cUser.userId]) {
            
            userItem.status = @"0";
            break;
        }
        
    }
    NSData *reSaveData = [self archieveArray:userList];
    [[NSUserDefaults standardUserDefaults]setObject:reSaveData forKey:ZY_USER_UDF];
}

+ (NSString *)getCurrentUserId
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF]) {
        
        [ZYUserManager createUserData];
    }
    
    //
    NSData *userData = [[NSUserDefaults standardUserDefaults]objectForKey:ZY_USER_UDF];
    NSMutableArray *userList = [ZYUserManager unarchieveDataToArray:userData];
    
    NSString *resultUserId = nil;
    for (ZYUserModel *userItem in userList) {
        
        if ([userItem.status isEqualToString:@"1"]) {
            
            resultUserId = userItem.userId;
        }
        
    }
    return resultUserId;

}

+ (NSData*)archieveArray:(NSArray*)dArray
{
    return [NSKeyedArchiver archivedDataWithRootObject:dArray];
}
+ (NSMutableArray*)unarchieveDataToArray:(NSData*)dData
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:dData];
}
+ (NSData*)archieveDict:(NSDictionary*)dict
{
    return [NSKeyedArchiver archivedDataWithRootObject:dict];
}
+ (NSMutableDictionary*)unarchieveToDict:(NSData*)dData
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:dData];
}

+ (BOOL)getUserActiveRecordState
{
    return YES;
}
@end
