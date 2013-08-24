//
//  ZYAdminManager.m
//  ZYMobCMSAdmin
//
//  Created by barfoo2 on 13-8-22.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYAdminManager.h"

static ZYAdminManager *_adminInstance = nil;

@implementation ZYAdminManager
@synthesize adminEmail,adminId,adminLoginName,adminPassword;

+ (ZYAdminManager*)shareManager
{
    @synchronized(self){
        if (!_adminInstance) {
            _adminInstance = [[self alloc]init];
        }
    }
    return _adminInstance;
}


@end
