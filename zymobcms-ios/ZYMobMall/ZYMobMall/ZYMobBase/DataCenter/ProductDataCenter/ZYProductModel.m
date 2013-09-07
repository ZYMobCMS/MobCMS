//
//  ZYProductModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYProductModel.h"

@implementation ZYProductModel
@synthesize productId,productCode,price,productFace,productResporityCode,productSaleFace,productWeight;
@synthesize contactEmail,contactMobile,commentCount,categoryId,contactName,contactPhone,contactQQ,contactUrl,contactWangWang,content,createTime,createUserId;
@synthesize wePrice,adminPrice,marketPrice;
@synthesize title,summary,status,hasNow,supportCount,isFavorited,favoriteCount,source,links,industryId,hasSelledCount,images;
@synthesize tabTypeId;

- (void)dealloc
{
    self.productId = nil;
    self.productCode = nil;
    self.price = nil;
    self.productFace = nil;
    self.productResporityCode = nil;
    self.productSaleFace = nil;
    self.productWeight = nil;
    self.contactEmail = nil;
    self.contactMobile = nil;
    self.commentCount = nil;
    self.categoryId = nil;
    self.contactName = nil;
    self.contactPhone = nil;
    self.contactQQ = nil;
    self.contactUrl = nil;
    self.contactWangWang = nil;
    self.content = nil;
    self.createTime = nil;
    self.createUserId = nil;
    self.wePrice = nil;
    self.adminPrice = nil;
    self.marketPrice = nil;
    self.title = nil;
    self.summary = nil;
    self.status = nil;
    self.hasNow = nil;
    self.supportCount = nil;
    self.isFavorited = nil;
    self.favoriteCount = nil;
    self.source = nil;
    self.links = nil;
    self.industryId = nil;
    self.hasSelledCount = nil;
    self.images = nil;
    self.tabTypeId = nil;
    
    
    [super dealloc];
}

- (id)initWithSummaryContentDict:(NSDictionary *)summaryDict
{
    if (self = [super init]) {
        
        self.productId = [summaryDict objectForKey:@"product_id"];
        self.price = [summaryDict objectForKey:@"price"];
        self.marketPrice = [summaryDict objectForKey:@"market_price"];
        self.wePrice = [summaryDict objectForKey:@"we_price"];
        self.images = [summaryDict objectForKey:@"images"];
        self.title = [summaryDict objectForKey:@"title"];
        self.favoriteCount = [summaryDict objectForKey:@"favorite_count"];
        self.commentCount = [summaryDict objectForKey:@"comment_count"];
        self.source = [summaryDict objectForKey:@"source"];
        self.hasSelledCount = [summaryDict objectForKey:@"has_selled_count"];
        self.hasNow = [summaryDict objectForKey:@"has_now"];
        self.summary = [summaryDict objectForKey:@"summary"];
        self.productFace = [summaryDict objectForKey:@"product_face"];
        
        self.categoryId = [summaryDict objectForKey:@"main_category_id"];
        self.tabTypeId = [summaryDict objectForKey:@"sub_tab_type_id"];
        
        
    }
    return self;
}

