//
//  ZYProductDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYProductDataCenter.h"


@implementation ZYProductDataCenter

- (void)startGetProductListWithCategorId:(NSString*)categoryId withTabTypeId:(NSString*)tabTypeId withPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    [params setObject:categoryId forKey:@"categoryId"];
    [params setObject:tabTypeId forKey:@"tabTypeId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getProductListSuccess:" withFaildRequestMethod:@"getProductListFaild:"];
}
- (void)getProductListSuccess:(NSDictionary *)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        
        NSMutableArray *modelArray = [NSMutableArray array];
        for (int i=0; i<resultArray.count; i++) {
            
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSDictionary *oldItem = [resultArray objectAtIndex:i];
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
            [newItem setObject:[oldItem objectForKey:@"id"] forKey:@"product_id"];
             
            ZYProductModel *model = [[ZYProductModel alloc]initWithSummaryContentDict:newItem];
            [modelArray addObject:model];
            [model release];
            [pool release];
        }
        
        if ([self.actionsDict objectForKey:@"listSuccess"]) {
        
            GetProductListSuccessAction successAction = [self.actionsDict objectForKey:@"listSuccess"];
            successAction (modelArray);
        }
        
    }else{
        
        if([self.actionsDict objectForKey:@"listFaild"]){
            
            GetProductListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
            NSString *msg = [resultDict objectForKey:@"msg"];
            faildAction(msg);
        }
        
    }
}
- (void)getProductListFaild:(NSDictionary*)resultDict
{
    if([self.actionsDict objectForKey:@"listFaild"]){
        
        GetProductListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
        faildAction(NetWorkError);
    }
}

- (void)startGetProductTabTypeWithCategoryId:(NSString*)categoryId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:categoryId forKey:@"categoryId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductTabTypes withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getAllTabTypesSuccess:" withFaildRequestMethod:@"getAllTabTypesFaild:"];
}
- (void)getAllTabTypesSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        NSMutableArray *modelArray = [NSMutableArray array];
        
        for (int i=0; i<resultArray.count;i++) {
            
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSDictionary *oldItem = [resultArray objectAtIndex:i];
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
            [newItem setObject:[oldItem objectForKey:@"id"] forKey:@"type_id"];
            
            ZYTabTypeModel *tabTypeModel = [[ZYTabTypeModel alloc]initWithContentDict:newItem];
            [modelArray addObject:tabTypeModel];
            [tabTypeModel release];
            [pool drain];
        }
        
        if ([self.actionsDict objectForKey:@"tabSuccess"]) {
            
            GetProductTabTypeSuccessAction successAction = [self.actionsDict objectForKey:@"tabSuccess"];
            successAction(modelArray);
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"tabFaild"]) {
            
            GetProductTabTypeFaildAction faildAction = [self.actionsDict objectForKey:@"tabFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)getAllTabTypesFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"tabFaild"]) {
        
        GetProductTabTypeFaildAction faildAction = [self.actionsDict objectForKey:@"tabFaild"];
                
        faildAction(NetWorkError);
    }
}

- (void)startGetProductDetailWithProductId:(NSString *)productId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setObject:productId forKey:@"productId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getProductDetailSucess:" withFaildRequestMethod:@"getProductDetailFaild:"];
}
- (void)getProductDetailSucess:(NSDictionary *)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"detailSuccess"]) {
            
            NSDictionary *oldItem = [resultDict objectForKey:@"data"];
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
            
            [newItem setObject:[oldItem objectForKey:@"id"] forKey:@"product_id"];
            
            ZYProductModel *productModel = [[ZYProductModel alloc]initWithDetailContentDict:newItem];

            GetProductDetailSuccessAction successAction = [self.actionsDict objectForKey:@"detailSuccess"];
            successAction(productModel);
            [productModel release];
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"detailFaild"]) {
            GetProductDetailFaildAction faildAction = [self.actionsDict objectForKey:@"detailFaild"];
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            faildAction(errMsg);
        }
        
    }
}
- (void)getProductDetailFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"detailFaild"]) {
        GetProductDetailFaildAction faildAction = [self.actionsDict objectForKey:@"detailFaild"];
        faildAction(NetWorkError);
    }
}
- (void)startGetProductCommentListWithPictureId:(NSString *)productId withPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:productId forKey:@"productId"];
    [params setObject:[NSNumber numberWithInt:pageIndex]  forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductCommentList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getCommentListSuccess:" withFaildRequestMethod:@"getCommentListFaild:"];
}
- (void)getCommentListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"commentListSuccess"]) {
            
            GetProductCommentListSuccessAction successAction = [self.actionsDict objectForKey:@"commentListSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            
            for (int i=0; i<resultArray.count;i++) {
                
                NSDictionary *oldItem = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                [newItem setObject:[oldItem objectForKey:@"product_id"] forKey:@"relation_id"];
                
                ZYCommentModel *model = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
                [modelArray addObject:model];
                [model release];
            }
            
            successAction(modelArray);
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"commentListFaild"]) {
            
            GetProductCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"commentListFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)getCommentListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"commentListFaild"]) {
        
        GetProductCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"commentListFaild"];
                
        faildAction(NetWorkError);
    }
}
- (void)commentProductWithProductId:(NSString *)productId withContent:(NSString *)content
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:content forKey:@"content"];
    
    [params setObject:productId forKey:@"productId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCommentProduct withParams:params withHelperDelegate:self withSuccessRequestMethod:@"commentProductSuccess:" withFaildRequestMethod:@"commentProductFaild:"];
}
- (void)commentProductSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"commentSuccess"]) {
            
            CommentProductSuccessAction successAction = [self.actionsDict objectForKey:@"commentSuccess"];
            
            NSDictionary *oldItem = [resultDict objectForKey:@"data"];
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
            [newItem setObject:[oldItem objectForKey:@"product_id"] forKey:@"relation_id"];
            
            ZYCommentModel *commentModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
            
            successAction(commentModel);
            
            [commentModel release];
        }
        
        
    }else{
        
        if ([self.actionsDict objectForKey:@"commentFaild"]) {
            
            CommentProductFaildAction faildAction = [self.actionsDict objectForKey:@"commentFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)commentProductFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"commentFaild"]) {
        
        CommentProductFaildAction faildAction = [self.actionsDict objectForKey:@"commentFaild"];
        
        faildAction(NetWorkError);
    }
    
}
- (void)favoriteProductWithProductId:(NSString *)productId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:productId forKey:@"productId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoriteProduct withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteProductSuccess:" withFaildRequestMethod:@"favoriteProductFaild:"];
}
- (void)favoriteProductSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"favoriteSuccess"]) {
            
            FavoriteProductSuccessAction successAction = [self.actionsDict objectForKey:@"favoriteSuccess"];
            
            successAction(@"收藏成功");
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"favoriteFaild"]) {
            
            FavoriteProductFaildAction faildAction = [self.actionsDict objectForKey:@"favoriteFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)favoriteProductFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"favoriteFaild"]) {
        
        FavoriteProductFaildAction faildAction = [self.actionsDict objectForKey:@"favoriteFaild"];
        
        faildAction(NetWorkError);
    }
}

