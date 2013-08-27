//
//  ZYPictureDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYPictureModel.h"

typedef void (^SuccessGetTabTypeListData) (NSArray *tabTypeArray);
typedef void (^FaildGetTabTypeListData)   (NSString *errMsg);

typedef void (^SuccessGetNewPictureListData) (NSArray *newDataArray);
typedef void (^FaildGetNewPictureListData) (NSString *errMsg);

typedef void (^SuccessGetPictureDetailData) (ZYPictureModel *newPicture);
typedef void (^FaildGetPictureDetailData) (NSString *errMsg);

@interface ZYPictureDataCenter : NSObject
{
    NSMutableDictionary *_actionsDict;
}

- (void)startGetPictureListWithCategoryId:(NSString*)categoryId withTabTypeId:(NSString*)tabTypeId withPageIndex:(NSInteger)pageIndex;
- (void)startGetPictureDetailWithPictureId:(NSString*)pictureId;
- (void)startGetPictureTabTypesWithCategoryId:(NSString*)categoryId;


- (void)setSuccessGetNewPictureListAction:(SuccessGetNewPictureListData)successAction;
- (void)setFaildGetNewPictureListAction:(FaildGetNewPictureListData)faildAction;

- (void)setSuccessGetPictureDetailAction:(SuccessGetPictureDetailData)successAction;
- (void)setFaildGetPictureDetailAction:(FaildGetPictureDetailData)faildAction;

- (void)setGetTabTypesSuccessAction:(SuccessGetTabTypeListData)successAction;
- (void)setGetTabTypesFaildAction:(FaildGetTabTypeListData)faildAction;

@end
