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
            NSDictionary *allDict = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];

            NSArray *hotNews = [allDict objectForKey:@"hotNews"];
            NSArray *normalList = [allDict objectForKey:@"newsList"];
            
            if (hotNews.count>0) {
                NSMutableArray *hotArray = [NSMutableArray array];
                for (int i=0; i<hotNews.count; i++) {
                    
                    NSDictionary *oldItem = [hotNews objectAtIndex:i];
                    NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                    [newItem setObject:[oldItem objectForKey:@"id"] forKey:@"article_id"];
                    
                    ZYNewsModel *model = [[ZYNewsModel alloc]initWithSummaryContent:newItem];
                    [hotArray addObject:model];
                    [model release];
                }
                [modelArray addObject:hotArray];
            }
            
            for (int i=0; i<normalList.count; i++) {
                
                NSDictionary *oldItem = [normalList objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                [newItem setObject:[oldItem objectForKey:@"id"] forKey:@"article_id"];
                
                ZYNewsModel *model = [[ZYNewsModel alloc]initWithSummaryContent:newItem];
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
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:resultComment];
            [newItem setObject:[resultComment objectForKey:@"article_id"] forKey:@"relation_id"];
            [newItem setObject:@"0" forKey:@"isSupported"];
            
            ZYCommentModel *commentModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
            
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
            if ([errMsg isEqualToString:@"已经收藏过该文章"]) {
                
                if ([self.actionsDict objectForKey:@"favoriteSuccess"]) {
                    FavoriteNewsSuccessAction successAction = [self.actionsDict objectForKey:@"favoriteSuccess"];
                    
                    successAction(@"收藏成功");
                }
                
            }else{
                faildAction(errMsg);
            }
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
                [newItem setObject:[oldItem objectForKey:@"article_id"] forKey:@"relation_id"];
                
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
- (void)startGetNewsDetailWithArticleId:(NSString *)articleId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:articleId forKey:@"articleId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeArticleDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getNewsDetailSuccess:" withFaildRequestMethod:@"getNewsDetailFaild:"];
}
- (void)getNewsDetailSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"detailSuccess"]) {
            
            GetNewsDetailSuccessAction successAction = [self.actionsDict objectForKey:@"detailSuccess"];
            
            NSDictionary *resultItem = [resultDict objectForKey:@"data"];
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:resultItem];
            [newItem setObject:[resultItem objectForKey:@"id"] forKey:@"aritcle_id"];
            [newItem setObject:[ZYBaseModel replaceNBSPString:[resultItem objectForKey:@"content"]] forKey:@"content"];
            
            ZYNewsModel *newsModel = [[ZYNewsModel alloc]initWithDetailContent:newItem];
            
            successAction (newsModel);
            
            [newsModel release];
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"detailFaild"]) {
            
            GetNewsListFaildAction faildAction = [self.actionsDict objectForKey:@"detailFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction (errMsg);
            
        }
        
    }
    
}
- (void)getNewsDetailFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"detailFaild"]) {
        
        GetNewsListFaildAction faildAction = [self.actionsDict objectForKey:@"detailFaild"];
                
        faildAction (NetWorkError);
        
    }
}

