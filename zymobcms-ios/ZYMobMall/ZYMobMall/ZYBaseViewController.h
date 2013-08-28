//
//  ZYBaseViewController.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _isLoadMore;
    BOOL _reloading;
    
    UITableView *listTable;
    NSMutableArray *listArray;
    BOOL hideLoadMore;
    NSInteger pageIndex;
}
@property (nonatomic,retain)NSString *requestFlag;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,retain)UITableView *listTable;

- (void)refresh;

@end
