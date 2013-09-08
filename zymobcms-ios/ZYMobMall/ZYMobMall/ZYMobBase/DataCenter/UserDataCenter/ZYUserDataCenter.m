//
//  ZYUserDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYUserDataCenter.h"
#import "ZYPictureModel.h"
#import "ZYNewsModel.h"
#import "ZYProductModel.h"
#import "ZYCommentModel.h"

@implementation ZYUserDataCenter

- (void)startLoginWithName:(NSString *)loginName withPassword:(NSString *)password
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:loginName forKey:@"loginName"];
    [params setObject:password forKey:@"password"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeLogin withParams:params withHelperDelegate:self withSuccessRequestMethod:@"loginSuccess:" withFaildRequestMethod:@"loginFaild:"];
    [self.requestFlags addObject:requestFlag];
}

- (void)startRigistWithName:(NSString *)loginName withPassword:(NSString *)password
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:loginName forKey:@"loginName"];
    [params setObject:password forKey:@"password"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeRigist withParams:params withHelperDelegate:self withSuccessRequestMethod:@"rigistSuccess:" withFaildRequestMethod:@"rigistFaild:"];
    [self.requestFlags addObject:requestFlag];
}

- (void)loginSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"loginSuccess"]) {
            
            LoginSuccessAction loginSuccessAction = [self.actionsDict objectForKey:@"loginSuccess"];
            
            NSDictionary *userItem = [resultDict objectForKey:@"data"];
            ZYUserModel *loginUser = [[ZYUserModel alloc]initWithUserInfo:userItem];
            loginSuccessAction(@"登陆成功");
            [ZYUserManager loginNewUser:loginUser];
            [loginUser release];
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"loginFaild"]) {
            
            NSString *errorMsg = [resultDict objectForKey:@"msg"];
            
            LoginFaildAction faildAction = [self.actionsDict objectForKey:@"loginFaild"];
            faildAction(errorMsg);

        }
                
    }
}
- (void)loginFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"loginFaild"]) {
                
        LoginFaildAction faildAction = [self.actionsDict objectForKey:@"loginFaild"];
        faildAction(NetWorkError);
        
    }
}

- (void)rigistSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"rigistSuccess"]) {
            
            RigistSuccessAction rigistAction = [self.actionsDict objectForKey:@"rigistSuccess"];
            rigistAction(@"注册成功");
        }
        
    }else{
       
        if ([self.actionsDict objectForKey:@"rigistFaild"]) {
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            RigistFaildAction rigistFaild = [self.actionsDict objectForKey:@"rigistFaild"];
            rigistFaild(errMsg);
        }
    }
}

- (void)rigistFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"rigistFaild"]) {
        
        RigistFaildAction rigistFaild = [self.actionsDict objectForKey:@"rigistFaild"];
        rigistFaild(NetWorkError);
    }
}

#pragma mark - 文章收藏
- (void)startGetUserNewsFavListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserFavorite withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getUserNewsFavListSuccess:" withFaildRequestMethod:@"getUserNewsFavListFaild:"];
    [self.requestFlags addObject:requestFlag];

}
- (void)getUserNewsFavListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"newsFavSuccess"]) {
            
            GetUserNewsFavSuccessAction successAction = [self.actionsDict objectForKey:@"newsFavSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0; i<resultArray.count;i++) {
                
                NSDictionary *oldItem = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                
                ZYNewsModel *model = [[ZYNewsModel alloc]initWithSummaryContent:newItem];
                [modelArray addObject:model];
                [model release];
            }
            
            successAction(modelArray);
        }
        
    }else{
       
        if([self.actionsDict objectForKey:@"newsFavFaild"]){
            
            GetUserNewsFavFaildAction faildAction = [self.actionsDict objectForKey:@"newsFavFaild"];
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
        
    }
}
- (void)getUserNewsFavListFaild:(NSDictionary*)resultDict
{
    if([self.actionsDict objectForKey:@"newsFavFaild"]){
        
        GetUserNewsFavFaildAction faildAction = [self.actionsDict objectForKey:@"newsFavFaild"];        
        faildAction(NetWorkError);
    }
}