- (void)supportCommentWithCommentId:(NSString *)commentId
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:commentId forKey:@"commentId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeSupportComment withParams:params withHelperDelegate:self withSuccessRequestMethod:@"supportCommentSuccess:" withFaildRequestMethod:@"supportCommentFaild:"];
}
- (void)supportCommentSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"supCommentSuccess"]) {
            
            SupportCommentSuccessAction successAction = [self.actionsDict objectForKey:@"supCommentSuccess"];
            
            successAction(@"支持成功");
        }
        
        
    }else{
        
        if ([self.actionsDict objectForKey:@"supCommentFaild"]) {
            
            SupportCommentFaildAction faildAction = [self.actionsDict objectForKey:@"supCommentFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)supportCommentFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"supCommentFaild"]) {
        
        SupportCommentFaildAction faildAction = [self.actionsDict objectForKey:@"supCommentFaild"];
                
        faildAction(NetWorkError);
    }
}

- (void)unSupportCommentWithCommentId:(NSString *)commentId
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:commentId forKey:@"commentId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUnSupportComment withParams:params withHelperDelegate:self withSuccessRequestMethod:@"unSupportCommentSuccess:" withFaildRequestMethod:@"unSupportCommentFaild:"];
}
- (void)unSupportCommentSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"unSupCommentSuccess"]) {
            
            unSupportCommentSuccessAction successAction = [self.actionsDict objectForKey:@"unSupCommentSuccess"];
            
            successAction(@"取消成功");
        }
        
        
    }else{
        
        if ([self.actionsDict objectForKey:@"unSupCommentFaild"]) {
            
            unSupportCommentFaildAction faildAction = [self.actionsDict objectForKey:@"unSupCommentFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)unSupportCommentFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"unSupCommentFaild"]) {
        
        unSupportCommentFaildAction faildAction = [self.actionsDict objectForKey:@"unSupCommentFaild"];
        
        faildAction(NetWorkError);
    }
}

- (void)unFavoriteArticleWithArticleId:(NSString *)articleId
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:articleId forKey:@"articleId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCancelFavoriteArticle withParams:params withHelperDelegate:self withSuccessRequestMethod:@"unFavoriteArticleSuccess:" withFaildRequestMethod:@"unFavoriteArticleFaild:"];
}
- (void)unFavoriteArticleSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"unFavSuccess"]) {
            
            unFavoriteArticleSuccessAction successAction = [self.actionsDict objectForKey:@"unFavSuccess"];
            
            successAction(@"取消收藏");
        }
        
        
    }else{
        
        if ([self.actionsDict objectForKey:@"unFavFaild"]) {
            
            unFavoriteArticleFaildAction faildAction = [self.actionsDict objectForKey:@"unFavFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)unFavoriteArticleFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"unFavFaild"]) {
        
        unFavoriteArticleFaildAction faildAction = [self.actionsDict objectForKey:@"unFavFaild"];
                
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
- (void)setGetNewsDetailSuccessAction:(GetNewsDetailSuccessAction)successAction
{
    GetNewsDetailSuccessAction detailSuccess = [successAction copy];
    [self.actionsDict setObject:detailSuccess forKey:@"detailSuccess"];
    [detailSuccess release];
}
- (void)setGetNewsDetailFaildAction:(GetNewsDetailFaildAction)faildAction
{
    GetNewsDetailFaildAction detailFaild = [faildAction copy];
    [self.actionsDict setObject:detailFaild forKey:@"detailFaild"];
    [detailFaild release];
}
- (void)setSupportCommentSuccessAction:(SupportCommentSuccessAction)successAction
{
    SupportCommentSuccessAction supCommentSuccess = [successAction copy];
    [self.actionsDict setObject:supCommentSuccess forKey:@"supCommentSuccess"];
    [supCommentSuccess release];
}
- (void)setSupportCommentFaildAction:(SupportCommentFaildAction)faildAction
{
    SupportCommentFaildAction supCommentFaild = [faildAction copy];
    [self.actionsDict setObject:supCommentFaild forKey:@"supCommentFaild"];
    [supCommentFaild release];
}
- (void)setUnSupportCommentSuccessAction:(unSupportCommentSuccessAction)successAction
{
    unSupportCommentSuccessAction unSupCommentSuccess = [successAction copy];
    [self.actionsDict setObject:unSupCommentSuccess forKey:@"unSupCommentSuccess"];
    [unSupCommentSuccess release];
}
- (void)setUnSupportCommentFaildAction:(unSupportCommentFaildAction)faildAction
{
    unSupportCommentFaildAction unSupCommentFaild = [faildAction copy];
    [self.actionsDict setObject:unSupCommentFaild forKey:@"unSupCommentFaild"];
    [unSupCommentFaild release];
}
- (void)setUnFavoriteArticleSuccess:(unFavoriteArticleSuccessAction)successAction
{
    unFavoriteArticleSuccessAction unFavSuccess = [successAction copy];
    [self.actionsDict setObject:unFavSuccess forKey:@"unFavSuccess"];
    [unFavSuccess release];
    
}
- (void)setUnFavoriteArticleFaild:(unFavoriteArticleFaildAction)faildAction
{
    unFavoriteArticleFaildAction unFavFaild = [faildAction copy];
    [self.actionsDict setObject:unFavFaild forKey:@"unFavFaild"];
    [unFavFaild release];
    
}

@end
