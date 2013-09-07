//
//  ZYApplicationModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYApplicationModel.h"

@implementation ZYApplicationModel
@synthesize name;

- (id)initWithContentDict:(NSDictionary *)content
{
    if (self = [super init]) {
        
        self.name = [content objectForKey:@"name"];
    }
    return self;
}
- (void)dealloc
{
    self.name = nil;
    [super dealloc];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
}
@end
