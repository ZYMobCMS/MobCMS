//
//  CommentListViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCommentBar.h"

@interface CommentListViewController : BFNBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic,retain)UITableView *listTable;
@property (nonatomic,retain)NSString *articleId;
@property (nonatomic,retain)NSMutableArray *sourceArray;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,retain)ZYCommentBar *commentBar;

- (id)initWithArticleId:(NSString*)aId;

@end
