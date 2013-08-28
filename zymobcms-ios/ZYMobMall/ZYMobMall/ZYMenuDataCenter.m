//
//  ZYMenuDataCenter.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYMenuDataCenter.h"

@implementation ZYMenuDataCenter
- (id)init
{
    self = [super init];
    if (self) {
        self.actionsDict = [[NSMutableDictionary alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [self.actionsDict release];
    [super dealloc];
}

- (void)startGetMenuList
{
    [[BFNetWorkHelper shareHelper] requestDataWithApplicationType:ZYCMSRequestTypeMenuList
                                                       withParams:nil
                                               withHelperDelegate:self
                                         withSuccessRequestMethod:@"getMenuListSuccess:"
                                           withFaildRequestMethod:@"getMenuListFaild:"];
}
- (void)getMenuListSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        NSMutableArray *menuArray = [NSMutableArray array];
        for (int i=0; i<resultArray.count;i++) {
            
            ZYMenuItemModel *newItem = [[ZYMenuItemModel alloc]initWithContentDict:[resultArray objectAtIndex:i]];
            [menuArray addObject:newItem];
            [newItem release];
            
        }
        
        if ([self.actionsDict objectForKey:@"listSuccess"]) {
            
            GetMenuListSccessAction successAction = [self.actionsDict objectForKey:@"listSuccess"];
            successAction(menuArray);
        }
        
        
    }else{
        
        if ([self.actionsDict objectForKey:@"listFaild"]) {
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            GetMenuListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
            faildAction(errMsg);
        }
        
    }
}
- (void)getMenuListFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"listFaild"]) {
        
        GetMenuListFaildAction faildAction = [self.actionsDict objectForKey:@"listFaild"];
        faildAction(NetWorkError);
    }
}
- (void)startGetApplicationInfo
{
    [[BFNetWorkHelper shareHelper] requestDataWithApplicationType:ZYCMSRequestTypeApplicationName
                                                       withParams:nil
                                               withHelperDelegate:self
                                         withSuccessRequestMethod:@"getApplicationInfoSuccess:"
                                           withFaildRequestMethod:@"getApplicaitonInfoFaild:"];
}
- (void)getApplicationInfoSuccess:(NSDictionary*)resultDict
{
    if ([BFNetWorkHelper checkResultSuccessed:resultDict]) {
        
        NSDictionary *infoDict = [resultDict objectForKey:@"data"];
        
        ZYApplicationModel *applicationModel = [[ZYApplicationModel alloc]initWithContentDict:infoDict];
        if ([self.actionsDict objectForKey:@"applicationSuccess"]) {
            GetApplicationInfoSuccessAction successAction = [self.actionsDict objectForKey:@"applicationSuccess"];
            successAction (applicationModel);
        }
    }else{
        if ([self.actionsDict objectForKey:@"applicationFaild"]) {
            GetAppliactionInfoFaildAction faildAction = [self.actionsDict objectForKey:@"applicationFaild"];
            
            NSString *errMsg = [resultDict objectForKey:@"msg"];
            faildAction(errMsg);
        }
        
    }
}
- (void)getApplicaitonInfoFaild:(NSDictionary*)resultDict
{
    if ([self.actionsDict objectForKey:@"applicationFaild"]) {
        GetAppliactionInfoFaildAction faildAction = [self.actionsDict objectForKey:@"applicationFaild"];
        faildAction(NetWorkError);
    }
}

- (void)setGetMenuListSuccessAction:(GetMenuListSccessAction)successAction
{
    GetMenuListSccessAction menuListSuccessAction = [successAction copy];
    [self.actionsDict setObject:menuListSuccessAction forKey:@"listSuccess"];
    [menuListSuccessAction release];
}
- (void)setGetMenuListFaildAction:(GetMenuListFaildAction)faildAction
{
    GetMenuListFaildAction menuListFaildAction = [faildAction copy];
    [self.actionsDict setObject:menuListFaildAction forKey:@"listFaild"];
    [menuListFaildAction release];
}
- (void)setGetApplicationInfoSuccessAction:(GetApplicationInfoSuccessAction)successAction
{
    GetApplicationInfoSuccessAction applicationSccess = [successAction copy];
    [self.actionsDict setObject:applicationSccess forKey:@"applicationSuccess"];
    [applicationSccess release];
}
- (void)setGetApplicationInfoFaildAction:(GetAppliactionInfoFaildAction)faildAction
{
    GetAppliactionInfoFaildAction applicationFaild = [faildAction copy];
    [self.actionsDict setObject:applicationFaild forKey:@"applicationFaild"];
    [applicationFaild release];
}

@end
