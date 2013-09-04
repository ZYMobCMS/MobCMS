//
//  ZYUserModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYBaseModel.h"

@interface ZYUserModel : ZYBaseModel
@property (nonatomic,retain)NSString *userId;
@property (nonatomic,retain)NSString *loginName;
@property (nonatomic,retain)NSString *email;
@property (nonatomic,retain)NSString *password;
@property (nonatomic,retain)NSString *nickName;
@property (nonatomic,retain)NSString *userActiveOpen;
@property (nonatomic,retain)NSString *status;
@property (nonatomic,retain)NSString *rigistTime;
@property (nonatomic,retain)NSString *qq;
@property (nonatomic,retain)NSString *msn;
@property (nonatomic,retain)NSString *phone;
@property (nonatomic,retain)NSString *mobile;
@property (nonatomic,retain)NSString *profile;
@property (nonatomic,retain)NSString *sex;
@property (nonatomic,retain)NSString *location;
@property (nonatomic,retain)NSString *points;
@property (nonatomic,retain)NSString *loginDays;

- (id)initWithUserInfo:(NSDictionary*)userInfo;


@end
