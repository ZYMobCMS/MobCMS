//
//  ZYRootNavViewController.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-9.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYRootNavViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZYRootMenuItemModel.h"
#import "ZYChannelViewController.h"

#define DropMargin 10

@interface ZYRootNavViewController ()

@end

@implementation ZYRootNavViewController
@synthesize panGesture,menuSourceArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _detailViewControllers = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [_detailViewControllers release];
    [recycledPages release];
    [visiblePages release];
    [menuSourceArray release];
    [menuTempArray release];
    [newsDataCenter release];
    [dataCenter release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
//    [self.view addGestureRecognizer:self.panGesture];
//    [self.panGesture release];
    
    recycledPages=[[NSMutableSet alloc] init];
    visiblePages =[[NSMutableSet alloc] init];
    menuSourceArray = [[NSMutableArray alloc]init];
    menuTempArray = [[NSMutableArray alloc]init];
    dataCenter = [[ZYMenuDataCenter alloc]init];
    newsDataCenter = [[ZYNewsDataCenter alloc]init];
    //添加scrollview
    myScrollView = [[ZYScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    myScrollView.pagingEnabled = YES;
    myScrollView.delegate = self;
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width*self.menuSourceArray.count,myScrollView.frame.size.height);
    [self.view addSubview:myScrollView];
    myScrollView.contentBackView.image = [ZYThemeManager getImageWithName:@"home_back.jpg"];
    [myScrollView release];
    
    [self getMenuData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark-scrollView重用机制-
//视图滑动时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self tilePages];
}
- (CGRect)rectForPageAtIndex:(NSUInteger)index
{
    CGFloat originX = myScrollView.frame.size.width*index;
    CGFloat originY = 0.f;
    
    return CGRectMake(originX, originY, myScrollView.frame.size.width, myScrollView.frame.size.height);
}

- (NSIndexSet *)visiblePagesIndexesInRect:(CGRect)rect
{
    NSMutableIndexSet *indices = [NSMutableIndexSet indexSet];
    
    for (NSUInteger i=0; i < self.menuSourceArray.count; i++)
    {
        CGRect pageFrame = [self.view convertRect:[self rectForPageAtIndex:i]
                                    fromView:myScrollView];
        
        if (CGRectIntersectsRect(pageFrame, rect))
        {
            [indices addIndex:i];
        }
    }
    
    return indices;
}

- (void)tilePages
{
    // 计算可见视图数量
    CGRect visibleBounds =myScrollView.bounds;
    int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [self.menuSourceArray count] - 1);
    
    // 移除不在屏幕上的视图，保留前后各一个
    for (ZYRootMenuPageView *page in visiblePages) {
        if (page.pageIndex < firstNeededPageIndex || page.pageIndex > lastNeededPageIndex) {
            [recycledPages addObject:page];
            [page removeFromSuperview];
        }
    }
    [visiblePages minusSet:recycledPages];
    
    // 需要显示的视图
    for (int index = firstNeededPageIndex; index <= lastNeededPageIndex; index++) {
        if (![self isDisplayingPageForIndex:index]) {
            ZYRootMenuPageView *page = [self pageForIndex:index];
            [myScrollView addSubview:page];
            [visiblePages addObject:page];
        }
    }
}

- (ZYRootMenuPageView *)dequeueRecycledPage
{
    ZYRootMenuPageView *page = [recycledPages anyObject];
    if (page) {
        [[page retain] autorelease];
        [recycledPages removeObject:page];
    }
    return page;
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index
{
    BOOL foundPage = NO;
    for (ZYRootMenuPageView *page in visiblePages) {
        if (page.pageIndex == index) {
            foundPage = YES;
            break;
        }
    }
    
    return foundPage;
}

- (ZYRootMenuPageView*)pageForIndex:(NSUInteger)index
{
    ZYRootMenuPageView *page = [self dequeueRecycledPage];
    
    if (page == nil) {
        page = [[[ZYRootMenuPageView alloc] initWithFrame:CGRectMake(0,0, myScrollView.frame.size.width,myScrollView.frame.size.height)] autorelease];
    }
    page.frame =CGRectMake(myScrollView.frame.size.width*index,0, myScrollView.frame.size.width,myScrollView.frame.size.height);
    page.delegate = self;
    NSArray *pages = [self.menuSourceArray objectAtIndex:index];
    [page setMenuItemArray:pages];
    page.pageIndex = index;
    
    return page;
}
- (void)rootMenuPageView:(ZYRootMenuPageView *)pageView didSelectAtIndex:(NSInteger)selectIndex
{
    NSArray *pages = [self.menuSourceArray objectAtIndex:pageView.pageIndex];
    
    ZYMenuItemModel *item = [pages objectAtIndex:selectIndex];
    
    if ([item isKindOfClass: [ZYRootMenuItemModel class]]) {
        
        ZYRootMenuItemModel *newItem = (ZYRootMenuItemModel *)item;
        ZYChannelViewController *channelVC = [[ZYChannelViewController alloc]initWithMenuItem:newItem];
        channelVC.view.backgroundColor = [UIColor whiteColor];
        [self pushNewDetailViewController:channelVC];
        [channelVC release];
    }
    
}

- (void)reloadMenu
{
    [myScrollView scrollRectToVisible:CGRectMake(0,0,myScrollView.frame.size.width,myScrollView.frame.size.height) animated:NO];
    for (UIView *subView in myScrollView.subviews) {
        if ([subView isKindOfClass:[ZYRootMenuPageView class]]) {
            [recycledPages addObject:subView];
            [subView removeFromSuperview];
        }
    }
    [visiblePages removeAllObjects];
    myScrollView.contentSize = CGSizeMake(myScrollView.frame.size.width*self.menuSourceArray.count,myScrollView.frame.size.height);
    myScrollView.contentBackView.frame = CGRectMake(0,0,myScrollView.contentSize.width,myScrollView.contentSize.height);
    [self tilePages];
}

#pragma mark - getMenuData
- (void)getMenuData
{
    [dataCenter setGetMenuListSuccessAction:^(NSArray *menuListArray) {
        
        [newsDataCenter setGetTabTypesSuccessAction:^(NSArray *modelArray) {
            
            for (int i=0; i<modelArray.count; i++) {
                
                ZYTabTypeModel *modelItem = [modelArray objectAtIndex:i];
                ZYRootMenuItemModel *newItem = [[ZYRootMenuItemModel alloc]initWithTabTypeItem:modelItem];
                newItem.moduleId = @"1";
                
                [menuTempArray addObject:newItem];
                [newItem release];
            }
            tabTypeRequestCount--;
            
            if (tabTypeRequestCount==0) {
                [self buildMenuViewNow];
            }

        }];
        [newsDataCenter setGetTabTypesFaildAction:^(NSString *errMsg) {
            [SVProgressHUD showErrorWithStatus:errMsg];
        }];
        
        [menuTempArray addObjectsFromArray:menuListArray];
        NSInteger requestCount = 0;
        for (ZYMenuItemModel *itemModel in menuListArray) {
            
            if ([itemModel.moduleId intValue] == 1) {
                
                [newsDataCenter startGetTabTypesByCategoryId:itemModel.categoryId];
                requestCount++;
            }
        }
        tabTypeRequestCount = requestCount;
        

    }];
    [dataCenter setGetMenuListFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
        tabTypeRequestCount--;
    }];
    [dataCenter startGetMenuList];

}
- (void)buildMenuViewNow
{
    NSInteger pageCount = menuTempArray.count/8+1;
    
    if (pageCount == 1) {
        
        [self.menuSourceArray addObject:menuTempArray];
        
    }else{
        for (int i=0; i<pageCount;i++) {
            
            if (i!=pageCount-1) {
                NSArray *subPageArray = [menuTempArray subarrayWithRange:NSMakeRange(i*8,8)];
                [self.menuSourceArray addObject:subPageArray];
                
            }else{
                
                NSInteger lastPageCount = menuTempArray.count%8;
                
                if (lastPageCount==0) {
                    NSArray *subPageArray = [menuTempArray subarrayWithRange:NSMakeRange(i*8,8)];
                    [self.menuSourceArray addObject:subPageArray];
                }else{
                    NSArray *lastPageArray = [menuTempArray subarrayWithRange:NSMakeRange(i*8,lastPageCount)];
                    [self.menuSourceArray addObject:lastPageArray];
                }
                
            }
            
        }
    }
    [self reloadMenu];
}

#pragma mark - 视图推入推出
- (void)createSnapShotView
{
    UIImage *snapShotImage = [self.view snapshotImage];
    if (!snapImgView) {
        snapImgView = [[ZYSnapView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
        snapImgView.image = snapShotImage;
        [self.view addSubview:snapImgView];
        [snapImgView release];
        
        snapShadowView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
        snapShadowView.backgroundColor = [UIColor blackColor];
        snapShadowView.alpha = 0.4f;
        [self.view addSubview:snapShadowView];
        [snapShadowView release];
    }else{
        [self.view bringSubviewToFront:snapImgView];
        [self.view bringSubviewToFront:snapShadowView];
        snapImgView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        snapImgView.image = snapShotImage;
        snapImgView.hidden = NO;
        snapShadowView.hidden = NO;
    }

}
- (void)pushNewDetailViewController:(UIViewController *)detailViewController
{
    if ([_detailViewControllers containsObject:detailViewController]) {
        return;
    }
    
    [_detailViewControllers addObject:detailViewController];
    
    //截图
    [self createSnapShotView];
    myScrollView.hidden = YES;
    
    detailViewController.view.frame = CGRectMake(0,self.view.frame.size.height,self.view.frame.size.width,self.view.frame.size.height);
    [self.view addSubview:detailViewController.view];
    
    snapShadowView.alpha=0.f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushDetailViewAnimationFinished)];
    detailViewController.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    snapImgView.frame = CGRectMake(DropMargin,DropMargin,self.view.frame.size.width-2*DropMargin,self.view.frame.size.height-2*DropMargin);
    snapShadowView.frame = CGRectMake(DropMargin,DropMargin,self.view.frame.size.width-2*DropMargin,self.view.frame.size.height-2*DropMargin);
    snapShadowView.alpha = 0.5f;
    [UIView commitAnimations];
}
- (void)pushDetailViewAnimationFinished
{
    snapImgView.hidden = YES;
    snapShadowView.hidden = YES;
}
- (void)popDetailViewController:(UIViewController *)detailController
{
    if (![_detailViewControllers containsObject:detailController]) {
        return;
    }
    
    //reset backImageView
    snapImgView.hidden = NO;
    snapShadowView.hidden = NO;
    
    snapShadowView.alpha = 0.5f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishPopDetailViewController)];
    snapImgView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    snapShadowView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    detailController.view.frame = CGRectMake(0,self.view.frame.size.height,detailController.view.frame.size.width,detailController.view.frame.size.height);
    snapShadowView.alpha = 0.f;
    [UIView commitAnimations];


}
- (void)finishPopDetailViewController
{
    UIViewController *lastVC = [_detailViewControllers lastObject];
    [lastVC.view removeFromSuperview];
    [_detailViewControllers removeLastObject];
    snapImgView.hidden = YES;
    snapShadowView.hidden = YES;
    [self.view sendSubviewToBack:snapImgView];
    [self.view sendSubviewToBack:snapShadowView];
    myScrollView.hidden = NO;

}


@end
