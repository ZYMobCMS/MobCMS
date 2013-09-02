//
//  ZYCommentModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCommentModel : ZYBaseModel
@property (nonatomic,retain)NSString *commentId;
@property (nonatomic,retain)NSString *relationId;//文章，图片或者产品的Id
@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *createTime;
@property (nonatomic,retain)NSString *createUserId;
@property (nonatomic,retain)NSString *supportCount;
@property (nonatomic,retain)NSString *unsupportCount;
@property (nonatomic,retain)NSString *toUsers;
@property (nonatomic,retain)NSString *status;
@property (nonatomic,retain)NSString *isSupported;

- (id)initWithSummaryDict:(NSDictionary*)contentDict;

@end