- (void)startGetUserPicFavListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    [params setObject:[NSNumber  numberWithInt:pageIndex] forKey:@"pageIndex"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserPictureFavoriteList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getUserPicFavListSuccess:" withFaildRequestMethod:@"getUserPicFavListFaild:"];
    [self.requestFlags addObject:requestFlag];
}
- (void)getUserPicFavListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        
        if ([self.actionsDict objectForKey:@"picFavSuccess"]) {
            
            GetUserPicFavSuccessAction successAction = [self.actionsDict objectForKey:@"picFavSuccess"];
            
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0; i<resultArray.count; i++) {
                
                ZYPictureModel *pictureModel = [[ZYPictureModel alloc]initWithSummaryDict:[resultArray objectAtIndex:i]];
                [modelArray addObject:pictureModel];
                [pictureModel release];
            }
            
            successAction(modelArray);
        }
        
    }else{
        
        if([self.actionsDict objectForKey:@"picFavFaild"]){
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            GetUserPicFavFaildAction faildAction = [self.actionsDict objectForKey:@"picFavFaild"];
            
            faildAction(errMsg);
        }
    }
}
- (void)getUserPicFavListFaild:(NSDictionary*)resultDict
{
    if([self.actionsDict objectForKey:@"picFavFaild"]){
        
        GetUserPicFavFaildAction faildAction = [self.actionsDict objectForKey:@"picFavFaild"];
        
        faildAction(NetWorkError);
    }
}

- (void)startGetUserProductFavListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    
     NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserProductFavoriteList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getUserProductFavListSuccess:" withFaildRequestMethod:@"getUserProductFavListFaild:"];
    [self.requestFlags addObject:requestFlag];
}
- (void)getUserProductFavListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
     
        if ([self.actionsDict objectForKey:@"productFavSuccess"]) {
            
            GetUserProductFavSuccessAction successAction = [self.actionsDict objectForKey:@"productFavSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0; i<resultArray.count; i++) {
                
                ZYProductModel *pModel = [[ZYProductModel alloc]initWithSummaryContentDict:[resultArray objectAtIndex:i]];
                [modelArray addObject:pModel];
                [pModel release];
                
            }
            
            successAction(modelArray);
    
        }
        
    }else{
        
        if([self.actionsDict objectForKey:@"productFavFaild"]){
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            GetUserProductFavFaildAction faildAction = [self.actionsDict objectForKey:@"productFavFaild"];
            
            faildAction(errMsg);
        }
        
    
    }
}
- (void)getUserProductFavListFaild:(NSDictionary*)resultDict
{
    if([self.actionsDict objectForKey:@"productFavFaild"]){
                
        GetUserProductFavFaildAction faildAction = [self.actionsDict objectForKey:@"productFavFaild"];
        
        faildAction(NetWorkError);
    }
}

