//
//  ZYCacheCenter.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-25.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZYCMSCacheBaseDir @"cacheCenter"

@interface ZYCacheCenter : NSObject
{
    NSInteger maxCachePageCount;
    
    NSMutableDictionary *runTimeCachePool;
    
}

+ (ZYCacheCenter *)shareCenter;

- (void)cacheDataWithRequestType:(ZYCMSRequestType)requestType withData:(NSData*)data withConfig:(NSDictionary*)config;

- (NSData*)readCacheWithRequestType:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config ;

- (void)cacheDataWithRequestType:(ZYCMSRequestType)requestType withArray:(NSArray*)dArray withConfig:(NSDictionary*)config ;
- (NSArray*)readCacheArrayWithRequestType:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config ;

- (void)cacheDataWithRequestType:(ZYCMSRequestType)requestType withDict:(NSDictionary*)dict withConfig:(NSDictionary*)config ;
- (NSDictionary*)readCacheDictWithRequestType:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config ;

- (void)clearAllCache;

- (BOOL)isRequestTypeNeedRefreshData:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config;

- (BOOL)isRequestTypeCacheDataExist:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config;

@end
