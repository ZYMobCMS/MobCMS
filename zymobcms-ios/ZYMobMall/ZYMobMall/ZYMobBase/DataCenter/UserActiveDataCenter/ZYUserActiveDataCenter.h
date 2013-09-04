//
//  ZYUserActiveDataCenter.h
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-2.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseDataCenter.h"
#import "ZYUserActiveModel.h"

typedef void (^GetUserActiveListSuccessAction) (NSArray *modelArray);
typedef void (^GetUserActiveListFaildAction) (NSString *errMsg);

@interface ZYUserActiveDataCenter : ZYBaseDataCenter

- (void)startGetUserActiveListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetUserActiveListSuccess:(GetUserActiveListSuccessAction)successAction;
- (void)setGetUserActiveListFaild:(GetUserActiveListFaildAction)faildAction;

@end
