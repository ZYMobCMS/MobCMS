//
//  ZYRigistViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNBaseViewController.h"

@interface ZYRigistViewController : BFNBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTable;
    
    NSMutableArray *sourceArray;

}
@end
