//
//  ZYNewsModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYNewsModel.h"

@implementation ZYNewsModel
@synthesize articleId,categoryId,tabTypeId,title,source,publishTime;

- (void)dealloc
{
    self.articleId = nil;
    self.categoryId = nil;
    self.tabTypeId = nil;
    self.title = nil;
    self.source = nil;
    self.publishTime = nil;
    [super dealloc];
}

- (id)initWithSummaryContent:(NSDictionary *)content
{
    if (self = [super init]) {
        
        self.articleId = [content objectForKey:@"article_id"];
        self.categoryId = [content objectForKey:@"category_id"];
        self.tabTypeId = [content objectForKey:@"tab_type_id"];
        self.title = [content objectForKey:@"title"];
        self.source = [content objectForKey:@"source"];
        self.publishTime = [content objectForKey:@"publish_time"];
        
    }
    return self;
}

- (id)initWithDetailContent:(NSDictionary *)content
{
    if (self = [super init]) {
        
        self.articleId = [content objectForKey:@"article_id"];
        self.categoryId = [content objectForKey:@"category_id"];
        self.tabTypeId = [content objectForKey:@"tab_type_id"];
        self.title = [content objectForKey:@"title"];
        self.source = [content objectForKey:@"source"];
        self.publishTime = [content objectForKey:@"publish_time"];
        
    }
    return self;
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

        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.articleId forKey:@"articleId"];
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.tabTypeId forKey:@"tabTypeId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.publishTime forKey:@"publishTime"];

}

@end
