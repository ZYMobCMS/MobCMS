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
@property (nonatomic,retain)NSString *images;
@property (nonatomic,retain)NSString *source;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,retain)NSString *links;
@property (nonatomic,retain)NSString *favoriteCount;
@property (nonatomic,retain)NSString *isFavorited;
@property (nonatomic,retain)NSString *summary;
@property (nonatomic,retain)NSString *commentCount;
@property (nonatomic,retain)NSString *industryId;
@property (nonatomic,retain)NSString *marketPrice;
@property (nonatomic,retain)NSString *wePrice;
@property (nonatomic,retain)NSString *lowPrice;
@property (nonatomic,retain)NSString *productCode;
@property (nonatomic,retain)NSString *productFaceCode;
@property (nonatomic,retain)NSString *contactMobile;
@property (nonatomic,retain)NSString *productCombine;
@property (nonatomic,retain)NSString *productSaleFace;
@property (nonatomic,retain)NSString *location;
@property (nonatomic,retain)NSString *hasNow;
@property (nonatomic,retain)NSString *productResporityCode;
@property (nonatomic,retain)NSString *hasSelledCount;

- (id)initWithSummaryDict:(NSDictionary*)contentDict;
- (id)initWithDetailDict:(NSDictionary*)contentDict;

@end
