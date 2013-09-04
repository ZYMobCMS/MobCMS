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

- (id)init
{
    if (self = [super init]) {
        _actionsDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)dealloc
{
    [_actionsDict release];
    [super dealloc];
}

@end
