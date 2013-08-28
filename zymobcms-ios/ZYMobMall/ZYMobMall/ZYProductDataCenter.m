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
    
}
- (void)getProductListFaild:(NSDictionary*)resultDict
{
    
}

- (void)startGetProductTabTypeWithCategoryId:(NSString*)categoryId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:categoryId forKey:@"categoryId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductTabTypes withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getAllTabTypesSuccess:" withFaildRequestMethod:@"getAllTabTypesFaild:"];
}
- (void)getAllTabTypesSuccess:(NSDictionary*)resultDict
{
    
}
- (void)getAllTabTypesFaild:(NSDictionary*)resultDict
{
    
}

- (void)startGetProductDetailWithProductId:(NSString *)productId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setObject:productId forKey:@"productId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getProductDetailSucess:" withFaildRequestMethod:@"getProductDetailFaild:"];
}
- (void)getProductDetailSucess:(NSDictionary *)resultDict
{
    
}
- (void)getProductDetailFaild:(NSDictionary*)resultDict
{
    
}

- (void)setGetProductListSuccessAction:(GetProductListSuccessAction)successAction
{
    
}
- (void)setGetProudctListFaildAction:(GetProductListFaildAction)faildAction
{
    
}

- (void)setGetProudctTabTypeSuccessAction:(GetProductTabTypeSuccessAction)successAction
{
    
}
- (void)setgetProudctTabTypeFaildAction:(GetProductTabTypeFaildAction)faildAction
{
    
}

- (void)setGetProductDetailSuccessAction:(GetProductDetailSuccessAction)successAction
{
    
}
- (void)setGetProductDetailFaildAction:(GetProductDetailFaildAction)faildAction
{
    
}


@end
