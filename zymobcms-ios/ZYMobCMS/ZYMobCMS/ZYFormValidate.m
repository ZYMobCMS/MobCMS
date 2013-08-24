//
//  ZYFormValidate.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYFormValidate.h"

@implementation ZYFormValidate
+ (BOOL)validateLoginName:(NSString *)loginName
{
    if (loginName==nil||[loginName isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"登录名不为空"];
        return NO;
    }
    
    if (loginName.length>20) {
        return NO;
    }
    
    return YES;
}
+ (BOOL)validatePassword:(NSString *)password
{
    if (password==nil || [password isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"密码不为空"];
        return NO;
    }
    
    if (password.length > 12) {
        [SVProgressHUD showErrorWithStatus:@"密码超过12位最大长度"];
        return NO;
    }
    
    return YES;
}

+ (BOOL)validateRigistPassword:(NSString *)password withCheck:(NSString *)cPassword
{
    if (password==nil||cPassword==nil) {
        [SVProgressHUD showErrorWithStatus:@"密码不为空"];
        return NO;
    }
    
    if (![password isEqualToString:cPassword]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致"];
        return NO;
    }
    
    if (password.length>12||cPassword.length>12) {
        [SVProgressHUD showErrorWithStatus:@"密码超过12位最大长度"];
        return NO;
    }
    
    return YES;
    
}

@end
