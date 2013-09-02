//
//  ZYPictureDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYPictureModel.h"
#import "ZYCommentModel.h"

typedef void (^SuccessGetTabTypeListData) (NSArray *tabTypeArray);
typedef void (^FaildGetTabTypeListData)   (NSString *errMsg);

typedef void (^SuccessGetNewPictureListData) (NSArray *newDataArray);
typedef void (^FaildGetNewPictureListData) (NSString *errMsg);

typedef void (^SuccessGetPictureDetailData) (ZYPictureModel *newPicture);
typedef void (^FaildGetPictureDetailData) (NSString *errMsg);

typedef void (^GetPictureCommentListSuccessAction) (NSArray *modleArray);
typedef void (^GetPictureCommentListFaildAction) (NSString *errMsg);

typedef void (^CommentPictureSuccessAction) (ZYCommentModel *commentModel);
typedef void (^CommentPictureFaildAction) (NSString *errMsg);

typedef void (^FavoritePictureSuccessAction) (NSString *successMsg);
typedef void (^FavoritePictureFaildAction) (NSString *errMsg);

@interface ZYPictureDataCenter : ZYBaseDataCenter


- (void)startGetPictureListWithCategoryId:(NSString*)categoryId withTabTypeId:(NSString*)tabTypeId withPageIndex:(NSInteger)pageIndex;
- (void)startGetPictureDetailWithPictureId:(NSString*)pictureId;
- (void)startGetPictureTabTypesWithCategoryId:(NSString*)categoryId;
- (void)startGetPictureCommentListWithPictureId:(NSString *)pictureId withPageIndex:(NSInteger)pageIndex;
- (void)commentPictureWithPictureId:(NSString *)pictureId withContent:(NSString*)content;
- (void)favoritePictureWithPictureId:(NSString*)pictureId;


- (void)setSuccessGetNewPictureListAction:(SuccessGetNewPictureListData)successAction;
- (void)setFaildGetNewPictureListAction:(FaildGetNewPictureListData)faildAction;

- (void)setGetPictureCommentListSuccess:(GetPictureCommentListSuccessAction)successAction;
- (void)setGetPictureCommentListFaild:(GetPictureCommentListFaildAction)faildAction;

- (void)setSuccessGetPictureDetailAction:(SuccessGetPictureDetailData)successAction;
- (void)setFaildGetPictureDetailAction:(FaildGetPictureDetailData)faildAction;

- (void)setGetTabTypesSuccessAction:(SuccessGetTabTypeListData)successAction;
- (void)setGetTabTypesFaildAction:(FaildGetTabTypeListData)faildAction;

- (void)setCommentPictureSuccessAction:(CommentPictureSuccessAction)successAction;
- (void)setCommentPictureFaildAction:(CommentPictureFaildAction)faildAction;

- (void)setFavoritePictureSuccessAction:(FavoritePictureSuccessAction)successAction;
- (void)setFavoritePictureFaildAction:(FavoritePictureFaildAction)faildAction;


@end
