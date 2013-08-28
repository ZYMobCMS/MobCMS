//
//  ZYPictureModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPictureModel : ZYBaseModel
@property (nonatomic,retain)NSString *pictureId;
@property (nonatomic,retain)NSString *categoryId;
@property (nonatomic,retain)NSString *tabTypeId;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *source;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,retain)NSString *links;
@property (nonatomic,retain)NSString *favoriteCount;
@property (nonatomic,retain)NSString *isFavorited;
@property (nonatomic,retain)NSString *summary;
@property (nonatomic,retain)NSString *commentCount;

- (id)initWithSummaryDict:(NSDictionary*)contentDict;
- (id)initWithDetailDict:(NSDictionary*)contentDict;

@end
