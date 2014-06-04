//
//  ZYCategoryViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYCategoryViewController.h"
#import "BFNClassifyCell.h"
#import "ZYHotNewsCell.h"
#import "ZYCategoryCell.h"
#import "BFNArticleViewController.h"

@interface ZYCategoryViewController ()

@end

@implementation ZYCategoryViewController
@synthesize categoryId,currentTabType;
@synthesize requestFlag,pageIndex;
@synthesize segmentCtrl,listTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc{
    
    self.requestFlag = nil;
    self.currentTabType = nil;
    self.categoryId = nil;
    [segmentArray release];
    [listArray release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

   
    
    if(!listArray){
        listArray = [[NSMutableArray alloc]init];
        self.pageIndex = 1;
    }
    CGFloat yDetal = IS_IOS_7? 20.f:0;
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,35+50,self.view.frame.size.width,self.view.frame.size.height-35-44-yDetal-50) style:UITableViewStylePlain];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];
    self.pageIndex = 1;
    
    //MoGo
    adView = [[AdMoGoView alloc] initWithAppKey:MoGo_ID_IPhone
                                         adType:AdViewTypeNormalBanner                                adMoGoViewDelegate:self];
    adView.adWebBrowswerDelegate = self;
    adView.frame = CGRectMake(0.0,33, 320.0, 50.0);
    [self.view addSubview:adView];
    [adView release];
    
    // 拉取刷新
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]
                          initWithFrame:
                          CGRectMake(0.0f, 0.0f - listTable.bounds.size.height, self.view.frame.size.width,listTable.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    [listTable addSubview:_refreshHeaderView];
    [_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];
    [_refreshHeaderView startLoading:listTable];
    
    if (!segmentArray) {
        segmentArray = [[NSMutableArray alloc]init];
    }
    segmentCtrl = [[BFSegmentControl alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,45) withDataSource:self];
    [self.view addSubview:segmentCtrl];
    [segmentCtrl release];
    

    
    //设置右上角刷新
    BFNBarButton *refreshBtn = [[BFNBarButton alloc]initWithFrame:CGRectMake(0,0,29,29) withImage:[UIImage imageNamed:@"refresh.png"] withTapOnBarButton:^(BFNBarButton *sender) {
        [self refresh];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:refreshBtn];
    [refreshBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];    
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
    NSDictionary *item = [segmentArray objectAtIndex:index];
    return [item objectForKey:@"name"];
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
    NSDictionary *item = [segmentArray objectAtIndex:index];
//    NSLog(@"item -->%@",item);
    
    pageIndex = 1;
    self.currentTabType = [item objectForKey:@"id"];
    [self refresh];
}

#pragma mark - tableView delegate and source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[listArray objectAtIndex:0] isKindOfClass:[NSArray class]]&&[[listArray objectAtIndex:0]count]>0) {
        if (indexPath.row == 0) {
            return 170.0f;
        }else{
            CGFloat height = [ZYCategoryCell heightForContent:[listArray objectAtIndex:indexPath.row]];
            return height;
        }
    }else{
        CGFloat height = [ZYCategoryCell heightForContent:[listArray objectAtIndex:indexPath.row]];
        return height;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[listArray objectAtIndex:0] isKindOfClass:[NSArray class]]&&[[listArray objectAtIndex:0]count]>0) {
        
        if (indexPath.row == 0) {
            
            static NSString *hotCell = @"hotCell";
            ZYHotNewsCell *cellHot = (ZYHotNewsCell*)[tableView dequeueReusableCellWithIdentifier:hotCell];
            
            if (cellHot == nil) {
                cellHot = [[[ZYHotNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotCell withSelectAction:^(NSDictionary *articleItem) {
                    BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithBaseContentDict:articleItem];
                    articleDetailVC.mainTitle = @"文章详情";
                    [self.navigationController pushViewController:articleDetailVC animated:YES];
                    [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
                    [articleDetailVC enableSwipRightToReturn];
                    [articleDetailVC release];
                }]autorelease];
            }
            [cellHot setContentArray:[listArray objectAtIndex:indexPath.row]];
            if (listTable.decelerating==NO||listTable.dragging==NO) {
                [cellHot setImageInfo:[listArray objectAtIndex:indexPath.row]];
            }
            
            return cellHot;
            
        }else{
            static NSString * myCell = @"ClassifyCell";
            ZYCategoryCell * cell = (ZYCategoryCell*)[tableView dequeueReusableCellWithIdentifier:myCell];
            if (cell == nil) {
                cell = [[[ZYCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
            }
            [cell setcontentDict:[listArray objectAtIndex:indexPath.row]];
            NSString *firstImage = [[[[listArray objectAtIndex:indexPath.row]objectForKey:@"images"]componentsSeparatedByString:@"|"]objectAtIndex:0];
            if ([BFImageCache imageForUrl:firstImage]) {
                cell.contentImageView.image = [BFImageCache imageForUrl:firstImage];
            }else{
                if (listTable.decelerating==NO||listTable.dragging==NO) {
                    [cell setImageInfo:[listArray objectAtIndex:indexPath.row]];
                }
                cell.contentImageView.image = [UIImage imageNamed:@"img_faild.png"];
            }
            
            return cell;
        }

        
    }else{
        static NSString * myCell = @"ClassifyCell";
        ZYCategoryCell * cell = (ZYCategoryCell*)[tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[[ZYCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
        }
        [cell setcontentDict:[listArray objectAtIndex:indexPath.row]];
        if ([BFImageCache imageForUrl:[[listArray objectAtIndex:indexPath.row]objectForKey:@"images"]]) {
            NSString *firstImage = [[[[listArray objectAtIndex:indexPath.row]objectForKey:@"images"]componentsSeparatedByString:@"|"]objectAtIndex:0];
            cell.contentImageView.image = [BFImageCache imageForUrl:firstImage];
        }else{
            if (listTable.decelerating==NO||listTable.dragging==NO) {
                [cell setImageInfo:[listArray objectAtIndex:indexPath.row]];
            }
            cell.contentImageView.image = [UIImage imageNamed:@"img_faild.png"];
        }

        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[listArray objectAtIndex:0]isKindOfClass:[NSArray class]]&&[[listArray objectAtIndex:0]count]>0) {
        
        if (indexPath.row != 0) {
            BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithBaseContentDict:[listArray objectAtIndex:indexPath.row]];
            articleDetailVC.mainTitle = @"文章详情";
            [self.navigationController pushViewController:articleDetailVC animated:YES];
            [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
            [articleDetailVC enableSwipRightToReturn];
            [articleDetailVC release];
        }
        
    }else{
        
        BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithBaseContentDict:[listArray objectAtIndex:indexPath.row]];
        articleDetailVC.mainTitle = @"文章详情";
        [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
        [self.navigationController pushViewController:articleDetailVC animated:YES];
        [articleDetailVC enableSwipRightToReturn];
        [articleDetailVC release];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - 加载可见cell
- (void)loadAllVisiableCellContent
{
    NSArray *visiablePaths = [listTable indexPathsForVisibleRows];
    for (NSIndexPath *vPath in visiablePaths) {
        
        UITableViewCell *cell = [listTable cellForRowAtIndexPath:vPath];
        if ([cell isKindOfClass:[ZYHotNewsCell class]]) {
            
            ZYHotNewsCell *vCell = (ZYHotNewsCell*)cell;
            [vCell setImageInfo:[listArray objectAtIndex:vPath.row]];
        }
        if ([cell isKindOfClass:[ZYCategoryCell class]]) {
            
            ZYCategoryCell *vCell = (ZYCategoryCell *)cell;
            [vCell setImageInfo:[listArray objectAtIndex:vPath.row]];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadAllVisiableCellContent];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == [listArray count] - 1))
    {
        BFLoadMoreView *footer = [[BFLoadMoreView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,45)];
        footer.titleLabel.textColor = [BFUitils rgbColor:158 green:158 blue:158];
        
        if (!hideLoadMore) {
//            [footer addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
            footer.titleLabel.text = @"加载更多...";
//            footer.userInteractionEnabled = YES;
            [self loadMore:footer];
        }else {
            NSString *title = @"已是最后一页";
            if (listArray == 0) {
                title = @"没有获取到内容";
            }
            footer.titleLabel.text = title;
            footer.userInteractionEnabled = NO;
        }
        tableView.tableFooterView = footer;
        [footer release];
    }
}

- (void)loadMore:(BFLoadMoreView*)loadView
{
    [loadView startAnimation];
    pageIndex ++;
    [self getNewsList];
}

#pragma mark - refresh
- (void)refreshContent
{
    [self getTabType];
    [_refreshHeaderView startLoading:listTable];
}

- (void)refresh{
    
    if (self.isCategoryType) {
        if (segmentArray.count==0) {
            _reloading = YES;
            [self refreshContent];
            return;
        }
    }
    
    [_refreshHeaderView startLoading:listTable];
    _reloading = YES;
    hideLoadMore = NO;
    self.pageIndex = 1;
    [self getNewsList];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
    if (!decelerate) {
        [self loadAllVisiableCellContent];
    }
    
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
    //在这里写更新的数据
	[self performSelector:@selector(refresh) withObject:nil afterDelay:.0];
	
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


#pragma mark - tabType
- (void)getTabType
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.categoryId forKey:@"categoryId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeTabType withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getTabTypeSuccess:" withFaildRequestMethod:@"getTabTypeFaild:"];
}

- (void)getTabTypeSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    
    if (status) {
        
        NSArray *tabTypes = [resultDict objectForKey:@"data"];
        
        [segmentArray removeAllObjects];
        [segmentArray addObjectsFromArray:tabTypes];
        self.currentTabType = [[tabTypes objectAtIndex:0]objectForKey:@"id"];
        
        [segmentCtrl reloadData];
        [self getNewsList];
    }else{
        if (_reloading) {
            _reloading = NO;
        }
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
    }
    
}

- (void)getTabTypeFaild:(NSDictionary*)resultDict
{
    if (_reloading) {
        _reloading = NO;
    }
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];

}


#pragma mark - NewsList
- (void)getNewsList
{
    if (self.requestFlag ) {
        [[BFNetWorkHelper shareHelper]cancelRequestWithTimeStamp:self.requestFlag];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.categoryId) {
        [params setObject:self.categoryId forKey:@"categoryId"];
    }
    [params setObject:self.currentTabType forKey:@"tabTypeId"];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"pageSize"];
    
    self.requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeNewsList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getNewsListSuccess:" withFaildRequestMethod:@"getNewsListFaild:"];
}

- (void)getNewsListSuccess:(NSDictionary*)resultDict
{
//    NSLog(@"resultDict --->%@",resultDict);
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSDictionary *dataDict = [resultDict objectForKey:@"data"];
        
        if(_reloading){
            [listArray removeAllObjects];
        }

        if ([[resultDict objectForKey:@"data"]isKindOfClass:[NSDictionary class]]) {
            NSArray *hotNews = [dataDict objectForKey:@"hotNews"];
            NSArray *normalList = [dataDict objectForKey:@"newsList"];
            
            if (pageIndex==1) {
                if (hotNews.count>0) {
                    [listArray addObject:hotNews];
                }
            }else{
                if (normalList.count ==0 || normalList.count <PageSize) {
                    hideLoadMore = YES;
                }
            }
            [listArray addObjectsFromArray:normalList];
            
        }else{
            NSArray *resultArray = [resultDict objectForKey:@"data"];
            if (resultArray.count ==0 || resultArray.count <PageSize) {
                hideLoadMore = YES;
            }
            [listArray addObjectsFromArray:resultArray];
        }
        
        [listTable reloadData];
        
        if ([listArray count]==0) {
            BFLoadMoreView *footer = [[BFLoadMoreView alloc]initWithFrame:CGRectMake(0,0,self.listTable.frame.size.width,45)];
            footer.titleLabel.textColor = [BFUitils rgbColor:158 green:158 blue:158];
            footer.titleLabel.text = @"这里什么东西都没有~";
            self.listTable.tableFooterView = footer;
            [footer release];
        }
        
    }else{
        NSString *errMsg = [resultDict objectForKey:@"msg"];
        [SVProgressHUD showErrorWithStatus:errMsg];
        BFLoadMoreView *footer = (BFLoadMoreView*)listTable.tableFooterView;
        [footer stopAnimation];
        if (self.pageIndex>1) {
            self.pageIndex--;
        }
        
    }
    
    if (_reloading) {
        _reloading = NO;
    }
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];

}
- (void)getNewsListFaild:(NSDictionary*)resultDict
{
    if (_reloading) {
        _reloading = NO;
    }
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
    if (self.pageIndex>1) {
        self.pageIndex--;
    }
}

- (void)getListData
{
    [self refresh];
}
- (void)getCategoryData
{
    if (segmentArray.count>0) {
        return;
    }
    [_refreshHeaderView startLoading:listTable];
    [self getTabType];
}

#pragma mark -
#pragma mark AdMoGoDelegate delegate
/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingModalView{
    return self;
}



/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告开始请求回调");
}
/**
 * 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告接收成功回调");
}
/**
 * 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error{
    NSLog(@"广告接收失败回调");
}
/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView{
    NSLog(@"点击广告回调");
}
/**
 *You can get notified when the user delete the ad
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告关闭回调");
}

#pragma mark -
#pragma mark AdMoGoWebBrowserControllerUserDelegate delegate

/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear{
    NSLog(@"浏览器将要展示");
}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear{
    NSLog(@"浏览器已经展示");
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed{
    NSLog(@"浏览器将要关闭");
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed{
    NSLog(@"浏览器已经关闭");
}
/**
 *直接下载类广告 是否弹出Alert确认
 */
-(BOOL)shouldAlertQAView:(UIAlertView *)alertView{
    return NO;
}

- (void)webBrowserShare:(NSString *)url{
    
}


@end
