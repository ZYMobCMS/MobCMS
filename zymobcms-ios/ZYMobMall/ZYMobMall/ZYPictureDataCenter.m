//
//  ZYPictureDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYPictureDataCenter.h"
#import "ZYTabTypeModel.h"

@implementation ZYPictureDataCenter

- (id)init
{
    if (self = [super init]) {
        self.actionsDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [self.actionsDict release];
    [super dealloc];
}

- (void)startGetPictureListWithCategoryId:(NSString *)categoryId withTabTypeId:(NSString *)tabTypeId withPageIndex:(NSInteger)pageIndex
{
    if (categoryId == nil || tabTypeId == nil) {
        NSLog(@"categoryId or tabTypeId should not be nil!");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize]  forKey:@"pageSize"];
    [params setObject:[NSNumber  numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:categoryId forKey:@"categoryId"];
    [params setObject:tabTypeId forKey:@"tabTypeId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureListSuccess:" withFaildRequestMethod:@"getPictureListFaild:"];
}
- (void)getPictureListSuccess:(NSDictionary *)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        
        NSMutableArray *modelArray = [NSMutableArray array];
        for (int i=0; i<resultArray.count;i++) {
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSDictionary *oldItem = [resultArray objectAtIndex:i];
            NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:oldItem];
            [item setObject:[oldItem objectForKey:@"id"] forKey:@"picture_id"];
            ZYPictureModel *newModel = [[ZYPictureModel alloc]initWithSummaryDict:item];
            [modelArray addObject:newModel];
            [newModel release];
            [pool drain];
        }
        
        if ([self.actionsDict objectForKey:@"listSuccess"]) {
            
            SuccessGetNewPictureListData successAction = [self.actionsDict objectForKey:@"listSuccess"];
            successAction(modelArray);
        }

    }else{
        
        NSString *errMsg = [resultDict objectForKey:@"msg"];
        if ([self.actionsDict objectForKey:@"listFaild"]) {
            
            FaildGetNewPictureListData faildAction = [self.actionsDict objectForKey:@"listFaild"];
            faildAction(errMsg);
        }
    }
}
- (void)getPictureListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"listFaild"]) {
        
        FaildGetNewPictureListData faildAction = [self.actionsDict objectForKey:@"listFaild"];
        faildAction(NetWorkError);
    }
}

- (void)startGetPictureDetailWithPictureId:(NSString *)pictureId
{
    if (pictureId==nil) {
        NSLog(@"pictureId should not be nil while get picture detail!");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:pictureId forKey:@"pictureId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureDetailSuccess:" withFaildRequestMethod:@"getPictureDetailFaild:"];
}
- (void)getPictureDetailSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"detailSuccess"]) {
            
            SuccessGetPictureDetailData successAction = [self.actionsDict objectForKey:@"detailSuccess"];
            
            NSDictionary *oldItem = [resultDict objectForKey:@"data"];
            NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:oldItem];
            [item setObject:[oldItem objectForKey:@"id"] forKey:@"picture_id"];
            ZYPictureModel *newModel = [[ZYPictureModel alloc]initWithDetailDict:item];
            successAction(newModel);
            [newModel release];
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"detailFaild"]) {
            
            FaildGetPictureDetailData faildAction = [self.actionsDict objectForKey:@"detailFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
            
        }
        
    }
}
- (void)getPictureDetailFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"detailFaild"]) {
        
        FaildGetPictureDetailData faildAction = [self.actionsDict objectForKey:@"detailFaild"];
                
        faildAction(NetWorkError);
        
    }
}