- (void)setGetProductListSuccessAction:(GetProductListSuccessAction)successAction
{
    GetProductListSuccessAction prodcutSuccess = [successAction copy];
    [self.actionsDict setObject:prodcutSuccess forKey:@"listSuccess"];
    [prodcutSuccess release];
}
- (void)setGetProudctListFaildAction:(GetProductListFaildAction)faildAction
{
    GetProductListFaildAction productFaild = [faildAction copy];
    [self.actionsDict setObject:productFaild forKey:@"listFaild"];
    [productFaild release];
}

- (void)setGetProudctTabTypeSuccessAction:(GetProductTabTypeSuccessAction)successAction
{
    GetProductTabTypeSuccessAction tabSuccess = [successAction copy];
    [self.actionsDict setObject:tabSuccess forKey:@"tabSuccess"];
    [tabSuccess release];
}
- (void)setgetProudctTabTypeFaildAction:(GetProductTabTypeFaildAction)faildAction
{
    GetProductTabTypeFaildAction tabFaild = [faildAction copy];
    [self.actionsDict setObject:tabFaild forKey:@"tabFaild"];
    [tabFaild release];
}

- (void)setGetProductDetailSuccessAction:(GetProductDetailSuccessAction)successAction
{
    GetProductDetailSuccessAction detailSucces = [successAction copy];
    [self.actionsDict setObject:detailSucces forKey:@"datailSuccess"];
    [detailSucces release];
}
- (void)setGetProductDetailFaildAction:(GetProductDetailFaildAction)faildAction
{
    GetProductDetailFaildAction detailFaild = [faildAction copy];
    [self.actionsDict setObject:detailFaild forKey:@"detailFaild"];
    [detailFaild release];
}
- (void)setGetProductCommentListSuccessAction:(GetProductCommentListSuccessAction)successAction
{
    GetProductCommentListSuccessAction commentListSuccess = [successAction copy];
    [self.actionsDict setObject:commentListSuccess forKey:@"commentListSuccess"];
    [commentListSuccess release];
}
- (void)setGetProductCommentListFaildAction:(GetProductCommentListFaildAction)faildAction
{
    GetProductCommentListFaildAction commentListFaild = [faildAction copy];
    [self.actionsDict setObject:commentListFaild forKey:@"commentListFaild"];
    [commentListFaild release];
}
- (void)setCommentProductSuccessAction:(CommentProductSuccessAction)successAction
{
    CommentProductSuccessAction commentSuccess = [successAction copy];
    [self.actionsDict setObject:commentSuccess forKey:@"commentSuccess"];
    [commentSuccess release];
}
- (void)setCommentProductFaildAction:(CommentProductFaildAction)faildAction
{
    CommentProductFaildAction commentFaild = [faildAction copy];
    [self.actionsDict setObject:commentFaild forKey:@"commentFaild"];
    [commentFaild release];
}
- (void)setFavoriteProductSuccessAction:(FavoriteProductSuccessAction)successAction
{
    FavoriteProductSuccessAction favoriteSuccess = [successAction copy];
    [self.actionsDict setObject:favoriteSuccess forKey:@"favoriteSuccess"];
    [favoriteSuccess release];
}
- (void)setFavoriteProductFaildAction:(FavoriteProductFaildAction)faildAction
{
    FavoriteProductFaildAction favoriteFaild = [faildAction copy];
    [self.actionsDict setObject:favoriteFaild forKey:@"favoriteFaild"];
    [favoriteFaild release];
}

@end