- (void)startGetuserNewsCommentListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize ] forKey:@"pageSize"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserComment  withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getNewsCommentListSuccess:" withFaildRequestMethod:@"getNewsCommentListFaild:"];
    [self.requestFlags addObject:requestFlag];
}
- (void)getNewsCommentListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"newsCommentSuccess"]) {
            
            GetUserNewsCommentListSuccessAction successAction = [self.actionsDict objectForKey:@"newsCommentSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0; i<resultArray.count; i++) {
                
                NSDictionary *resultComment = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:resultComment];
                [newItem setObject:[resultComment objectForKey:@"article_id"] forKey:@"relation_id"];
                
                ZYCommentModel *pModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
                [modelArray addObject:pModel];
                [pModel release];
                
            }
            
            successAction(modelArray);
            
        }
        
    }else{
        
        if([self.actionsDict objectForKey:@"newsCommentFaild"]){
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            GetUserNewsCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"newsCommentFaild"];
            
            faildAction(errMsg);
        }
        
        
    }

}
- (void)getNewsCommentListFaild:(NSDictionary*)resultDict
{
    if([self.actionsDict objectForKey:@"newsCommentFaild"]){
                
        GetUserNewsCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"newsCommentFaild"];
        
        faildAction(NetWorkError);
    }
}
- (void)startGetUserPictureCommentListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize ] forKey:@"pageSize"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserPictureCommentList  withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getUserPicCommentListSuccess:" withFaildRequestMethod:@"getUserPicCommentListFaild:"];
    [self.requestFlags addObject:requestFlag];
}
- (void)getUserPicCommentListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"picCommentSuccess"]) {
            
            GetUserPicCommentListSuccessAction successAction = [self.actionsDict objectForKey:@"picCommentSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0; i<resultArray.count; i++) {
                
                NSDictionary *resultComment = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:resultComment];
                [newItem setObject:[resultComment objectForKey:@"picture_id"] forKey:@"relation_id"];
                
                ZYCommentModel *pModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
                [modelArray addObject:pModel];
                [pModel release];
                
            }
            
            successAction(modelArray);
            
        }
        
    }else{
        
        if([self.actionsDict objectForKey:@"picCommentFaild"]){
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            GetUserPicCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"picCommentFaild"];
            
            faildAction(errMsg);
        }
        
        
    }
}
- (void)getUserPicCommentListFaild:(NSDictionary*)resultDict
{
    if([self.actionsDict objectForKey:@"picCommentFaild"]){
                
        GetUserPicCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"picCommentFaild"];
        
        faildAction(NetWorkError);
    }
}
- (void)startGetUserProductCommentListWithPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize ] forKey:@"pageSize"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserProductCommentList  withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getUserPodcutCommentListSuccess:" withFaildRequestMethod:@"getUserProductCommentListFaild:"];
    [self.requestFlags addObject:requestFlag];
}
- (void)getUserPodcutCommentListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"productCommentSuccess"]) {
            
            GetUserProductCommentListSuccessAction successAction = [self.actionsDict objectForKey:@"productCommentSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            
            NSMutableArray *modelArray = [NSMutableArray array];
            for (int i=0; i<resultArray.count; i++) {
                
                NSDictionary *resultComment = [resultArray objectAtIndex:i];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:resultComment];
                [newItem setObject:[resultComment objectForKey:@"product_id"] forKey:@"relation_id"];
                
                ZYCommentModel *pModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
                [modelArray addObject:pModel];
                [pModel release];
                
            }
            
            successAction(modelArray);
            
        }
        
    }else{
        
        if([self.actionsDict objectForKey:@"productCommentFaild"]){
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            GetUserProductCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"productCommentFaild"];
            
            faildAction(errMsg);
        }
        
        
    }
}
- (void)getUserProductCommentListFaild:(NSDictionary*)resultDict
{
    if([self.actionsDict objectForKey:@"productCommentFaild"]){
                
        GetUserProductCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"productCommentFaild"];
        
        faildAction(NetWorkError);
    }
}

- (void)startSendReplyWithContent:(NSString *)content
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:content forKey:@"content"];
    
    NSString *requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeReply  withParams:params withHelperDelegate:self withSuccessRequestMethod:@"sendReplySucess:" withFaildRequestMethod:@"sendReplyFaild:"];
    [self.requestFlags addObject:requestFlag];
}

- (void)sendReplySucess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"replySuccess"]) {
            
            UserReplySuccessAction successAction = [self.actionsDict objectForKey:@"replySuccess"];
            
            successAction(@"反馈成功！");
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"replyFaild"]) {
            
            UserReplyFaildAction faildAction = [self.actionsDict objectForKey:@"replyFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
            
        }
        
    }
}

- (void)sendReplyFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"replyFaild"]) {
        
        UserReplyFaildAction faildAction = [self.actionsDict objectForKey:@"replyFaild"];
                
        faildAction(NetWorkError);
        
    }
}

