//
//  ZYProductDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GetProductListSuccessAction) (NSArray *listArray);
typedef void (^GetProductListFaildAction)   (NSString *errMsg);
typedef void (^GetProductTabTypeSuccessAction) (NSArray *listArray);
typedef void (^GetProductTabTypeFaildAction) (NSString *errMsg);
typedef void (^GetProductDetailSuccessAction) (NSArray *listArray);
typedef void (^GetProductDetailFaildAction) (NSString *errMsg);

@interface ZYProductDataCenter : ZYBaseDataCenter

- (void)startGetProductListWithCategorId:(NSString*)categoryId withTabTypeId:(NSString*)tabTypeId withPageIndex:(NSInteger)pageIndex;
- (void)startGetProductTabTypeWithCategoryId:(NSString*)categoryId;
- (void)startGetProductDetailWithProductId:(NSString *)productId;

- (void)setGetProductListSuccessAction:(GetProductListSuccessAction)successAction;
- (void)setGetProudctListFaildAction:(GetProductListFaildAction)faildAction;

- (void)setGetProudctTabTypeSuccessAction:(GetProductTabTypeSuccessAction)successAction;
- (void)setgetProudctTabTypeFaildAction:(GetProductTabTypeFaildAction)faildAction;

- (void)setGetProductDetailSuccessAction:(GetProductDetailSuccessAction)successAction;
- (void)setGetProductDetailFaildAction:(GetProductDetailFaildAction)faildAction;

@end
