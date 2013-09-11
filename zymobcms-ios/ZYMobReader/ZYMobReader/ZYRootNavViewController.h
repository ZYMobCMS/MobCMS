//
//  ZYRootNavViewController.h
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-9.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRootMenuPageView.h"

@interface ZYRootNavViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *_detailViewControllers;
    
    UIScrollView *myScrollView;
    NSMutableSet *recycledPages;
    NSMutableSet *visiblePages;
    
    NSMutableArray *meunSourceArray;
    NSMutableArray *menuTempArray;
    NSInteger       tabTypeRequestCount;
    ZYMenuDataCenter *dataCenter;
    ZYNewsDataCenter *newsDataCenter;
}
@property (nonatomic,retain)UIPanGestureRecognizer *panGesture;
@property (nonatomic,retain)NSMutableArray *menuSourceArray;

- (void)pushNewDetailViewController:(UIViewController*)detailViewController;
- (void)popDetailViewController:(UIViewController*)detailController;


- (void)tilePages;
- (ZYRootMenuPageView *)dequeueRecycledPage;
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index;
- (ZYRootMenuPageView *)pageForIndex:(NSUInteger)index;
- (void)reloadMenu;

@end
