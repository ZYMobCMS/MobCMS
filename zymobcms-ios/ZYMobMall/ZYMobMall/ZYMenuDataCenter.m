//
//  ZYMenuDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYMenuDataCenter.h"

@implementation ZYMenuDataCenter
- (id)init
{
    self = [super init];
    if (self) {
        _actionsDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [_actionsDict release];
    [super dealloc];
}

- (void)startGetMenuList
{
    
}
- (void)getMenuListSuccess:(NSDictionary*)resultDict
{
    
}
- (void)getMenuListFaild:(NSDictionary*)resultDict
{
    
}
- (void)startGetApplicationInfo
{
    
}
- (void)getApplicationInfoSuccess:(NSDictionary*)resultDict
{
    
}
- (void)getApplicaitonInfoFaild:(NSDictionary*)resultDict
{
    
}


@end
