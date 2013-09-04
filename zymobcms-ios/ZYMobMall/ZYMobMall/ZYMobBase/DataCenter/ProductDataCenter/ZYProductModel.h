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
@property (nonatomic,retain)NSString *content;
@property (nonatomic,retain)NSString *summary;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,retain)NSString *images;
@property (nonatomic,retain)NSString *createTime;
@property (nonatomic,retain)NSString *createUserId;
@property (nonatomic,retain)NSString *status;
@property (nonatomic,retain)NSString *hasNow;
@property (nonatomic,retain)NSString *supportCount;
@property (nonatomic,retain)NSString *links;
@property (nonatomic,retain)NSString *contactEmail;
@property (nonatomic,retain)NSString *contactPhone;
@property (nonatomic,retain)NSString *contactName;
@property (nonatomic,retain)NSString *contactQQ;
@property (nonatomic,retain)NSString *contactWangWang;
@property (nonatomic,retain)NSString *contactMobile;
@property (nonatomic,retain)NSString *commentCount;
@property (nonatomic,retain)NSString *favoriteCount;
@property (nonatomic,retain)NSString *source;
@property (nonatomic,retain)NSString *hasSelledCount;
@property (nonatomic,retain)NSString *adminPrice;
@property (nonatomic,retain)NSString *marketPrice;
@property (nonatomic,retain)NSString *wePrice;
@property (nonatomic,retain)NSString *productCode;
@property (nonatomic,retain)NSString *productFace;
@property (nonatomic,retain)NSString *productWeight;
@property (nonatomic,retain)NSString *productResporityCode;
@property (nonatomic,retain)NSString *productSaleFace;
@property (nonatomic,retain)NSString *industryId;
@property (nonatomic,retain)NSString *contactUrl;
@property (nonatomic,retain)NSString *categoryId;
@property (nonatomic,retain)NSString *tabTypeId;
@property (nonatomic,retain)NSString *isFavorited;




- (id)initWithSummaryContentDict:(NSDictionary*)summaryDict;
- (id)initWithDetailContentDict:(NSDictionary*)detailDict;

@end
