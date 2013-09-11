//
//  ZYRootNavViewController.h
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-9.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRootMenuPageView.h"
#import "ZYScrollView.h"
#import "ZYSnapView.h"

@interface ZYRootNavViewController : UIViewController<UIScrollViewDelegate,ZYRootMenuPageViewDelegate>
{
    NSMutableArray *_detailViewControllers;
    
    ZYScrollView *myScrollView;
    ZYSnapView *snapImgView;
    UIView     *snapShadowView;
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
- (void)pageViewAtIndex:(NSInteger)index didSelectIndex:(NSInteger)selectIndex;
- (void)reloadMenu;

@end
