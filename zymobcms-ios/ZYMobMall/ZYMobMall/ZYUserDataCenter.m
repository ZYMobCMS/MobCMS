//
//  ZYUserDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYUserDataCenter.h"

@implementation ZYUserDataCenter

- (id)init
{
    if (self = [super init]) {
        
        _actionDict = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}
- (void)dealloc
{
    [_actionDict release];
    [super dealloc];
}

- (void)startLoginWithName:(NSString *)loginName withPassword:(NSString *)password
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:loginName forKey:@"loginName"];
    [params setObject:password forKey:@"password"];
    
     [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeLogin withParams:params withHelperDelegate:self withSuccessRequestMethod:@"loginSuccess:" withFaildRequestMethod:@"loginFaild:"];
}

- (void)startRigistWithName:(NSString *)loginName withPassword:(NSString *)password
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:loginName forKey:@"loginName"];
    [params setObject:password forKey:@"password"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeRigist withParams:params withHelperDelegate:self withSuccessRequestMethod:@"rigistSuccess:" withFaildRequestMethod:@"rigistFaild:"];
}

- (void)loginSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([_actionDict objectForKey:@"loginSuccess"]) {
            
            LoginSuccessAction loginSuccessAction = [_actionDict objectForKey:@"loginSuccess"];
            loginSuccessAction();
        }
        
    }else{
        
        if ([_actionDict objectForKey:@"loginFaild"]) {
            
            NSString *errorMsg = [resultDict objectForKey:@"msg"];
            
            LoginFaildAction faildAction = [_actionDict objectForKey:@"loginFaild"];
            faildAction(errorMsg);

        }
                
    }
}
- (void)loginFaild:(NSDictionary*)resultDict
{
    if ([_actionDict objectForKey:@"loginFaild"]) {
                
        LoginFaildAction faildAction = [_actionDict objectForKey:@"loginFaild"];
        faildAction(NetWorkError);
        
    }
}

- (void)rigistSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([_actionDict objectForKey:@"rigistSuccess"]) {
            
            RigistSuccessAction rigistAction = [_actionDict objectForKey:@"rigistSuccess"];
            rigistAction();
        }
        
    }else{
       
        if ([_actionDict objectForKey:@"rigistFaild"]) {
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            RigistFaildAction rigistFaild = [_actionDict objectForKey:@"rigistFaild"];
            rigistFaild(errMsg);
        }
    }
}

- (void)rigistFaild:(NSDictionary*)resultDict
{
    if ([_actionDict objectForKey:@"rigistFaild"]) {
        
        RigistFaildAction rigistFaild = [_actionDict objectForKey:@"rigistFaild"];
        rigistFaild(NetWorkError);
    }
}

- (void)startGetUserPicFavList
{
    
}
- (void)getUserPicFavListSuccess:(NSDictionary*)resultDict
{
    
}
- (void)getUserPicFavListFaild:(NSDictionary*)resultDict
{
    
}

- (void)setLoginSuccessAction:(LoginSuccessAction)successAction
{
    LoginSuccessAction loginSuccessAction = [successAction copy];
    [_actionDict setObject:loginSuccessAction forKey:@"loginSuccess"];
    [loginSuccessAction release];
    
}
- (void)setLoginFaildAction:(LoginFaildAction)faildAction
{
    LoginFaildAction loginFaildAction = [faildAction copy];
    [_actionDict setObject:loginFaildAction forKey:@"loginFaild"];
    [loginFaildAction release];
}

- (void)setRigistSuccessAction:(RigistSuccessAction)successAction
{
    RigistSuccessAction rigistSuccessAction = [successAction copy];
    [_actionDict setObject:rigistSuccessAction forKey:@"rigistSuccess"];
    [rigistSuccessAction release];
}
- (void)setRigistFaildAction:(RigistFaildAction)faildAction
{
    RigistSuccessAction rigistFaildAction = [faildAction copy];
    [_actionDict setObject:rigistFaildAction forKey:@"rigistFaild"];
    [rigistFaildAction release];
}

- (void)setGetuserPicFavSuccessAction:(GetUserPicFavSuccessAction)successAction
{
    GetUserPicFavSuccessAction rigistSuccessAction = [successAction copy];
    [_actionDict setObject:rigistSuccessAction forKey:@"picFavSuccess"];
    [rigistSuccessAction release];
}
- (void)setGetuserPicFavFaildAction:(GetUserPicFavFaildAction)faildAction
{
    GetUserPicFavFaildAction rigistFaildAction = [faildAction copy];
    [_actionDict setObject:rigistFaildAction forKey:@"picFavFaild"];
    [rigistFaildAction release];
}

@end
