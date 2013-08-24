//
//  ZYFormValidate.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYFormValidate : NSObject
+ (BOOL)validateLoginName:(NSString*)loginName;
+ (BOOL)validatePassword:(NSString*)password;
+ (BOOL)validateRigistPassword:(NSString*)password withCheck:(NSString*)cPassword;

@end
