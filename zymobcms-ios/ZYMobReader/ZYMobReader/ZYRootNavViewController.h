//
//  ZYRootNavViewController.h
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-9.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYRootNavViewController : UIViewController
{
    NSMutableArray *_detailViewControllers;
}

- (void)pushNewDetailViewController:(UIViewController*)detailViewController;
- (void)popDetailViewController:(UIViewController*)detailController;
@end
