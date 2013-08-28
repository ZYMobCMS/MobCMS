//
//  ZYUserDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYUserModel.h"

typedef void (^LoginSuccessAction) (void);
typedef void (^LoginFaildAction) (NSString *errMsg);
typedef void (^RigistSuccessAction) (void);
typedef void (^RigistFaildAction) (NSString *errMsg);
typedef void (^GetUserNewsFavSuccessAction) (NSArray *favListArray);
typedef void (^GetUserNewsFavFaildAction) (NSString *errMsg);
typedef void (^GetUserPicFavSuccessAction) (NSArray *favListArray);
typedef void (^GetUserPicFavFaildAction) (NSString *errMsg);
typedef void (^GetUserProductFavSuccessAction) (NSArray *favListArray);
typedef void (^GetUserProductFavFaildAction) (NSString *errMsg);

@interface ZYUserDataCenter : NSObject
{
    NSMutableDictionary *_actionDict;
}


- (void)startLoginWithName:(NSString*)loginName withPassword:(NSString*)password;
- (void)startRigistWithName:(NSString*)loginName withPassword:(NSString*)password;

- (void)setLoginSuccessAction:(LoginSuccessAction)successAction;
- (void)setLoginFaildAction:(LoginFaildAction)faildAction;

- (void)setRigistSuccessAction:(RigistSuccessAction)successAction;
- (void)setRigistFaildAction:(RigistFaildAction)faildAction;

- (void)setGetUserNewsFavSuccessAction:(GetUserNewsFavSuccessAction)successAction;
- (void)setGetUserNewsFavFaildAction:(GetUserNewsFavFaildAction)faildAction;

- (void)startGetUserPicFavList;
- (void)setGetuserPicFavSuccessAction:(GetUserPicFavSuccessAction)successAction;
- (void)setGetuserPicFavFaildAction:(GetUserPicFavFaildAction)faildAction;


@end
