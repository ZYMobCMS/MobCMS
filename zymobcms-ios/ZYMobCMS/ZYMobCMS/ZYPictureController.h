//
//  ZYPictureController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNBaseViewController.h"
#import "ZYPictureCell.h"

@interface ZYPictureController : BFNBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *listTable;
    
    NSMutableArray *sourceArray;
    NSInteger      pageIndex;
}

@end
