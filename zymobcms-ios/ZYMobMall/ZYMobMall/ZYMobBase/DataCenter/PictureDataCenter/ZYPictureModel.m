//
//  ZYPictureModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYPictureModel.h"

@implementation ZYPictureModel
@synthesize pictureId,categoryId,tabTypeId,

title,images,links,source,price,favoriteCount,isFavorited,summary,commentCount,

industryId,marketPrice,wePrice,lowPrice,productCode,productFaceCode,productCombine,

contactMobile,location,hasNow,hasSelledCount,productResporityCode,productSaleFace;



- (void)dealloc
{
    self.pictureId = nil;
    self.categoryId = nil;
    self.tabTypeId = nil;
    
    self.title = nil;
    self.source = nil;
    self.price = nil;
    self.links = nil;
    self.images = nil;
    self.commentCount = nil;
    self.isFavorited = nil;
    self.summary = nil;
    self.favoriteCount = nil;
    self.industryId = nil;
    self.marketPrice = nil;
    self.wePrice = nil;
    self.lowPrice = nil;
    self.productCode = nil;
    self.productFaceCode = nil;
    self.productCombine = nil;
    self.contactMobile = nil;
    self.location = nil;
    self.hasNow = nil;
    self.hasSelledCount = nil;
    self.productResporityCode = nil;
    self.productSaleFace = nil;
    
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.pictureId forKey:@"pictureId"];
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.tabTypeId forKey:@"tabTypeId"];
    
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.links forKey:@"links"];
    [aCoder encodeObject:self.favoriteCount forKey:@"favoriteCount"];
    [aCoder encodeObject:self.commentCount forKey:@"commentCount"];
    [aCoder encodeObject:self.isFavorited forKey:@"isFavorited"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.industryId forKey:@"industryId"];
    [aCoder encodeObject:self.marketPrice forKey:@"marketPrice"];
    [aCoder encodeObject:self.wePrice forKey:@"wePrice"];
    [aCoder encodeObject:self.lowPrice forKey:@"lowPrice"];
    [aCoder encodeObject:self.productCode forKey:@"productCode"];
    [aCoder encodeObject:self.productFaceCode forKey:@"productFaceCode"];
    [aCoder encodeObject:self.productCombine forKey:@"productCombine"];
    [aCoder encodeObject:self.contactMobile forKey:@"contactMobile"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.hasNow forKey:@"hasNow"];
    [aCoder encodeObject:self.hasSelledCount forKey:@"hasSelledCount"];
    [aCoder encodeObject:self.productResporityCode forKey:@"productResporityCode"];
    [aCoder encodeObject:self.productSaleFace forKey:@"productSaleFace"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        
        self.pictureId = [aDecoder decodeObjectForKey:@"pictureId"];
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.tabTypeId = [aDecoder decodeObjectForKey:@"tabTypeId"];
        
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.links = [aDecoder decodeObjectForKey:@"links"];
        self.favoriteCount = [aDecoder decodeObjectForKey:@"favoriteCount"];
        self.commentCount = [aDecoder decodeObjectForKey:@"commentCount"];
        self.isFavorited = [aDecoder decodeObjectForKey:@"isFavorited"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.industryId = [aDecoder decodeObjectForKey:@"industryId"];
        self.marketPrice = [aDecoder decodeObjectForKey:@"marketPrice"];
        self.wePrice = [aDecoder decodeObjectForKey:@"wePrice"];
        self.lowPrice = [aDecoder decodeObjectForKey:@"lowPrice"];
        self.productCode = [aDecoder decodeObjectForKey:@"productCode"];
        self.productFaceCode = [aDecoder decodeObjectForKey:@"productFaceCode"];
        self.productCombine = [aDecoder decodeObjectForKey:@"productCombine"];
        self.contactMobile = [aDecoder decodeObjectForKey:@"contactMobile"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.hasNow = [aDecoder decodeObjectForKey:@"hasNow"];
        self.hasSelledCount = [aDecoder decodeObjectForKey:@"hasSelledCount"];
        self.productResporityCode = [aDecoder decodeObjectForKey:@"productResporityCode"];
        self.productSaleFace = [aDecoder decodeObjectForKey:@"productSaleFace"];

    }
    return self;
}

- (id)initWithDetailDict:(NSDictionary *)contentDict
{
    if(self = [super init]){
        
        self.pictureId = [contentDict objectForKey:@"picture_id"];
        self.categoryId = [contentDict objectForKey:@"main_category_id"];
        self.tabTypeId = [contentDict objectForKey:@"sub_tab_type_id"];
        
        self.title = [contentDict objectForKey:@"title"];
        self.source = [contentDict objectForKey:@"source"];
        self.price = [contentDict objectForKey:@"price"];
        self.links = [contentDict objectForKey:@"links"];
        self.images = [contentDict objectForKey:@"images"];
        self.industryId = [contentDict objectForKey:@"industry_id"];
        self.marketPrice = [contentDict objectForKey:@"market_price"];
        self.wePrice = [contentDict objectForKey:@"we_price"];
        self.lowPrice = [contentDict objectForKey:@"low_price"];
        self.productCode = [contentDict objectForKey:@"product_code"];
        self.productFaceCode = [contentDict objectForKey:@"product_face_code"];
        self.contactMobile = [contentDict objectForKey:@"contact_mobile"];
        self.location = [contentDict objectForKey:@"location"];
        self.hasNow = [contentDict objectForKey:@"has_now"];
        self.hasSelledCount = [contentDict objectForKey:@"has_selled_count"];
        self.productResporityCode = [contentDict objectForKey:@"product_respority_code"];
        self.productSaleFace = [contentDict objectForKey:@"product_sale_face"];
        self.favoriteCount = [contentDict objectForKey:@"favorite_count"];
        self.commentCount = [contentDict objectForKey:@"comment_count"];
        self.isFavorited = [contentDict objectForKey:@"isFavorited"];
        self.summary = [contentDict objectForKey:@"summary"];
        
    }
    return self;
}





- (id)initWithSummaryDict:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.pictureId = [contentDict objectForKey:@"picture_id"];
        self.categoryId = [contentDict objectForKey:@"main_category_id"];
        self.tabTypeId = [contentDict objectForKey:@"sub_tab_type_id"];
        
        self.title = [contentDict objectForKey:@"title"];
        self.source = [contentDict objectForKey:@"source"];
        self.price = [contentDict objectForKey:@"price"];
        self.links = [contentDict objectForKey:@"links"];
        self.favoriteCount = [contentDict objectForKey:@"favorite_count"];
        self.commentCount = [contentDict objectForKey:@"comment_count"];
        self.isFavorited = [contentDict objectForKey:@"isFavorited"];
        self.summary = [contentDict objectForKey:@"summary"];
        
    }
    return self;
}



@end
