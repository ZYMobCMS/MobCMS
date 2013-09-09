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
@synthesize rigistTime,qq,msn,mobile,phone,profile,sex,location,loginDays,points;

- (id)initWithUserInfo:(NSDictionary *)userInfo
{
    if (self = [super init]) {
        
        self.userId = [userInfo objectForKey:@"id"];
        self.loginName = [userInfo objectForKey:@"login_name"];
        self.email = [userInfo objectForKey:@"email"];
        self.password = [userInfo objectForKey:@"password"];
        self.nickName = [userInfo objectForKey:@"nick_name"];
        self.userActiveOpen = [userInfo objectForKey:@"user_active_open"];
        self.status = [userInfo objectForKey:@"status"];
        self.rigistTime = [userInfo objectForKey:@"rigist_time"];
        self.qq = [userInfo objectForKey:@"qq"];
        self.msn = [userInfo objectForKey:@"msn"];
        self.mobile = [userInfo objectForKey:@"mobile"];
        self.phone = [userInfo objectForKey:@"phone"];
        self.profile = [userInfo objectForKey:@"profile"];
        self.sex = [userInfo objectForKey:@"sex"];
        self.location = [userInfo objectForKey:@"location"];
        self.loginDays = [userInfo objectForKey:@"login_days"];
        self.points = [userInfo objectForKey:@"points"];
        
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
    
    self.rigistTime = nil;
    self.qq = nil;
    self.msn = nil;
    self.mobile = nil;
    self.phone = nil;
    self.profile = nil;
    self.sex = nil;
    self.loginDays = nil;
    self.location = nil;
    self.points = nil;
    
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

        self.rigistTime = [aDecoder decodeObjectForKey:@"rigistTime"];
        self.qq = [aDecoder decodeObjectForKey:@"qq"];
        self.msn = [aDecoder decodeObjectForKey:@"msn"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.profile = [aDecoder decodeObjectForKey:@"profile"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.loginDays = [aDecoder decodeObjectForKey:@"loginDays"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.points = [aDecoder decodeObjectForKey:@"points"];

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
    
    [aCoder encodeObject:self.rigistTime forKey:@"rigistTime"];
    [aCoder encodeObject:self.qq forKey:@"qq"];
    [aCoder encodeObject:self.msn forKey:@"msn"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.profile forKey:@"profile"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.loginDays forKey:@"loginDays"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.points forKey:@"points"];

}


@end
