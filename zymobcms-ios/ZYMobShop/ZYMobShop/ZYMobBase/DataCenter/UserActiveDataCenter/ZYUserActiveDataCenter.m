//
//  ZYUserActiveDataCenter.m
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-2.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYUserActiveDataCenter.h"

@implementation ZYUserActiveDataCenter

- (void)startGetUserActiveListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserPublicHome withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPublicHomeListSuccess:" withFaildRequestMethod:@"getPublicHomeListFaild:"];
    [self.requestFlags addObject:requestFlag];
}
- (void)getPublicHomeListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"listSuccess"]) {
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            
            for (int i=0; i<resultArray.count; i++) {
                
                ZYUserActiveModel *model = [[ZYUserActiveModel alloc]initWithContentDict:[resultArray objectAtIndex:i]];
                [modelArray addObject:model];
                [model release];
                
            }
            
            GetUserActiveListSuccessAction successAction = [self.actionsDict objectForKey:@"listSuccess"];
            successAction(modelArray);
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"listFaild"]) {
            
            GetUserActiveListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
            
        }
        
    }
}
- (void)getPublicHomeListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"listFaild"]) {
        
        GetUserActiveListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
                
        faildAction(NetWorkError);
        
    }
}

- (void)setGetUserActiveListSuccess:(GetUserActiveListSuccessAction)successAction
{
    GetUserActiveListSuccessAction listSuccess = [successAction copy];
    [self.actionsDict setObject:listSuccess forKey:@"listSuccess"];
    [listSuccess release];
     
}

- (void)setGetUserActiveListFaild:(GetUserActiveListFaildAction)faildAction
{
    GetUserActiveListFaildAction listFaild = [faildAction copy];
    [self.actionsDict setObject:listFaild forKey:@"listFaild"];
    [listFaild release];
    
}

- (void)cancelAllRequestNow
{
    for (NSString *requestFlag in self.requestFlags) {
        
        [[BFNetWorkHelper shareHelper]cancelRequestWithTimeStamp:requestFlag];
    }
}

@end
