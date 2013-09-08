//
//  ZYNewsDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYCommentModel.h"
#import "ZYNewsModel.h"
#import "ZYTabTypeModel.h"

typedef void (^GetNewsListSuccessAction) (NSArray *modelArray);
typedef void (^GetNewsListFaildAction) (NSString *errMsg);
typedef void (^GetNewsDetailSuccessAction) (ZYNewsModel *detailModel);
typedef void (^GetNewsDetailFaildAction) (NSString *errMsg);
typedef void (^CommentNewsSuccessAction) (ZYCommentModel *commentModel);
typedef void (^CommentNewsFaildAction) (NSString *errMsg);
typedef void (^FavoriteNewsSuccessAction) (NSString *successMsg);
typedef void (^FavoriteNewsFaildAction) (NSString *errMsg);
typedef void (^GetArticleCommentListSuccessAction) (NSArray *modelArray);
typedef void (^GetArticleCommentListFaildAction) (NSString *errMsg);
typedef void (^GetTabTypesSuccessAction) (NSArray *modelArray);
typedef void (^GetTabTypesFaildAction) (NSString *errMsg);
typedef void (^SupportNewsCommentSuccessAction) (NSString *successMsg);
typedef void (^SupportNewsCommentFaildAction) (NSString*errMsg);
typedef void (^unSupportCommentSuccessAction) (NSString *successMsg);
typedef void (^unSupportCommentFaildAction) (NSString *errMsg);
typedef void (^unFavoriteArticleSuccessAction) (NSString *successMsg);
typedef void (^unFavoriteArticleFaildAction) (NSString *errMsg);

typedef void (^UserDoThisActionShouldLoginFirst) (NSString *errMsg);

@interface ZYNewsDataCenter : ZYBaseDataCenter

- (void)startGetNewsListWithPageIndex:(NSInteger)pageIndex withCategoryId:(NSString *)categoryId withTabTypeId:(NSString *)tabTypeId;
- (void)setGetNewsListSuccessAction:(GetNewsListSuccessAction)successAction;
- (void)setGetNewsListFaildAction:(GetNewsListFaildAction)faildAction;

- (void)commentArticleWithId:(NSString *)articleId withContent:(NSString *)content;
- (void)setCommentArticleSuccessAction:(CommentNewsSuccessAction)successAction;
- (void)setCommentArticleFaildAction:(CommentNewsFaildAction)faildAction;

- (void)favoriteArticleWithId:(NSString *)articleId;
- (void)setFavoriteArticleSuccess:(FavoriteNewsSuccessAction)successAction;
- (void)setFavoriteArticleFaild:(FavoriteNewsFaildAction)faildAction;

- (void)startGetArticleCommentListWithArticleId:(NSString *)articleId withPageIndex:(NSInteger)pageIndex;
- (void)setGetArticleCommentListSuccessAction:(GetArticleCommentListSuccessAction)successAction;
- (void)setGetArticleCommentListFaildAction:(GetArticleCommentListFaildAction)faildAction;

- (void)startGetTabTypesByCategoryId:(NSString *)categoryId;
- (void)setGetTabTypesSuccessAction:(GetTabTypesSuccessAction)successAction;
- (void)setGetTabTypesFaildAction:(GetTabTypesFaildAction)faildAction;

- (void)startGetNewsDetailWithArticleId:(NSString *)articleId;
- (void)setGetNewsDetailSuccessAction:(GetNewsDetailSuccessAction)successAction;
- (void)setGetNewsDetailFaildAction:(GetNewsDetailFaildAction)faildAction;

- (void)supportCommentWithCommentId:(NSString *)commentId;
- (void)setSupportCommentSuccessAction:(SupportNewsCommentSuccessAction)successAction;
- (void)setSupportCommentFaildAction:(SupportNewsCommentFaildAction)faildAction;

- (void)unSupportCommentWithCommentId:(NSString *)commentId;
- (void)setUnSupportCommentSuccessAction:(unSupportCommentSuccessAction)successAction;
- (void)setUnSupportCommentFaildAction:(unSupportCommentFaildAction)faildAction;

- (void)unFavoriteArticleWithArticleId:(NSString *)articleId;
- (void)setUnFavoriteArticleSuccess:(unFavoriteArticleSuccessAction)successAction;
- (void)setUnFavoriteArticleFaild:(unFavoriteArticleFaildAction)faildAction;

- (void)setUserDoThisActionShouldLoginFirst:(UserDoThisActionShouldLoginFirst)shouldLoginAction;


@end
