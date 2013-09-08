//
//  ZYUserDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYUserModel.h"
#import "ZYUserManager.h"
#import "ZYBaseDataCenter.h"

typedef void (^LoginSuccessAction) (NSString *successMsg);
typedef void (^LoginFaildAction) (NSString *errMsg);
typedef void (^RigistSuccessAction) (NSString *successMsg);
typedef void (^RigistFaildAction) (NSString *errMsg);
typedef void (^GetUserNewsFavSuccessAction) (NSArray *modelArray);
typedef void (^GetUserNewsFavFaildAction) (NSString *errMsg);
typedef void (^GetUserPicFavSuccessAction) (NSArray *modelArray);
typedef void (^GetUserPicFavFaildAction) (NSString *errMsg);
typedef void (^GetUserProductFavSuccessAction) (NSArray *modelArray);
typedef void (^GetUserProductFavFaildAction) (NSString *errMsg);
typedef void (^GetUserNewsCommentListSuccessAction) (NSArray *modelArray);
typedef void (^GetUserNewsCommentListFaildAction) (NSString *errMsg);
typedef void (^GetUserPicCommentListSuccessAction) (NSArray *modelArray);
typedef void (^GetUserPicCommentListFaildAction) (NSString *errMsg);
typedef void (^GetUserProductCommentListSuccessAction) (NSArray *modelArray);
typedef void (^GetUserProductCommentListFaildAction) (NSString *errMsg);
typedef void (^UserReplySuccessAction) (NSString *successMsg);
typedef void (^UserReplyFaildAction) (NSString*errMsg);


@interface ZYUserDataCenter :ZYBaseDataCenter

- (void)startLoginWithName:(NSString*)loginName withPassword:(NSString*)password;
- (void)startRigistWithName:(NSString*)loginName withPassword:(NSString*)password;

- (void)setLoginSuccessAction:(LoginSuccessAction)successAction;
- (void)setLoginFaildAction:(LoginFaildAction)faildAction;

- (void)setRigistSuccessAction:(RigistSuccessAction)successAction;
- (void)setRigistFaildAction:(RigistFaildAction)faildAction;

- (void)startGetUserNewsFavListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetUserNewsFavSuccessAction:(GetUserNewsFavSuccessAction)successAction;
- (void)setGetUserNewsFavFaildAction:(GetUserNewsFavFaildAction)faildAction;

- (void)startGetUserPicFavListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetuserPicFavSuccessAction:(GetUserPicFavSuccessAction)successAction;
- (void)setGetuserPicFavFaildAction:(GetUserPicFavFaildAction)faildAction;

- (void)startGetUserProductFavListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetUserProductFavSuccess:(GetUserProductFavSuccessAction)successAction;
- (void)setGetuserProductFavFaild:(GetUserProductFavFaildAction)faildAction;

- (void)startGetuserNewsCommentListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetUserNewsCommentListSuccessAction:(GetUserNewsCommentListSuccessAction)successAction;
- (void)setGetUserNewsCommentListFaild:(GetUserNewsCommentListFaildAction)faildAction;

- (void)startGetUserPictureCommentListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetUserPicCommentListSuccessAction:(GetUserPicCommentListSuccessAction)successAction;
- (void)setGetUserPicCommentListFaildAction:(GetUserPicCommentListFaildAction)faildAction;

- (void)startGetUserProductCommentListWithPageIndex:(NSInteger)pageIndex;
- (void)setGetuserProductCommentListSuccessAction:(GetUserProductCommentListSuccessAction)successAction;
- (void)setGetUserProductCommentListFaildAction:(GetUserProductCommentListFaildAction)faildAction;

- (void)startSendReplyWithContent:(NSString*)content;
- (void)setSendReplySuccessAction:(UserReplySuccessAction)successAction;
- (void)setSendReplyFaildAction:(UserReplyFaildAction)faildAction;

@end