- (void)startGetPictureTabTypesWithCategoryId:(NSString *)categoryId
{
    if (categoryId==nil) {
        NSLog(@"get picture tab types cateogry id must not be nil!");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:categoryId forKey:@"categoryId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureTabTypes withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getTabTypeSuccess:" withFaildRequestMethod:@"getTabTypeFaild:"];
}
- (void)getTabTypeSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"tabTypeSuccess"]) {
            
            SuccessGetTabTypeListData successAction = [self.actionsDict objectForKey:@"tabTypeSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *tabTypesArray = [NSMutableArray array];
            for (int i=0;i<resultArray.count;i++) {
                
                ZYTabTypeModel *newTabType = [[ZYTabTypeModel alloc]initWithContentDict:[resultArray objectAtIndex:i]];
                [tabTypesArray addObject:newTabType];
                [newTabType release];
            }
            successAction(tabTypesArray);
            
        }
        
    }else{
       
        NSString *errMsg = [resultDict objectForKey:@"msg"];
        if ([self.actionsDict objectForKey:@"tabTypeFaild"]) {
            
            FaildGetTabTypeListData faildAction = [self.actionsDict objectForKey:@"tabTypeFaild"];
            
            faildAction(errMsg);
        }
    }
}
- (void)getTabTypeFaild:(NSDictionary *)resultDict
{
    if ([self.actionsDict objectForKey:@"tabTypeFaild"]) {
        
        FaildGetTabTypeListData faildAction = [self.actionsDict objectForKey:@"tabTypeFaild"];
        
        faildAction(NetWorkError);
    }
}

- (void)startGetPictureCommentListWithPictureId:(NSString *)pictureId withPageIndex:(NSInteger)pageIndex
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:pictureId forKey:@"pictureId"];
    [params setObject:[NSNumber numberWithInt:pageIndex]  forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:ZYListPageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureCommentList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureCommentListSuccess:" withFaildRequestMethod:@"getPictureCommentListFaild:"];
}
- (void)getPictureCommentListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"commentListSuccess"]) {
            
            GetPictureCommentListSuccessAction successAction = [self.actionsDict objectForKey:@"commentListSuccess"];
            
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            NSMutableArray *modelArray = [NSMutableArray array];
            
            for (int i=0; i<resultArray.count;i++) {
                
                NSDictionary *oldItem = [resultDict objectForKey:@"data"];
                NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
                [newItem setObject:[oldItem objectForKey:@"picture_id"] forKey:@"relation_id"];
                
                ZYCommentModel *commentModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
                
                [modelArray addObject:commentModel];
                [commentModel release];

            }
           
            successAction(modelArray);
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"commentListFaild"]) {
            
            GetPictureCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"commentListFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
    }
}
- (void)getPictureCommentListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"commentListFaild"]) {
        
        GetPictureCommentListFaildAction faildAction = [self.actionsDict objectForKey:@"commentListFaild"];
                
        faildAction(NetWorkError);
    }
}

- (void)commentPictureWithPictureId:(NSString *)pictureId withContent:(NSString *)content
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:content forKey:@"content"];
    
    [params setObject:pictureId forKey:@"pictureId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCommentPicture withParams:params withHelperDelegate:self withSuccessRequestMethod:@"commentPictureSuccess:" withFaildRequestMethod:@"commentPictureFaild:"];
}
- (void)commentPictureSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"commentSuccess"]) {
            
            CommentPictureSuccessAction successAction = [self.actionsDict objectForKey:@"commentSuccess"];
            
            NSDictionary *oldItem = [resultDict objectForKey:@"data"];
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:oldItem];
            [newItem setObject:[oldItem objectForKey:@"picture_id"] forKey:@"relation_id"];
            ZYCommentModel *commentModel = [[ZYCommentModel alloc]initWithSummaryDict:newItem];
            
            successAction(commentModel);
            [commentModel release];
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"commentFaild"]) {
            
            CommentPictureFaildAction faildAction = [self.actionsDict objectForKey:@"commentFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(errMsg);
        }
        
    }
}
- (void)commentPictureFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"commentFaild"]) {
        
        CommentPictureFaildAction faildAction = [self.actionsDict objectForKey:@"commentFaild"];
                
        faildAction(NetWorkError);
    }
}

