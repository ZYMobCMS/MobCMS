//
//  ZYMyFavoriteViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-14.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMyFavoriteViewController.h"
#import "ZYMyArticleFavoriteViewController.h"
#import "ZYMyPictureFavoriteViewController.h"
#import "ZYMyProductFavoriteViewController.h"

@interface ZYMyFavoriteViewController ()

@end

@implementation ZYMyFavoriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [segmentArray release];
    [viewControllers release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!segmentArray) {
        segmentArray = [[NSMutableArray alloc]init];
    }
    if (!viewControllers) {
        viewControllers = [[NSMutableArray alloc]init];
    }
    
    //build
    [segmentArray addObject:@"文章收藏"];
    [segmentArray addObject:@"图片收藏"];
    [segmentArray addObject:@"产品收藏"];
    
    segmentCtrl = [[BFSegmentControl alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,45) withDataSource:self];
    [self.view addSubview:segmentCtrl];
    [segmentCtrl release];
    
//    NSLog(@"self.navi --->%@",self.navigationController);
    
    //controllers
    ZYMyArticleFavoriteViewController *articleVC = [[ZYMyArticleFavoriteViewController alloc]init];
    articleVC.superNavigationController = self.navigationController;
    [viewControllers addObject:articleVC];
    [articleVC release];
    
    ZYMyPictureFavoriteViewController *pictureVC = [[ZYMyPictureFavoriteViewController alloc]init];
    pictureVC.superNavigationController = self.navigationController;
    [viewControllers addObject:pictureVC];
    [pictureVC release];
    
    ZYMyProductFavoriteViewController *productVC = [[ZYMyProductFavoriteViewController alloc]init];
    productVC.superNavigationController = self.navigationController;
    [viewControllers addObject:productVC];
    [productVC release];
    
//    NSLog(@"productVC navigationController--->%@",productVC.superNavigationController);
    
    //设置右上角刷新
    BFNBarButton *refreshBtn = [[BFNBarButton alloc]initWithFrame:CGRectMake(0,0,29,29) withImage:[UIImage imageNamed:@"refresh.png"] withTapOnBarButton:^(BFNBarButton *sender) {
        [self refresh];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:refreshBtn];
    [refreshBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    //默认选中
    [self shouldSelectVCAtIndex:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - segment delegate
//菜单里面有多少项
- (NSInteger)numberOfItemsInSegmentControl:(BFSegmentControl*)sgmCtrl
{
    return segmentArray.count;
}

//每一项得宽度是多少
- (CGFloat)widthForEachItemInsegmentControl:(BFSegmentControl*)sgmCtrl
{
    NSInteger itemCount = MIN(segmentArray.count,4);
    return 320.0/itemCount;
}

//对应索引项得标题是什么
- (NSString*)segmentControl:(BFSegmentControl*)sgmCtrl titleForItemAtIndex:(NSInteger)index
{
    return [segmentArray objectAtIndex:index];
}

//当前可见项有多少
- (NSInteger)visiableItemsOfsegmentControl:(BFSegmentControl*)sgmCtrl
{
    NSInteger itemCount = MIN(segmentArray.count,4);
    return itemCount;
}

//菜单选中了哪一项
- (void)segmentControl:(BFSegmentControl*)sgmCtrl didSelectAtIndex:(NSInteger)index
{
    currentTabType = index;
    [self shouldSelectVCAtIndex:index];
}

- (void)shouldSelectVCAtIndex:(NSInteger)index
{
    BFNBaseViewController *selectVC = [viewControllers objectAtIndex:index];
    
    if (![self.view.subviews containsObject:selectVC.view]) {
        selectVC.view.frame = CGRectMake(0,35,self.view.frame.size.width,self.view.frame.size.height);
        [self.view addSubview:selectVC.view];
    }
    
    for (UIView *subView in self.view.subviews) {
        
        if (selectVC.view == subView) {
            selectVC.view.hidden = NO;
        }else{
            
            if ([subView isKindOfClass:[BFSegmentControl class]]) {
                subView.hidden=NO;
                [self.view bringSubviewToFront:subView];
            }else{
                subView.hidden = YES;
            }
        }
    }
    
    [selectVC getListData];//网络数据
}

- (void)refresh
{
    BFNBaseViewController *selectVC = [viewControllers objectAtIndex:currentTabType];
    
    [selectVC getListData];
}

- (void)setNavigationControllerForSubViewControllers:(UINavigationController *)navigationController
{
    for (BFNBaseViewController *controller in viewControllers) {
        controller.superNavigationController = navigationController;
    }
}

@end
