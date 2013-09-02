//
//  ZYNewsDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYNewsDataCenter.h"

@implementation ZYNewsDataCenter

- (void)startGetNewsListWithPageIndex:(NSInteger)pageIndex withCategoryId:(NSString *)categoryId withTabTypeId:(NSString *)tabTypeId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:categoryId forKey:@"categoryId"];
    [params setObject:tabTypeId forKey:@"tabTypeId"];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeNewsList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getNewsListSuccess:" withFaildRequestMethod:@"getNewsListFaild:"];
}
- (void)getNewsListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"listSuccess"]) {
            
            GetNewsListSuccessAction successAction = [self.actionsDict objectForKey:@"listSuccess"];
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0; i<resultArray.count; i++) {
                
                ZYNewsModel *model = [[ZYNewsModel alloc]initWithSummaryContent:[resultArray objectAtIndex:i]];
                [modelArray addObject:model];
                [model release];
            }
            
            successAction(modelArray);
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"listFaild"]) {
            
            GetNewsListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)getNewsListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"listFaild"]) {
        
        GetNewsListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
                
        faildAction(NetWorkError);
    }
}
- (void)startGetTabTypesByCategoryId:(NSString *)categoryId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:categoryId forKey:@"categoryId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeTabType withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getTabTypesSuccess:" withFaildRequestMethod:@"getTabTypesFaild:"];
}
- (void)getTabTypesSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"tabSuccess"]) {
            
            GetTabTypesSuccessAction successAction = [self.actionsDict objectForKey:@"tabSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            
            for (int i =0;i<resultArray.count;i++) {
                
                NSDictionary *oldItem = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                [newItem setObject:[oldItem objectForKey:@"id"] forKey:@"type_id"];
                
                ZYTabTypeModel *typeModel = [[ZYTabTypeModel alloc]initWithContentDict:newItem];
                [modelArray addObject:typeModel];
                [typeModel release];
                
            }
            
            successAction(modelArray);
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"tabFaild"]) {
            
            GetTabTypesFaildAction faildAction = [self.actionsDict objectForKey:@"tabFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
    }
}
- (void)getTabTypesFaild:(NSDictionary *)resultDict
{
    if ([self.actionsDict objectForKey:@"tabFaild"]) {
        
        GetTabTypesFaildAction faildAction = [self.actionsDict objectForKey:@"tabFaild"];
                
        faildAction(NetWorkError);
    }
}
- (void)commentArticleWithId:(NSString *)articleId withContent:(NSString *)content
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:content forKey:@"content"];
    
    [params setObject:articleId forKey:@"articleId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCommentArticle withParams:params withHelperDelegate:self withSuccessRequestMethod:@"commentArticleSuccess:" withFaildRequestMethod:@"commentArticleFaild:"];
}
- (void)commentArticleSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed: resultDict]) {
        
        if ([self.actionsDict objectForKey:@"commentSuccess"]) {
            
            CommentNewsSuccessAction successAction = [self.actionsDict objectForKey:@"commentSuccess"];
            
            NSDictionary *resultComment = [resultDict objectForKey:@"data"];
            
            ZYCommentModel *commentModel = [[ZYCommentModel alloc]initWithSummaryDict:resultComment];
            
            successAction (commentModel);
            
            [commentModel release];
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"commentFaild"]) {
            
            CommentNewsFaildAction faildAction = [self.actionsDict objectForKey:@"commentFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
    }
}
- (void)commentArticleFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"commentFaild"]) {
        
        CommentNewsFaildAction faildAction = [self.actionsDict objectForKey:@"commentFaild"];
                
        faildAction(NetWorkError);
    }
}
- (void)favoriteArticleWithId:(NSString *)articleId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:articleId forKey:@"articleId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoriteArticle withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteArticleSuccess:" withFaildRequestMethod:@"favoriteArticleFaild:"];
}
- (void)favoriteArticleSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"favoriteSuccess"]) {
            
            FavoriteNewsSuccessAction successAction = [self.actionsDict objectForKey:@"favoriteSuccess"];
            successAction(@"收藏成功");
            
        }
        
    }else{
     
        if ([self.actionsDict objectForKey:@"favoriteFaild"]) {
            
            FavoriteNewsFaildAction faildAction = [self.actionsDict objectForKey:@"favoriteFaild"];
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            faildAction(errMsg);
        }
        
    }
}
- (void)favoriteArticleFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"favoriteFaild"]) {
        
        FavoriteNewsFaildAction faildAction = [self.actionsDict objectForKey:@"favoriteFaild"];
        faildAction(NetWorkError);
    }
}
- (void)startGetArticleCommentListWithArticleId:(NSString *)articleId withPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:articleId forKey:@"articleId"];
    [params setObject:[NSNumber numberWithInt:pageIndex]  forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeArticleComment withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getCommentListSuccess:" withFaildRequestMethod:@"getCommentListFaild:"];
}
- (void)getCommentListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"commentListSuccess"]) {
            
            GetArticleCommentListSuccessAction successAction = [self.actionsDict objectForKey:@"commentListSuccess"];
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            
            for (int i=0; i<resultArray.count;i++) {
                
                NSDictionary *oldItem = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                
                ZYCommentModel *commentModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
                [modelArray addObject:commentModel];
                [commentModel release];
                
            }
            
            successAction(modelArray);
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"commentListFaild"]) {
            
            GetArticleCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"commentListFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)getCommentListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"commentListFaild"]) {
        
        GetArticleCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"commentListFaild"];
                
        faildAction(NetWorkError);
    }
}

