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

+ (NSString*)getCurrentUserId
{
    return @"1";
}
+ (BOOL)getUserActiveRecordState
{
    return YES;
}
@end
