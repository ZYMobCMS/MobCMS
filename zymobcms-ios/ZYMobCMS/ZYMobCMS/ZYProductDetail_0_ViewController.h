//
//  ZYProductDetail_0_ViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "BFNBaseViewController.h"

@interface ZYProductDetail_0_ViewController : BFNBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTable;
    NSMutableArray *listArray;
}
@property (nonatomic,retain)NSString *productId;
@property (nonatomic,retain)NSString *productTitle;
@property (nonatomic,retain)NSString *productImages;
@property (nonatomic,assign)BOOL      isFavorited;

@end