- (void)setGetNewsListSuccessAction:(GetNewsListSuccessAction)successAction
{
    GetNewsListSuccessAction listSuccess = [successAction copy];
    [self.actionsDict setObject:listSuccess forKey:@"listSuccess"];
    [listSuccess release];
}
- (void)setGetNewsListFaildAction:(GetNewsListFaildAction)faildAction
{
    GetNewsListFaildAction listFaild = [faildAction copy];
    [self.actionsDict setObject:listFaild forKey:@"listFaild"];
    [listFaild release];
}
- (void)setCommentArticleSuccessAction:(CommentNewsSuccessAction)successAction
{
    CommentNewsSuccessAction commentSuccess = [successAction copy];
    [self.actionsDict setObject:commentSuccess forKey:@"commentSuccess"];
    [commentSuccess release];
}
- (void)setCommentArticleFaildAction:(CommentNewsFaildAction)faildAction
{
    CommentNewsFaildAction commentFaild = [faildAction copy];
    [self.actionsDict setObject:commentFaild forKey:@"commentFaild"];
    [commentFaild release];
}
- (void)setFavoriteArticleSuccess:(FavoriteNewsSuccessAction)successAction
{
    FavoriteNewsSuccessAction favriteSuccess = [successAction copy];
    [self.actionsDict setObject:favriteSuccess forKey:@"favoriteSuccess"];
    [favriteSuccess release];
}
- (void)setFavoriteArticleFaild:(FavoriteNewsFaildAction)faildAction
{
    FavoriteNewsFaildAction favoriteFaild = [faildAction copy];
    [self.actionsDict setObject:favoriteFaild forKey:@"favoriteFaild"];
    [favoriteFaild release];
}
- (void)setGetArticleCommentListSuccessAction:(GetArticleCommentListSuccessAction)successAction
{
    GetArticleCommentListSuccessAction commentListSuccess = [successAction copy];
    [self.actionsDict setObject:commentListSuccess forKey:@"commentListSuccess"];
    [commentListSuccess release];
}
- (void)setGetArticleCommentListFaildAction:(GetArticleCommentListFaildAction)faildAction
{
    GetArticleCommentListFaildAction commentListFaild = [faildAction copy];
    [self.actionsDict setObject:commentListFaild forKey:@"commentListFaild"];
    [commentListFaild release];
}
- (void)setGetTabTypesSuccessAction:(GetTabTypesSuccessAction)successAction
{
    GetTabTypesSuccessAction tabTypeSuccess = [successAction copy];
    [self.actionsDict setObject:tabTypeSuccess forKey:@"tabSuccess"];
    [tabTypeSuccess release];
}
- (void)setGetTabTypesFaildAction:(GetTabTypesFaildAction)faildAction
{
    GetTabTypesFaildAction tabTypeFaild = [faildAction copy];
    [self.actionsDict setObject:tabTypeFaild forKey:@"tabFaild"];
    [tabTypeFaild release];
}

@end
