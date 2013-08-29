//
//  ZYPublicHomeViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-24.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPublicHomeViewController.h"
#import "ZYPublicHomeCell.h"
#import "ZYProductDetail_0_ViewController.h"
#import "ZYPicturePreViewController.h"
#import "BFNArticleViewController.h"

@interface ZYPublicHomeViewController ()

@end

@implementation ZYPublicHomeViewController
@synthesize pageIndex;

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
    [listArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if(!listArray){
        listArray = [[NSMutableArray alloc]init];
        pageIndex = 0;
    }
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44) style:UITableViewStylePlain];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];
    self.pageIndex = 1;
    
    // 拉取刷新
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]
                          initWithFrame:
                          CGRectMake(0.0f, 0.0f - listTable.bounds.size.height, self.view.frame.size.width,listTable.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    [listTable addSubview:_refreshHeaderView];
    [_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];
    
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

#pragma mark - refresh
- (void)refreshContent
{
    [_refreshHeaderView startLoading:listTable];
}

- (void)refresh{

    [_refreshHeaderView startLoading:listTable];
    _reloading = YES;
    hideLoadMore = NO;
    self.pageIndex = 1;
    [self getPublicHomeList];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
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
    NSDictionary *item = [listArray objectAtIndex:indexPath.row];
    return [ZYPublicHomeCell heightForContentDict:item forTable:tableView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * myCell = @"PictureCell";
    ZYPublicHomeCell * cell = (ZYPublicHomeCell*)[tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[[ZYPublicHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
    }
    [cell setContentDict:[listArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *item = [listArray objectAtIndex:indexPath.row];
    NSString *relation = [item objectForKey:@"relation_table"];
    NSString *relationId = [item objectForKey:@"relation_id"];
    
    if ([relation rangeOfString:@"article"].location!=NSNotFound) {
        BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithArticleId:relationId];
        articleDetailVC.mainTitle = @"文章详情";
        [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
        [self.navigationController pushViewController:articleDetailVC animated:YES];
        [articleDetailVC enableSwipRightToReturn];
        [articleDetailVC release];
    }
    
    if ([relation rangeOfString:@"picture"].location!=NSNotFound) {
        ZYPicturePreViewController *preVC = [[ZYPicturePreViewController alloc]initWithImageString:[item objectForKey:@"images"] withSummaryText:[item objectForKey:@"summary"]];
        preVC.mainTitle = @"图片详情";
        preVC.pictureTitle = [item objectForKey:@"relation_title"];
        preVC.pictureId = relationId;
        [ZYMobCMSUitil setBFNNavItemForReturn:preVC];
        [self.navigationController pushViewController:preVC animated:YES];
        [preVC getPictureDetail];
        [preVC release];

    }
    
    if ([relation rangeOfString:@"product"].location!=NSNotFound) {
        ZYProductDetail_0_ViewController *detailVC = [[ZYProductDetail_0_ViewController alloc]init];
        detailVC.productId = relationId;
        detailVC.productImages = [item objectForKey:@"relation_images"];
        detailVC.productTitle = [item objectForKey:@"relation_title"];
        detailVC.mainTitle = @"产品详情";
        [ZYMobCMSUitil setBFNNavItemForReturn:detailVC];
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC release];
    }
    
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
    }
}
- (void)loadMore:(BFLoadMoreView*)loadView
{
    [loadView startAnimation];
    pageIndex ++;
    [self getPublicHomeList];
}

- (void)getPublicHomeList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserPublicHome withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPublicHomeListSuccess:" withFaildRequestMethod:@"getPublicHomeListFaild:"];
}

- (void)getPublicHomeListSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        
        if (_reloading) {
            [listArray removeAllObjects];
        }
                
        if (resultArray.count ==0 || resultArray.count <PageSize) {
            hideLoadMore = YES;
        }
        
        [listArray addObjectsFromArray:resultArray];
        
        [listTable reloadData];
        
    }else{
        NSString *errMsg = [resultDict objectForKey:@"msg"];
        [SVProgressHUD showErrorWithStatus:errMsg];
        BFLoadMoreView *footer = (BFLoadMoreView*)listTable.tableFooterView;
        [footer stopAnimation];
        self.pageIndex--;
    }
    
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }

}

- (void)getPublicHomeListFaild:(NSDictionary*)resultDict
{
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }
    self.pageIndex--;
}

- (void)getCategoryData
{
    [self refresh];
}

@end
