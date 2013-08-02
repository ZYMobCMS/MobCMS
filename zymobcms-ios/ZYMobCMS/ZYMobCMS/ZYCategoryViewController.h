//
//  ZYCategoryViewController.h
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFSegmentControl.h"

@interface ZYCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BFSegmentControlDataSource>
{
    BFSegmentControl *segmentCtrl;
    NSMutableArray   *segmentArray;
    
    UITableView *listTable;
    NSMutableArray *listArray;
    BOOL hideLoadMore;
    NSInteger pageIndex;
    
}
@property (nonatomic,retain)NSString *categoryId;
@property (nonatomic,retain)NSString *currentTabType;

- (void)refreshContent;

@end
