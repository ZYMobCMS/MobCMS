//
//  ZYBaseDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-28.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseDataCenter.h"

@implementation ZYBaseDataCenter
@synthesize actionsDict = _actionsDict;
@synthesize requestFlags = _requestFlags;

- (id)init
{
    if (self = [super init]) {
        _actionsDict = [[NSMutableDictionary alloc]init];
        _requestFlags = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc
{
    [self cancelAllRequestNow];
    [_actionsDict release];
    [_requestFlags release];
    [super dealloc];
}

- (void)cancelAllRequestNow
{    
    for (NSString *requestFlag in self.requestFlags) {
        
        [[BFNetWorkHelper shareHelper]cancelRequestWithTimeStamp:requestFlag];
    }
}

@end
