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

- (id)initWithContentDict:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)dealloc
{
    self.moduleId = nil;
    self.index = nil;
    self.name = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.moduleId = [aDecoder decodeObjectForKey:@"moduleId"];
        self.index = [aDecoder decodeObjectForKey:@"index"];
        self.name = [aDecoder decodeObjectForKey:@"name"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.moduleId forKey:@"moduleId"];
    [aCoder encodeObject:self.index forKey:@"index"];
    [aCoder encodeObject:self.name forKey:@"name"];

}

@end