- (void)favoritePictureWithPictureId:(NSString *)pictureId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:pictureId forKey:@"pictureId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoriteArticle withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoritePictureSuccess:" withFaildRequestMethod:@"favoritePictureFaild:"];
}
- (void)favoritePictureSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        if ([self.actionsDict objectForKey:@"favoriteSuccess"]) {
            
            
            FavoritePictureSuccessAction successAction = [self.actionsDict objectForKey:@"favoriteSuccess"];
            
            successAction(@"收藏成功");
            
        }
        
    }else{
        
        if ([self.actionsDict objectForKey:@"favoriteFaild"]) {
            
            FavoritePictureFaildAction faildAction = [self.actionsDict objectForKey:@"favoriteFaild"];
            
            NSString *faildMsg = [resultDict objectForKey:@"msg"];
            
            faildAction(faildMsg);
        }
    }
}
- (void)favoritePictureFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"favoriteFaild"]) {
        
        FavoritePictureFaildAction faildAction = [self.actionsDict objectForKey:@"favoriteFaild"];
                
        faildAction(NetWorkError);
    }
}

- (void)setSuccessGetNewPictureListAction:(SuccessGetNewPictureListData)successAction
{
    SuccessGetNewPictureListData successListAction = [successAction copy];
    [self.actionsDict setObject:successListAction forKey:@"listSuccess"];
    [successListAction release];
}
- (void)setFaildGetNewPictureListAction:(FaildGetNewPictureListData)faildAction
{
    FaildGetNewPictureListData faildListAction = [faildAction copy];
    [self.actionsDict setObject:faildListAction forKey:@"listFaild"];
    [faildListAction release];
}

- (void)setSuccessGetPictureDetailAction:(SuccessGetPictureDetailData)successAction
{
    SuccessGetPictureDetailData successDetailAction = [successAction copy];
    [self.actionsDict setObject:successDetailAction forKey:@"detailSuccess"];
    [successDetailAction release];
}
- (void)setFaildGetPictureDetailAction:(FaildGetPictureDetailData)faildAction
{
    FaildGetPictureDetailData faildDetailAction = [faildAction copy];
    [self.actionsDict setObject:faildDetailAction forKey:@"detailFaild"];
    [faildDetailAction release];
}

- (void)setGetTabTypesSuccessAction:(SuccessGetTabTypeListData)successAction
{
    SuccessGetTabTypeListData successDetailAction = [successAction copy];
    [self.actionsDict setObject:successDetailAction forKey:@"tabTypeSuccess"];
    [successDetailAction release];
}
- (void)setGetTabTypesFaildAction:(FaildGetTabTypeListData)faildAction
{
    FaildGetTabTypeListData faildDetailAction = [faildAction copy];
    [self.actionsDict setObject:faildDetailAction forKey:@"tabTypeFaild"];
    [faildDetailAction release];
}

- (void)setCommentPictureSuccessAction:(CommentPictureSuccessAction)successAction
{
    CommentPictureSuccessAction commentSuccess = [successAction copy];
    [self.actionsDict setObject:commentSuccess forKey:@"commentSuccess"];
    [commentSuccess release];
}

- (void)setCommentPictureFaildAction:(CommentPictureFaildAction)faildAction
{
    CommentPictureFaildAction commentFaild = [faildAction copy];
    [self.actionsDict setObject:commentFaild forKey:@"commentFaild"];
    [commentFaild release];
}

- (void)setFavoritePictureSuccessAction:(FavoritePictureSuccessAction)successAction
{
    FavoritePictureSuccessAction favoriteSuccess = [successAction copy];
    [self.actionsDict setObject:favoriteSuccess forKey:@"favoriteSuccess"];
    [favoriteSuccess release];
}

- (void)setFavoritePictureFaildAction:(FavoritePictureFaildAction)faildAction
{
    FavoritePictureFaildAction favoriteFaild = [faildAction copy];
    [self.actionsDict setObject:favoriteFaild forKey:@"favoriteFaild"];
    [favoriteFaild release];
}

- (void)setGetPictureCommentListSuccess:(GetPictureCommentListSuccessAction)successAction
{
    GetPictureCommentListSuccessAction commentListSuccess = [successAction copy];
    [self.actionsDict setObject:commentListSuccess forKey:@"commentListSuccess"];
    [commentListSuccess release];
}

- (void)setGetPictureCommentListFaild:(GetPictureCommentListFaildAction)faildAction
{
    GetPictureCommentListFaildAction commentListFaild = [faildAction copy];
    [self.actionsDict setObject:commentListFaild forKey:@"commentListFaild"];
    [commentListFaild release];
}

@end
