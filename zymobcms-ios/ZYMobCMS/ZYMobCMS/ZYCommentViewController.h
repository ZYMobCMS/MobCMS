//
//  ZYCommentViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNBaseViewController.h"

@interface ZYCommentViewController : BFNBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _isLoadMore;
    BOOL _reloading;
    
    
}
@property (nonatomic,retain)UITableView *listTable;
@property (nonatomic,retain)NSString *articleId;
@property (nonatomic,retain)NSMutableArray *sourceArray;
@property (nonatomic,assign)NSInteger pageIndex;
@end
