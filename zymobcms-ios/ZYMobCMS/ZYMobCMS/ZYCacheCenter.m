//
//  ZYCacheCenter.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-25.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYCacheCenter.h"

#define CachePreKey @"cachePreKey_"
#define CacheExpiredTimeSize 7*1200*24

static ZYCacheCenter *_zycacheInstance = nil;
@implementation ZYCacheCenter

+ (ZYCacheCenter *)shareCenter
{
    @synchronized(self){
     
        if (!_zycacheInstance) {
            _zycacheInstance = [[self alloc]init];
        }
    }
    return _zycacheInstance;
}

- (id)init
{
    if (self = [super init]) {
        
        [self createCacheDirIsNotExist];
    }
    return self;
}

- (void)createCacheDirIsNotExist
{
    NSArray *bathPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *rootPath = [bathPaths objectAtIndex:0];
    NSString *dirPath = [rootPath stringByAppendingPathComponent:ZYCMSCacheBaseDir];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:dirPath]) {
        
        NSError *err = nil;
        [[NSFileManager defaultManager]createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&err];
        if (err) {
            NSLog(@"create cache dir error --->%@",err);
        }
    }
    
}
- (NSString*)cacheBasePath
{
    NSArray *bathPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *rootPath = [bathPaths objectAtIndex:0];
    NSString *dirPath = [rootPath stringByAppendingPathComponent:ZYCMSCacheBaseDir];
    
    return dirPath;
}

- (void)cacheDataWithRequestType:(ZYCMSRequestType)requestType withData:(NSData *)data withConfig:(NSDictionary*)config 
{
    NSString *configTag = nil;
    if (config) {
        if ([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]) {
            configTag = [NSString stringWithFormat:@"%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"]];
        }else if([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]&&[[config allKeys]containsObject:@"pageIndex"]){
            configTag = [NSString stringWithFormat:@"%@_%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"],[config objectForKey:@"pageIndex"]];
        }else{
            configTag = @"default";
        }
    }else{
        configTag = @"default";
    }
    
    
    NSString *currentTime = [BFUitils returnCurrentDateTime];
    
    NSMutableDictionary *cacheDict = [NSMutableDictionary dictionary];
    [cacheDict setObject:data forKey:currentTime];
    
    NSString *fileName = [NSString stringWithFormat:@"%@%d_%@",CachePreKey,requestType,configTag];
    NSString *filePath = [[self cacheBasePath]stringByAppendingPathComponent:fileName];
    
    NSData *cacheData = [self archieveDict:cacheDict];
    
    [cacheData writeToFile:filePath atomically:YES];
}

- (BOOL)isRequestTypeNeedRefreshData:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config 
{
    NSString *configTag = nil;
    if (config) {
        if ([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]) {
            configTag = [NSString stringWithFormat:@"%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"]];
        }else if([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]&&[[config allKeys]containsObject:@"pageIndex"]){
            configTag = [NSString stringWithFormat:@"%@_%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"],[config objectForKey:@"pageIndex"]];
        }else{
            configTag = @"default";
        }
    }else{
        configTag = @"default";
    }
    
   
    NSString *fileName = [NSString stringWithFormat:@"%@%d_%@",CachePreKey,requestType,configTag];
    NSString *filePath = [[self cacheBasePath]stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        
        NSData *cacheData = [NSData dataWithContentsOfFile:filePath];
        
        NSMutableDictionary *cacheDict = [NSMutableDictionary dictionaryWithDictionary:[self unarchieveToDict:cacheData]];
        
        NSString *timeStamp = [[cacheDict allKeys]objectAtIndex:0];
        
        NSDate  *cacheDate = [NSDate dateWithDateTimeString:timeStamp];
        NSDate *now = [NSDate date];
        
        NSTimeInterval checkDateIncrease = [now timeIntervalSinceDate:cacheDate];
        
        if (checkDateIncrease/(60*60*24*7)>1) {
            
            return YES;
        }else{
            return NO;
        }
        
    }else{
        return YES;
    }

}