- (void)setLoginSuccessAction:(LoginSuccessAction)successAction
{
    LoginSuccessAction loginSuccessAction = [successAction copy];
    [self.actionsDict setObject:loginSuccessAction forKey:@"loginSuccess"];
    [loginSuccessAction release];
    
}
- (void)setLoginFaildAction:(LoginFaildAction)faildAction
{
    LoginFaildAction loginFaildAction = [faildAction copy];
    [self.actionsDict setObject:loginFaildAction forKey:@"loginFaild"];
    [loginFaildAction release];
}

- (void)setRigistSuccessAction:(RigistSuccessAction)successAction
{
    RigistSuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"rigistSuccess"];
    [rigistSuccessAction release];
}
- (void)setRigistFaildAction:(RigistFaildAction)faildAction
{
    RigistSuccessAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"rigistFaild"];
    [rigistFaildAction release];
}

- (void)setGetUserNewsFavSuccessAction:(GetUserNewsFavSuccessAction)successAction
{
    GetUserNewsFavSuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"newsFavSuccess"];
    [rigistSuccessAction release];
}
- (void)setGetUserNewsFavFaildAction:(GetUserNewsFavFaildAction)faildAction
{
    GetUserNewsFavFaildAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"newsFavFaild"];
    [rigistFaildAction release];
}

- (void)setGetuserPicFavSuccessAction:(GetUserPicFavSuccessAction)successAction
{
    GetUserPicFavSuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"picFavSuccess"];
    [rigistSuccessAction release];
}
- (void)setGetuserPicFavFaildAction:(GetUserPicFavFaildAction)faildAction
{
    GetUserPicFavFaildAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"picFavFaild"];
    [rigistFaildAction release];
}
- (void)setGetUserProductFavSuccess:(GetUserProductFavSuccessAction)successAction
{
    GetUserProductFavSuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"productFavSuccess"];
    [rigistSuccessAction release];
}
- (void)setGetuserProductFavFaild:(GetUserProductFavFaildAction)faildAction
{
    GetUserProductFavFaildAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"productFavFaild"];
    [rigistFaildAction release];
}
- (void)setGetUserNewsCommentListSuccessAction:(GetUserNewsCommentListSuccessAction)successAction
{
    GetUserNewsCommentListSuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"newsCommentSuccess"];
    [rigistSuccessAction release];
}
- (void)setGetUserNewsCommentListFaild:(GetUserNewsCommentListFaildAction)faildAction
{
    GetUserNewsCommentListFaildAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"newsCommentFaild"];
    [rigistFaildAction release];
}
- (void)setGetUserPicCommentListSuccessAction:(GetUserPicCommentListSuccessAction)successAction
{
    GetUserPicCommentListSuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"picCommentSuccess"];
    [rigistSuccessAction release];
}
- (void)setGetUserPicCommentListFaildAction:(GetUserPicCommentListFaildAction)faildAction
{
    GetUserPicCommentListFaildAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"picCommentFaild"];
    [rigistFaildAction release];
}
- (void)setGetuserProductCommentListSuccessAction:(GetUserProductCommentListSuccessAction)successAction
{
    GetUserProductCommentListSuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"productCommentSuccess"];
    [rigistSuccessAction release];
}
- (void)setGetUserProductCommentListFaildAction:(GetUserProductCommentListFaildAction)faildAction
{
    GetUserPicCommentListFaildAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"productCommentFaild"];
    [rigistFaildAction release];
}
- (void)setSendReplySuccessAction:(UserReplySuccessAction)successAction
{
    UserReplySuccessAction rigistSuccessAction = [successAction copy];
    [self.actionsDict setObject:rigistSuccessAction forKey:@"replySuccess"];
    [rigistSuccessAction release];
}
- (void)setSendReplyFaildAction:(UserReplyFaildAction)faildAction
{
    UserReplyFaildAction rigistFaildAction = [faildAction copy];
    [self.actionsDict setObject:rigistFaildAction forKey:@"replyFaild"];
    [rigistFaildAction release];
}

- (void)cancelAllRequestNow
{
    for (NSString *requestFlag in self.requestFlags) {
        
        [[BFNetWorkHelper shareHelper]cancelRequestWithTimeStamp:requestFlag];
    }
}

@end
