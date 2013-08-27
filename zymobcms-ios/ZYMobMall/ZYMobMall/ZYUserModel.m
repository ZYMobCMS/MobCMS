//
//  ZYUserModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYUserModel.h"

@implementation ZYUserModel
@synthesize userId,loginName,email,password,nickName;
@synthesize userActiveOpen,status;

- (id)initWithUserInfo:(NSDictionary *)userInfo
{
    if (self = [super init]) {
        
        self.userId = [userInfo objectForKey:@"id"];
        self.loginName = [userInfo objectForKey:@"login_name"];
        self.email = [userInfo objectForKey:@"email"];
        self.password = [userInfo objectForKey:@"password"];
        self.nickName = [userInfo objectForKey:@"nick_name"];
        self.userActiveOpen = [userInfo objectForKey:@"userActiveOpen"];
        self.status = [userInfo objectForKey:@"status"];

    }
    return self;
}

- (void)dealloc
{
    self.userId = nil;
    self.loginName = nil;
    self.email = nil;
    self.password = nil;
    self.nickName = nil;
    self.status = nil;
    self.userActiveOpen = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.loginName = [aDecoder decodeObjectForKey:@"loginName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.userActiveOpen = [aDecoder decodeObjectForKey:@"userActiveOpen"];
        self.status = [aDecoder decodeObjectForKey:@"status"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.loginName forKey:@"loginName"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.userActiveOpen forKey:@"userActiveOpen"];
    [aCoder encodeObject:self.status forKey:@"status"];

}


@end
