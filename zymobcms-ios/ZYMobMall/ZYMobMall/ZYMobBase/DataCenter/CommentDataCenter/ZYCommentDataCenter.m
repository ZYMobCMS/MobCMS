//
//  ZYCommentDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYCommentDataCenter.h"

@implementation ZYCommentDataCenter

- (void)startGetHotCommentListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeHotCommentList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getHotCommentListSuccess:" withFaildRequestMethod:@"getHotCommentListFaild:"];
    [self.requestFlags addObject:requestFlag];
}
- (void)getHotCommentListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"hotSuccess"]) {
            
            GetHotCommentListSuccessAction successAction = [self.actionsDict objectForKey:@"hotSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0;i<resultArray.count;i++) {
                
                NSDictionary *oldItem = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                [newItem setObject:[oldItem objectForKey:@"article_id"] forKey:@"relation_id"];
                ZYCommentModel *model = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
                [modelArray addObject:model];
                [model release];
            }
            
            successAction (modelArray);
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"hotFaild"]) {
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            GetHotCommentLIstFaildAction faildAction = [ self.actionsDict objectForKey:@"hotFaild"];
            
            faildAction(errMsg);
            
        }
        
    }
}
- (void)getHotCommentListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"hotFaild"]) {
                
        GetHotCommentLIstFaildAction faildAction = [ self.actionsDict objectForKey:@"hotFaild"];
        
        faildAction(NetWorkError);
        
    }
}

- (void)setGetHotCommentListSuccessAction:(GetHotCommentListSuccessAction)successAction
{
    GetHotCommentListSuccessAction hotSuccessAction =  [successAction copy];
    [self.actionsDict setObject:hotSuccessAction forKey:@"hotSuccess"];
    [hotSuccessAction release];
}
- (void)setGetHOtCommentListFaildAction:(GetHotCommentLIstFaildAction)faildAction
{
    GetHotCommentLIstFaildAction hotFaildAction = [faildAction copy];
    [self.actionsDict setObject:hotFaildAction forKey:@"hotFaild"];
    [hotFaildAction release];
}

- (void)cancelAllRequestNow
{
    for (NSString *requestFlag in self.requestFlags) {
        
        [[BFNetWorkHelper shareHelper]cancelRequestWithTimeStamp:requestFlag];
    }
}

@end
