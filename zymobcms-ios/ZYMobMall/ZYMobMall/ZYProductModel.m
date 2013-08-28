//
//  ZYProductModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYProductModel.h"

@implementation ZYProductModel
@synthesize productCode,price,productFace,productId,wePrice,marketPrice;
@synthesize images,title,location,favoriteCount,commentCount,source;
@synthesize isFavorited,content;

- (void)dealloc
{
    self.productId = nil;
    self.price = nil;
    self.productCode = nil;
    self.productFace = nil;
    self.wePrice = nil;
    self.marketPrice = nil;
    self.images = nil;
    self.title = nil;
    self.location = nil;
    self.favoriteCount = nil;
    self.commentCount = nil;
    self.source = nil;
    self.content = nil;
    [super dealloc];
}

- (id)initWithSummaryContentDict:(NSDictionary *)summaryDict
{
    if (self = [super init]) {
        
        self.productId = [summaryDict objectForKey:@"product_id"];
        self.price = [summaryDict objectForKey:@"price"];
        self.productCode = [summaryDict objectForKey:@"product_code"];
        self.productFace = [summaryDict objectForKey:@"product_face"];
        self.wePrice = [summaryDict objectForKey:@"we_price"];
        self.marketPrice = [summaryDict objectForKey:@"market_price"];
        self.images = [summaryDict objectForKey:@"images"];
        self.title = [summaryDict objectForKey:@"title"];
        self.location = [summaryDict objectForKey:@"location"];
        self.favoriteCount = [summaryDict objectForKey:@"favorite_count"];
        self.commentCount = [summaryDict objectForKey:@"comment_count"];
        self.source = [summaryDict objectForKey:@"source"];
        
        
    }
    return self;
}

- (id)initWithDetailContentDict:(NSDictionary *)detailDict
{
    if (self = [super init]) {
        
        self.productId = [detailDict objectForKey:@"product_id"];
        self.price = [detailDict objectForKey:@"price"];
        self.productCode = [detailDict objectForKey:@"product_code"];
        self.productFace = [detailDict objectForKey:@"product_face"];
        self.wePrice = [detailDict objectForKey:@"we_price"];
        self.marketPrice = [detailDict objectForKey:@"market_price"];
        self.images = [detailDict objectForKey:@"images"];
        self.title = [detailDict objectForKey:@"title"];
        self.location = [detailDict objectForKey:@"location"];
        self.favoriteCount = [detailDict objectForKey:@"favorite_count"];
        self.commentCount = [detailDict objectForKey:@"comment_count"];
        self.source = [detailDict objectForKey:@"source"];
        self.isFavorited = [detailDict objectForKey:@"isFavorited"];
        self.content = [detailDict objectForKey:@"content"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.productId = [aDecoder decodeObjectForKey:@"productId"];
        self.price = [aDecoder decodeObjectForKey:@"price"];
        self.productCode = [aDecoder decodeObjectForKey:@"productCode"];
        self.productFace = [aDecoder decodeObjectForKey:@"productFace"];
        self.wePrice = [aDecoder decodeObjectForKey:@"wePrice"];
        self.marketPrice = [aDecoder decodeObjectForKey:@"marketPrice"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.favoriteCount = [aDecoder decodeObjectForKey:@"favoriteCount"];
        self.commentCount = [aDecoder decodeObjectForKey:@"commentCount"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.isFavorited = [aDecoder decodeObjectForKey:@"isFavorited"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.productId forKey:@"productId"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.productCode forKey:@"productCode"];
    [aCoder encodeObject:self.productFace forKey:@"productFace"];
    [aCoder encodeObject:self.wePrice forKey:@"wePrice"];
    [aCoder encodeObject:self.marketPrice forKey:@"marketPrice"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.favoriteCount forKey:@"favoriteCount"];
    [aCoder encodeObject:self.commentCount forKey:@"commentCount"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.isFavorited forKey:@"isFavorited"];

}
@end
