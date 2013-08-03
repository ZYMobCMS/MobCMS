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

@interface ZYCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BFSegmentControlDataSource,EGORefreshTableHeaderDelegate>
{
    BFSegmentControl *segmentCtrl;
    NSMutableArray   *segmentArray;
    
    UITableView *_tableView;
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

- (void)refreshContent;

@end
