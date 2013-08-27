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


@end
