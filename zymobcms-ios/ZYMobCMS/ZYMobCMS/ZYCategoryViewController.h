//
//  ZYCategoryViewController.h
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFSegmentControl.h"
#import "EGORefreshTableHeaderView.h"
#import "BFNBaseViewController.h"

@interface ZYCategoryViewController : BFNBaseViewController<UITableViewDataSource,UITableViewDelegate,BFSegmentControlDataSource,EGORefreshTableHeaderDelegate>
{
    BFSegmentControl *segmentCtrl;
    NSMutableArray   *segmentArray;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _isLoadMore;
    BOOL _reloading;
    
    UITableView *listTable;
    NSMutableArray *listArray;
    BOOL hideLoadMore;
    NSInteger pageIndex;
    
    
}
@property (nonatomic,retain)NSString *categoryId;
@property (nonatomic,retain)NSString *currentTabType;
@property (nonatomic,retain)NSString *requestFlag;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,retain)BFSegmentControl *segmentCtrl;
@property (nonatomic,retain)UITableView *listTable;

- (void)refreshContent;

- (void)getNewsList;

- (void)getTabType;

@end
