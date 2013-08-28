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
            ZYPictureModel *newModel = [[ZYPictureModel alloc]initWithSummaryDict:[resultArray objectAtIndex:i]];
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
            
            ZYPictureModel *newModel = [[ZYPictureModel alloc]initWithDetailDict:[resultDict objectForKey:@"data"]];
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

@end
