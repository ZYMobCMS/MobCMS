//
//  ZYTabTypeModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYTabTypeModel.h"

@implementation ZYTabTypeModel
@synthesize tabTypeId,name;

- (id)initWithContentDict:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.tabTypeId = [contentDict objectForKey:@"id"];
        self.name = [contentDict objectForKey:@"type_name"];
        
    }
    return self;
}
- (void)dealloc
{
    self.tabTypeId = nil;
    self.name = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.tabTypeId = [aDecoder decodeObjectForKey:@"tabTypeId"];
        self.name = [aDecoder decodeObjectForKey:@"name"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.tabTypeId forKey:@"tabTypeId"];
    [aCoder encodeObject:self.name forKey:@"name"];

}

@end
