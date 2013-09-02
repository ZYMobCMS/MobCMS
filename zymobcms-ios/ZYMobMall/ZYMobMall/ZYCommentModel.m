//
//  ZYCommentModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYCommentModel.h"

@implementation ZYCommentModel
@synthesize commentId,relationId;
@synthesize content,createTime,createUserId,status,toUsers,title,supportCount,unsupportCount;
@synthesize isSupported;

- (void)dealloc
{
    self.content = nil;
    self.createUserId = nil;
    self.createTime = nil;
    self.status = nil;
    self.toUsers = nil;
    self.title = nil;
    self.supportCount = nil;
    self.unsupportCount = nil;
    
    self.commentId = nil;
    self.relationId = nil;
    
    self.isSupported = nil;
    [super dealloc];
}
- (id)initWithSummaryDict:(NSDictionary*)contentDict
{
    if (self = [super init]) {
        
        self.content = [contentDict objectForKey:@"content"];
        self.createUserId = [contentDict objectForKey:@"create_user"];
        self.createTime = [contentDict objectForKey:@"create_time"];
        self.status = [contentDict objectForKey:@"status"];
        self.toUsers = [contentDict objectForKey:@"to_users"];
        self.title = [contentDict objectForKey:@"title"];
        self.supportCount = [contentDict objectForKey:@"support_count"];
        self.unsupportCount = [contentDict objectForKey:@"unsupport_count"];
        
        self.commentId = [contentDict objectForKey:@"comment_id"];
        self.relationId  = [contentDict objectForKey:@"relation_id"];
        
        self.isSupported = [contentDict objectForKey:@"isSupported"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.createUserId = [aDecoder decodeObjectForKey:@"createUserId"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.toUsers = [aDecoder decodeObjectForKey:@"toUsers"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.supportCount = [aDecoder decodeObjectForKey:@"supportCount"];
        self.unsupportCount = [aDecoder decodeObjectForKey:@"unsupportCount"];
        self.commentId = [aDecoder decodeObjectForKey:@"commentId"];
        self.relationId = [aDecoder decodeObjectForKey:@"relationId"];

        self.isSupported = [aDecoder decodeObjectForKey:@"isSupported"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.createUserId forKey:@"createUserId"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.toUsers forKey:@"toUsers"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.supportCount forKey:@"supportCount"];
    [aCoder encodeObject:self.unsupportCount forKey:@"unsupportCount"];
    [aCoder encodeObject:self.commentId forKey:@"commentId"];
    [aCoder encodeObject:self.relationId forKey:@"relationId"];
    [aCoder encodeObject:self.isSupported forKey:@"isSupported"];
}
@end
