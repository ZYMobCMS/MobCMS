//
//  ZYProductViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-3.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "BFNBaseViewController.h"

@interface ZYProductViewController : BFNBaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _isLoadMore;
    BOOL _reloading;
    
    UITableView *listTable;
    NSMutableArray *listArray;
    NSMutableArray *tabTypesArray;
    
    BOOL hideLoadMore;
    NSInteger pageIndex;

}
@property (nonatomic,retain)NSString *categoryId;
@property (nonatomic,retain)NSString *currentTabType;
@property (nonatomic,assign)NSInteger pageIndex;

- (void)getProductList;
- (void)getAllTabTypes;

@end
