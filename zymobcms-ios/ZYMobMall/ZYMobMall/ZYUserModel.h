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

- (id)initWithUserInfo:(NSDictionary*)userInfo;


@end
