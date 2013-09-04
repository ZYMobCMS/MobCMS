//
//  ZYUserActiveModel.h
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-2.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseModel.h"

@interface ZYUserActiveModel : ZYBaseModel
@property (nonatomic,retain)NSString *relationId;
@property (nonatomic,retain)NSString *relationTable;
@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *createTime;
@property (nonatomic,retain)NSString *createLoginName;
@property (nonatomic,retain)NSString *createNickName;
@property (nonatomic,retain)NSString *relationImages;
@property (nonatomic,retain)NSString *relationTitle;
@property (nonatomic,retain)NSString *userActiveOpen;

- (id)initWithContentDict:(NSDictionary*)contentDict;

@end
