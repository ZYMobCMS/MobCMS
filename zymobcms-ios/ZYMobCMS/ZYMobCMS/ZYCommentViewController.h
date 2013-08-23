//
//  ZYCommentViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNBaseViewController.h"
#define PageSize 10
#import "ZYCommentBar.h"

@interface ZYCommentViewController : BFNBaseViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    BOOL            hideLoadMore;
    
}
@property (nonatomic,retain)UITableView *listTable;
@property (nonatomic,retain)NSString *articleId;
@property (nonatomic,retain)NSMutableArray *sourceArray;
@property (nonatomic,assign)NSInteger pageIndex;

- (void)getHotCommentList;
- (void)refresh;

@end
