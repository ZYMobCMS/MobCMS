//
//  ZYTabTypeModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYTabTypeModel.h"

@implementation ZYTabTypeModel
@synthesize tabTypeId,name,icon,isLocalIcon;

- (id)initWithContentDict:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.tabTypeId = [contentDict objectForKey:@"type_id"];
        self.name = [contentDict objectForKey:@"type_name"];
        self.icon = [contentDict objectForKey:@"icon"];
        self.isLocalIcon = [contentDict objectForKey:@"is_local_icon"];
        
    }
    return self;
}
- (void)dealloc
{
    self.tabTypeId = nil;
    self.name = nil;
    self.icon = nil;
    self.isLocalIcon = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.tabTypeId = [aDecoder decodeObjectForKey:@"tabTypeId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.isLocalIcon = [aDecoder decodeObjectForKey:@"isLocalIcon"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.tabTypeId forKey:@"tabTypeId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.isLocalIcon forKey:@"isLocalIcon"];
    [aCoder encodeObject:self.icon forKey:@"icon"];

}

@end
