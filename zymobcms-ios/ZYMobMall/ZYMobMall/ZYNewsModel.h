//
//  ZYNewsModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYNewsModel : ZYBaseModel
@property (nonatomic,retain)NSString *articleId;
@property (nonatomic,retain)NSString *categoryId;
@property (nonatomic,retain)NSString *tabTypeId;

@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *source;
@property (nonatomic,retain)NSString *publishTime;
@property (nonatomic,retain)NSString *images;
@property (nonatomic,retain)NSString *author;
@property (nonatomic,retain)NSString *commentCount;
@property (nonatomic,retain)NSString *favoriteCount;
@property (nonatomic,retain)NSString *links;
@property (nonatomic,retain)NSString *commentable;
@property (nonatomic,retain)NSString *hotNews;
@property (nonatomic,retain)NSString *industryId;
@property (nonatomic,retain)NSString *summary;
@property (nonatomic,retain)NSString *content;

- (id)initWithSummaryContent:(NSDictionary *)contentDict;
- (id)initWithDetailContent:(NSDictionary*)contentDict;

@end
