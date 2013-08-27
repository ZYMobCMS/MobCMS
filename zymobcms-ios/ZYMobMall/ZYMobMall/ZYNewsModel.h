//
//  ZYNewsModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYNewsModel : NSObject
@property (nonatomic,retain)NSString *articleId;
@property (nonatomic,retain)NSString *categoryId;
@property (nonatomic,retain)NSString *tabTypeId;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *source;
@property (nonatomic,retain)NSString *publishTime;

@end
