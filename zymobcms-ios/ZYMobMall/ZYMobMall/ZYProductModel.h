//
//  ZYProductModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYProductModel : ZYBaseModel
@property (nonatomic,retain)NSString *productId;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *source;
@property (nonatomic,retain)NSString *location;
@property (nonatomic,retain)NSString *favoriteCount;
@property (nonatomic,retain)NSString *images;
@property (nonatomic,retain)NSString *productFace;
@property (nonatomic,retain)NSString *productCode;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,retain)NSString *commentCount;
@property (nonatomic,retain)NSString *marketPrice;
@property (nonatomic,retain)NSString *wePrice;
@property (nonatomic,retain)NSString *isFavorited;
@property (nonatomic,retain)NSString *content;



- (id)initWithSummaryContentDict:(NSDictionary*)summaryDict;
- (id)initWithDetailContentDict:(NSDictionary*)detailDict;

@end
