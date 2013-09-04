//
//  ZYMenuItemModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYMenuItemModel.h"

@implementation ZYMenuItemModel
@synthesize moduleId,index,name;
@synthesize icon,isLocalIcon,categoryId;

- (id)initWithContentDict:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.moduleId = [contentDict objectForKey:@"module_id"];
        self.name = [contentDict objectForKey:@"name"];
        self.index = [contentDict objectForKey:@"index"];
        self.categoryId = [contentDict objectForKey:@"id"];
        self.icon = [contentDict objectForKey:@"icon"];
        self.isLocalIcon = [contentDict objectForKey:@"is_local_icon"];
    }
    return self;
}
- (void)dealloc
{
    self.moduleId = nil;
    self.index = nil;
    self.name = nil;
    self.categoryId = nil;
    self.isLocalIcon = nil;
    self.icon = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.moduleId = [aDecoder decodeObjectForKey:@"moduleId"];
        self.index = [aDecoder decodeObjectForKey:@"index"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
        self.isLocalIcon = [aDecoder decodeObjectForKey:@"isLocalIcon"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.moduleId forKey:@"moduleId"];
    [aCoder encodeObject:self.index forKey:@"index"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.isLocalIcon forKey:@"isLocalIcon"];

}

@end
