//
//  ZYUserActiveModel.m
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-2.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYUserActiveModel.h"

@implementation ZYUserActiveModel
@synthesize relationId,relationImages,relationTable,relationTitle,content,createLoginName,createNickName,createTime,userActiveOpen;

- (void)dealloc
{
    self.relationTitle = nil;
    self.relationTable = nil;
    self.relationImages = nil;
    self.relationId = nil;
    self.createTime = nil;
    self.createNickName = nil;
    self.createLoginName = nil;
    self.content = nil;
    self.userActiveOpen = nil;
    [super dealloc];
}

- (id)initWithContentDict:(NSDictionary *)contentDict
{
    if (self = [super init]) {

        self.relationId = [contentDict objectForKey:@"relation_id"];
        self.relationTable = [contentDict objectForKey:@"relation_table"];
        self.relationImages = [contentDict objectForKey:@"relation_images"];
        self.relationTitle = [contentDict objectForKey:@"relation_title"];
        self.createLoginName = [contentDict objectForKey:@"create_login_name"];
        self.createNickName = [contentDict objectForKey:@"create_nick_name"];
        self.createTime = [contentDict objectForKey:@"create_time"];
        self.content = [contentDict objectForKey:@"content"];
        self.userActiveOpen = [contentDict objectForKey:@"user_actvie_open"];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.relationId = [aDecoder decodeObjectForKey:@"relationId"];
        self.relationTable = [aDecoder decodeObjectForKey:@"relationTable"];
        self.relationImages = [aDecoder decodeObjectForKey:@"relationImages"];
        self.relationTitle = [aDecoder decodeObjectForKey:@"relationTitle"];
        self.createLoginName = [aDecoder decodeObjectForKey:@"createLoginName"];
        self.createNickName = [aDecoder decodeObjectForKey:@"createNickName"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.userActiveOpen = [aDecoder decodeObjectForKey:@"userActiveOpen"];

        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.relationId forKey:@"relationId"];
    [aCoder encodeObject:self.relationTable forKey:@"relationTable"];
    [aCoder encodeObject:self.relationImages forKey:@"relationImages"];
    [aCoder encodeObject:self.relationTitle forKey:@"relationTitle"];
    [aCoder encodeObject:self.createLoginName forKey:@"createLoginName"];
    [aCoder encodeObject:self.createNickName forKey:@"createNickName"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.userActiveOpen forKey:@"userActiveOpen"];

}
@end
