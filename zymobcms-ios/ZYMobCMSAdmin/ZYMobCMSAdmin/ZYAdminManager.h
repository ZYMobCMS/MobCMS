//
//  ZYAdminManager.h
//  ZYMobCMSAdmin
//
//  Created by barfoo2 on 13-8-22.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYAdminManager : NSObject
{

}
@property (nonatomic,retain)NSString *adminId;
@property (nonatomic,retain)NSString *adminLoginName;
@property (nonatomic,retain)NSString *adminPassword;
@property (nonatomic,retain)NSString *adminEmail;

+ (ZYAdminManager*)shareManager;

@end