- (BOOL)isRequestTypeCacheDataExist:(ZYCMSRequestType)requestType withConfig:(NSDictionary *)config
{
    NSString *configTag = nil;
    if (config) {
        if ([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]) {
            configTag = [NSString stringWithFormat:@"%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"]];
        }else if([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]&&[[config allKeys]containsObject:@"pageIndex"]){
            configTag = [NSString stringWithFormat:@"%@_%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"],[config objectForKey:@"pageIndex"]];
        }else{
            configTag = @"default";
        }
    }else{
        configTag = @"default";
    }
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@%d_%@",CachePreKey,requestType,configTag];
    NSString *filePath = [[self cacheBasePath]stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        
        return YES;
        
    }else{
        return NO;
    }

}

- (NSData*)readCacheWithRequestType:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config 
{
    NSString *configTag = nil;
    if (config) {
        if ([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]) {
            configTag = [NSString stringWithFormat:@"%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"]];
        }else if([[config allKeys]containsObject:@"type"]&&[[config allKeys]containsObject:@"Id"]&&[[config allKeys]containsObject:@"pageIndex"]){
            configTag = [NSString stringWithFormat:@"%@_%@_%@",[config objectForKey:@"type"],[config objectForKey:@"Id"],[config objectForKey:@"pageIndex"]];
        }else{
            configTag = @"default";
        }
    }else{
        configTag = @"default";
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%@%d_%@",CachePreKey,requestType,configTag];
    NSString *filePath = [[self cacheBasePath]stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        
        NSData *cacheData = [NSData dataWithContentsOfFile:filePath];
        
        NSMutableDictionary *cacheDict = [NSMutableDictionary dictionaryWithDictionary:[self unarchieveToDict:cacheData]];
        
        NSString *timeStamp = [[cacheDict allKeys]objectAtIndex:0];
        
        return [cacheDict objectForKey:timeStamp];

    }else{
        
        return nil;
        
    }
    
}

- (void)cacheDataWithRequestType:(ZYCMSRequestType)requestType withArray:(NSArray *)dArray withConfig:(NSDictionary*)config 
{
    [self cacheDataWithRequestType:requestType withData:[self archieveArray:dArray] withConfig:config];
}

- (NSArray*)readCacheArrayWithRequestType:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config 
{
    if ([self readCacheWithRequestType:requestType withConfig:config]) {
        return [self unarchieveDataToArray:[self readCacheWithRequestType:requestType withConfig:config]];
    }else{
        return nil;
    }
}

- (void)cacheDataWithRequestType:(ZYCMSRequestType)requestType withDict:(NSDictionary *)dict withConfig:(NSDictionary*)config 
{
    [self cacheDataWithRequestType:requestType withData:[self archieveDict:dict] withConfig:config];
}

- (NSDictionary*)readCacheDictWithRequestType:(ZYCMSRequestType)requestType withConfig:(NSDictionary*)config 
{
    if ([self readCacheWithRequestType:requestType withConfig:config]) {
        return [self unarchieveToDict:[self readCacheWithRequestType:requestType withConfig:config]];
    }else{
        return nil;
    }
    
}


- (void)clearAllCache
{
    NSArray *bathPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *rootPath = [bathPaths objectAtIndex:0];
    NSString *dirPath = [rootPath stringByAppendingPathComponent:ZYCMSCacheBaseDir];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:dirPath]) {
        
        NSError *err = nil;
        [[NSFileManager defaultManager]removeItemAtPath:dirPath error:&err];
        if (err) {
            NSLog(@"clear cache remove dir faild error --->%@",err);
        }
    }
    
}

- (NSData*)archieveArray:(NSArray*)dArray
{
    return [NSKeyedArchiver archivedDataWithRootObject:dArray];
}
- (NSArray*)unarchieveDataToArray:(NSData*)dData
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:dData];
}
- (NSData*)archieveDict:(NSDictionary*)dict
{
    return [NSKeyedArchiver archivedDataWithRootObject:dict];
}
- (NSDictionary*)unarchieveToDict:(NSData*)dData
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:dData];
}

@end