- (id)initWithDetailContentDict:(NSDictionary *)detailDict
{
    if (self = [super init]) {
        
        self.productId = [detailDict objectForKey:@"product_id"];
        self.price = [detailDict objectForKey:@"price"];
        self.marketPrice = [detailDict objectForKey:@"market_price"];
        self.wePrice = [detailDict objectForKey:@"we_price"];
        self.images = [detailDict objectForKey:@"images"];
        self.title = [detailDict objectForKey:@"title"];
        self.favoriteCount = [detailDict objectForKey:@"favorite_count"];
        self.commentCount = [detailDict objectForKey:@"comment_count"];
        self.source = [detailDict objectForKey:@"source"];
        self.hasSelledCount = [detailDict objectForKey:@"has_selled_count"];
        self.hasNow = [detailDict objectForKey:@"has_now"];
        self.summary = [detailDict objectForKey:@"summary"];
        self.productFace = [detailDict objectForKey:@"product_face"];
        
        self.content = [detailDict objectForKey:@"content"];
        self.status = [detailDict objectForKey:@"status"];
        self.contactEmail = [detailDict objectForKey:@"contact_email"];
        self.contactPhone = [detailDict objectForKey:@"contact_phone"];
        self.contactMobile = [detailDict objectForKey:@"contact_mobile"];
        self.contactName = [detailDict objectForKey:@"contact_name"];
        self.contactQQ = [detailDict objectForKey:@"contact_qq"];
        self.contactWangWang = [detailDict objectForKey:@"contact_wang_wang"];
        self.contactUrl = [detailDict objectForKey:@"contact_url"];
        self.productCode = [detailDict objectForKey:@"product_code"];
        self.productResporityCode = [detailDict objectForKey:@"product_respority_code"];
        self.productSaleFace = [detailDict objectForKey:@"product_sale_face"];
        self.productWeight = [detailDict objectForKey:@"product_weight"];
        self.adminPrice = [detailDict objectForKey:@"admin_price"];
        self.links = [detailDict objectForKey:@"links"];
        self.industryId = [detailDict objectForKey:@"industry_id"];
        
        self.categoryId = [detailDict objectForKey:@"main_category_id"];
        self.tabTypeId = [detailDict objectForKey:@"sub_tab_type_id"];
        self.isFavorited = [detailDict objectForKey:@"isFavorited"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.productId = [aDecoder decodeObjectForKey:@"productId"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.marketPrice = [aDecoder decodeObjectForKey:@"marketPrice"];
        self.wePrice = [aDecoder decodeObjectForKey:@"wePrice"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.favoriteCount = [aDecoder decodeObjectForKey:@"favoriteCount"];
        self.commentCount = [aDecoder decodeObjectForKey:@"commentCount"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.hasSelledCount = [aDecoder decodeObjectForKey:@"hasSelledCount"];
        self.hasNow = [aDecoder decodeObjectForKey:@"hasNow"];
        self.summary = [aDecoder decodeObjectForKey:@"summary"];
        self.productFace = [aDecoder decodeObjectForKey:@"productFace"];
        
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.contactEmail = [aDecoder decodeObjectForKey:@"contactEmail"];
        self.contactPhone = [aDecoder decodeObjectForKey:@"contactPhone"];
        self.contactMobile = [aDecoder decodeObjectForKey:@"contactName"];
        self.contactName = [aDecoder decodeObjectForKey:@"contactName"];
        self.contactQQ = [aDecoder decodeObjectForKey:@"contactQQ"];
        self.contactWangWang = [aDecoder decodeObjectForKey:@"contactWangWang"];
        self.contactUrl = [aDecoder decodeObjectForKey:@"contactUrl"];
        self.productCode = [aDecoder decodeObjectForKey:@"productCode"];
        self.productResporityCode = [aDecoder decodeObjectForKey:@"productResporityCode"];
        self.productSaleFace = [aDecoder decodeObjectForKey:@"productSaleFace"];
        self.productWeight = [aDecoder decodeObjectForKey:@"productWeight"];
        self.adminPrice = [aDecoder decodeObjectForKey:@"adminPrice"];
        self.links = [aDecoder decodeObjectForKey:@"links"];
        self.industryId = [aDecoder decodeObjectForKey:@"industryId"];
        
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.tabTypeId = [aDecoder decodeObjectForKey:@"tabTypeId"];
        self.isFavorited = [aDecoder decodeObjectForKey:@"isFavorited"];


    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.productId forKey:@"productId"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.marketPrice forKey:@"marketPrice"];
    [aCoder encodeObject:self.wePrice forKey:@"wePrice"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.favoriteCount forKey:@"favoriteCount"];
    [aCoder encodeObject:self.commentCount forKey:@"commentCount"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.hasSelledCount forKey:@"hasSelledCount"];
    [aCoder encodeObject:self.hasNow forKey:@"hasNow"];
    [aCoder encodeObject:self.summary forKey:@"summary"];
    [aCoder encodeObject:self.productFace forKey:@"productFace"];
    
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.contactEmail forKey:@"contactEmail"];
    [aCoder encodeObject:self.contactPhone forKey:@"contactPhone"];
    [aCoder encodeObject:self.contactMobile forKey:@"contactMobile"];
    [aCoder encodeObject:self.contactName forKey:@"contactName"];
    [aCoder encodeObject:self.contactQQ forKey:@"contactQQ"];
    [aCoder encodeObject:self.contactWangWang forKey:@"contactWangWang"];
    [aCoder encodeObject:self.contactUrl forKey:@"contactUrl"];
    [aCoder encodeObject:self.productCode forKey:@"productCode"];
    [aCoder encodeObject:self.productResporityCode forKey:@"productResporityCode"];
    [aCoder encodeObject:self.productSaleFace forKey:@"productSaleFace"];
    [aCoder encodeObject:self.productWeight forKey:@"productWeight"];
    [aCoder encodeObject:self.adminPrice forKey:@"adminPrice"];
    [aCoder encodeObject:self.links forKey:@"links"];
    [aCoder encodeObject:self.industryId forKey:@"industryId"];
    
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.tabTypeId forKey:@"tabTypeId"];
    [aCoder encodeObject:self.isFavorited forKey:@"isFavorited"];

}
@end
