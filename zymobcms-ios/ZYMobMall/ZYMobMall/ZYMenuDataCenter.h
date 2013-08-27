//
//  ZYMenuDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYApplicationModel.h"

typedef void (^GetMenuListSccessAction) (NSArray *menuListArray);
typedef void (^GetMenuListFaildAction) (NSString *errMsg);

typedef void (^GetApplicationInfoSuccessAction) (ZYApplicationModel *appicationModel);
typedef void (^GetAppliactionInfoFaildAction) (NSString *errMsg);

@interface ZYMenuDataCenter : NSObject
{
    NSMutableDictionary *_actionsDict;
}

- (void)startGetMenuList;
- (void)startGetApplicationInfo;

- (void)setGetMenuListSuccessAction:(GetMenuListSccessAction)successAction;
- (void)setGetMenuListFaildAction:(GetMenuListFaildAction)faildAction;

- (void)setGetApplicationInfoSuccessAction:(GetApplicationInfoSuccessAction)successAction;
- (void)setGetApplicationInfoFaildAction:(GetAppliactionInfoFaildAction)faildAction;

@end
