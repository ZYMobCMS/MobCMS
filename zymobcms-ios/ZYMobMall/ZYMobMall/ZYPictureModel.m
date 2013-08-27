//
//  ZYPictureModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYPictureModel.h"

@implementation ZYPictureModel
@synthesize pictureId,categoryId,tabTypeId,title,source,price,links,favoriteCount;

- (void)dealloc
{
    self.pictureId = nil;
    self.categoryId = nil;
    self.tabTypeId = nil;
    self.title = nil;
    self.source = nil;
    self.price = nil;
    self.links = nil;
    self.favoriteCount = nil;
    [super dealloc];
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

    }
    return self;
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

}

- (id)initWithSummaryDict:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.pictureId = [contentDict objectForKey:@"id"];
        self.categoryId = [contentDict objectForKey:@"category_id"];
        self.tabTypeId = [contentDict objectForKey:@"tab_type_idd"];
        self.title = [contentDict objectForKey:@"title"];
        self.source = [contentDict objectForKey:@"source"];
        self.price = [contentDict objectForKey:@"price"];
        self.links = [contentDict objectForKey:@"links"];
        self.links = [contentDict objectForKey:@"favorite_count"];

    }
    return self;
}

@end
