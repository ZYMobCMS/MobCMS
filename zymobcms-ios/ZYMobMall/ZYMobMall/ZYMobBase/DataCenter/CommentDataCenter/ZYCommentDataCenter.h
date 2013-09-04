//
//  ZYCommentDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYCommentModel.h"

typedef void (^GetHotCommentListSuccessAction) (NSArray *modelArray);
typedef void (^GetHotCommentLIstFaildAction) (NSString *errMsg);

@interface ZYCommentDataCenter : ZYBaseDataCenter


- (void)startGetHotCommentListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetHotCommentListSuccessAction:(GetHotCommentListSuccessAction) successAction;
- (void)setGetHOtCommentListFaildAction:(GetHotCommentLIstFaildAction)faildAction;

@end
