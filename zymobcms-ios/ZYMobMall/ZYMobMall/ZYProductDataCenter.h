//
//  ZYProductDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYProductModel.h"
#import "ZYTabTypeModel.h"
#import "ZYCommentModel.h"

typedef void (^GetProductListSuccessAction) (NSArray *listArray);
typedef void (^GetProductListFaildAction)   (NSString *errMsg);
typedef void (^GetProductTabTypeSuccessAction) (NSArray *listArray);
typedef void (^GetProductTabTypeFaildAction) (NSString *errMsg);
typedef void (^GetProductDetailSuccessAction) (ZYProductModel *proudctModel);
typedef void (^GetProductDetailFaildAction) (NSString *errMsg);
typedef void (^GetProductCommentListSuccessAction) (NSArray *modelArray);
typedef void (^GetProductCommentListFaildAction) (NSString *errMsg);
typedef void (^CommentProductSuccessAction) (ZYCommentModel *commentModel);
typedef void (^CommentProductFaildAction) (NSString *errMsg);
typedef void (^FavoriteProductSuccessAction) (NSString *successMsg);
typedef void (^FavoriteProductFaildAction) (NSString *errMsg);

@interface ZYProductDataCenter : ZYBaseDataCenter

- (void)startGetProductListWithCategorId:(NSString*)categoryId withTabTypeId:(NSString*)tabTypeId withPageIndex:(NSInteger)pageIndex;
- (void)startGetProductTabTypeWithCategoryId:(NSString*)categoryId;
- (void)startGetProductDetailWithProductId:(NSString *)productId;
- (void)startGetProductCommentListWithPictureId:(NSString*)productId withPageIndex:(NSInteger)pageIndex;
- (void)commentProductWithProductId:(NSString *)productId withContent:(NSString*)content;
- (void)favoriteProductWithProductId:(NSString *)productId;


- (void)setGetProductListSuccessAction:(GetProductListSuccessAction)successAction;
- (void)setGetProudctListFaildAction:(GetProductListFaildAction)faildAction;

- (void)setGetProudctTabTypeSuccessAction:(GetProductTabTypeSuccessAction)successAction;
- (void)setgetProudctTabTypeFaildAction:(GetProductTabTypeFaildAction)faildAction;

- (void)setGetProductDetailSuccessAction:(GetProductDetailSuccessAction)successAction;
- (void)setGetProductDetailFaildAction:(GetProductDetailFaildAction)faildAction;

- (void)setGetProductCommentListSuccessAction:(GetProductCommentListSuccessAction)successAction;
- (void)setGetProductCommentListFaildAction:(GetProductCommentListFaildAction)faildAction;

- (void)setCommentProductSuccessAction:(CommentProductSuccessAction)successAction;
- (void)setCommentProductFaildAction:(CommentProductFaildAction)faildAction;

- (void)setFavoriteProductSuccessAction:(FavoriteProductSuccessAction)successAction;
- (void)setFavoriteProductFaildAction:(FavoriteProductFaildAction)faildAction;

@end
