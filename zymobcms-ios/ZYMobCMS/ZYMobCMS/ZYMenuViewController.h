//
//  ZYMenuViewController.h
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYMenuViewController : UITableViewController
{
    NSMutableArray *menuArray;
    NSMutableArray *viewControllers;
    
    
}
@property (nonatomic,retain)NSIndexPath      *selectIndexPath;

@end
