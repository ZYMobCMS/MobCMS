//
//  ZYNewsModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYNewsModel.h"

@implementation ZYNewsModel
@synthesize articleId,categoryId,tabTypeId,
title,source,publishTime,summary,content,images,links,commentable,commentCount,favoriteCount,author,hotNews,industryId;

- (void)dealloc
{
    self.articleId = nil;
    self.categoryId = nil;
    self.tabTypeId = nil;
    
    self.title = nil;
    self.source = nil;
    self.publishTime = nil;
    self.summary = nil;
    self.content = nil;
    self.images = nil;
    self.links = nil;
    self.commentable = nil;
    self.commentCount = nil;
    self.favoriteCount = nil;
    self.author = nil;
    self.hotNews = nil;
    self.industryId = nil;
    
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.articleId forKey:@"articleId"];
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.tabTypeId forKey:@"tabTypeId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.publishTime forKey:@"publishTime"];
    [aCoder encodeObject:self.summary forKey:@"summary"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.images forKey:@"images"];
    [aCoder encodeObject:self.links forKey:@"links"];
    [aCoder encodeObject:self.commentable forKey:@"commentable"];
    [aCoder encodeObject:self.commentCount forKey:@"commentCount"];
    [aCoder encodeObject:self.favoriteCount forKey:@"favoriteCount"];
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.hotNews forKey:@"hotNews"];
    [aCoder encodeObject:self.industryId forKey:@"industryId"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.articleId = [aDecoder decodeObjectForKey:@"articleId"];
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.tabTypeId = [aDecoder decodeObjectForKey:@"tabTypeId"];
        
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.publishTime = [aDecoder decodeObjectForKey:@"publishTime"];
        self.summary = [aDecoder decodeObjectForKey:@"summary"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.images = [aDecoder decodeObjectForKey:@"images"];
        self.links = [aDecoder decodeObjectForKey:@"links"];
        self.commentable = [aDecoder decodeObjectForKey:@"commentable"];
        self.commentCount = [aDecoder decodeObjectForKey:@"commentCount"];
        self.favoriteCount = [aDecoder decodeObjectForKey:@"favoriteCount"];
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.hotNews = [aDecoder decodeObjectForKey:@"hotNews"];
        self.industryId = [aDecoder decodeObjectForKey:@"industryId"];

        
    }
    return self;
}

- (id)initWithDetailContent:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.articleId = [contentDict objectForKey:@"article_id"];
        self.categoryId = [contentDict objectForKey:@"category_id"];
        self.tabTypeId = [contentDict objectForKey:@"tab_type_id"];
        self.title = [contentDict objectForKey:@"title"];
        self.source = [contentDict objectForKey:@"source"];
        self.publishTime = [contentDict objectForKey:@"publish_time"];
        self.images = [contentDict objectForKey:@"images"];
        
    }
    return self;
}

- (id)initWithSummaryContent:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.articleId = [contentDict objectForKey:@"article_id"];
        self.categoryId = [contentDict objectForKey:@"category_id"];
        self.tabTypeId = [contentDict objectForKey:@"tab_type_id"];
        
        self.title = [contentDict objectForKey:@"title"];
        self.source = [contentDict objectForKey:@"source"];
        self.publishTime = [contentDict objectForKey:@"publish_time"];
        self.summary = [contentDict objectForKey:@"summary"];
        self.content = [contentDict objectForKey:@"content"];
        self.images = [contentDict objectForKey:@"images"];
        self.commentable = [contentDict objectForKey:@"commentable"];
        self.favoriteCount = [contentDict objectForKey:@"favorite_count"];
        self.commentCount = [contentDict objectForKey:@"comment_count"];
        self.author = [contentDict objectForKey:@"author"];
        self.hotNews = [contentDict objectForKey:@"hotNews"];
        self.industryId = [contentDict objectForKey:@"industry_id"];
        self.links = [contentDict objectForKey:@"links"];
        
    }
    return self;
}


@end
