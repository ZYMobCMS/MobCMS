//
//  ZYPictureController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPictureController.h"
#import "BFNImagePreViewController.h"
#import "ZYPicturePreViewController.h"
#import "BFLoadMoreView.h"

#define PageSize 10

@interface ZYPictureController ()

@end

@implementation ZYPictureController
@synthesize categoryId,currentTabType;
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
    self.categoryId = nil;
    self.currentTabType = nil;
    [tabTypeArray release];
    [sourceArray release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    sourceArray = [[NSMutableArray alloc]init];
    tabTypeArray = [[NSMutableArray alloc]init];
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44)];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    if (self.isCategoryType) {
        if (tabTypeArray.count==0) {
            [self getAllTabTypes];
            return;
        }
    }
    
    [_refreshHeaderView startLoading:listTable];
    _reloading = YES;
    self.pageIndex = 1;
    [self getPictureList];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [sourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZYPictureCell pictureCellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PictureCell";
    ZYPictureCell *cell = (ZYPictureCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[ZYPictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withTapOnCell:^(ZYPictureCell *tapCell,NSInteger tapItemIndex) {
        
            NSIndexPath *cellIndexPath = [tableView indexPathForCell:tapCell];
            NSDictionary *item = [[sourceArray objectAtIndex:cellIndexPath.row]objectAtIndex:tapItemIndex];
            
            ZYPicturePreViewController *preVC = [[ZYPicturePreViewController alloc]initWithImageString:[item objectForKey:@"images"] withSummaryText:[item objectForKey:@"summary"]];
            preVC.mainTitle = [item objectForKey:@"title"];
            preVC.pictureId = [item objectForKey:@"id"];
            preVC.pictureTitle = [item objectForKey:@"title"];
            [ZYMobCMSUitil setBFNNavItemForReturn:preVC];
            [self.navigationController pushViewController:preVC animated:YES];
            [preVC release];
            
            
        }]autorelease];
    }
    [cell setContentArray:[sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == [sourceArray count] - 1))
    {
        BFLoadMoreView *footer = [[BFLoadMoreView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,45)];
        footer.titleLabel.textColor = [BFUitils rgbColor:158 green:158 blue:158];
        
        if (!hideLoadMore) {
            [footer addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
            footer.titleLabel.text = @"加载更多...";
            footer.userInteractionEnabled = YES;
        }else {
            NSString *title = @"已是最后一页";
            if (sourceArray == 0) {
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
    [self getPictureList];
}

- (void)getPictureList
{    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:PageSize]  forKey:@"pageSize"];
    [params setObject:[NSNumber  numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:self.categoryId forKey:@"categoryId"];
    [params setObject:self.currentTabType forKey:@"tabTypeId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureListSuccess:" withFaildRequestMethod:@"getPictureListFaild:"];
}

- (void)getPictureListSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        NSLog(@"resultArray ___%@",resultArray);
        
        if (_reloading) {
            [sourceArray removeAllObjects];
        }
        
        if (resultArray.count ==0 || resultArray.count <PageSize) {
            hideLoadMore = YES;
        }
        
        for (int i=0; i<resultArray.count; i++) {
            
            if (i%2==0&&i!=0) {
                
                NSArray *subArray = [resultArray subarrayWithRange:NSMakeRange(i-2,2)];
                
                [sourceArray addObject:subArray];
            }
        }
        if (resultArray.count%2==1) {
            NSArray *subArray = [resultArray subarrayWithRange:NSMakeRange(resultArray.count-2,1)];
            [sourceArray addObject:subArray];
        }
        
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

- (void)getPictureListFaild:(NSDictionary*)resultDict
{
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }
    self.pageIndex--;

}

#pragma mark - 获取所有子分类
- (void)getAllTabTypes
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.categoryId forKey:@"categoryId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureTabTypes withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getAllTabTypesSuccess:" withFaildRequestMethod:@"getAllTabTypesFaild:"];
}
- (void)getAllTabTypesSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        NSLog(@"resultDict===>%@",resultDict);
        
        NSArray *allTabs = [resultDict objectForKey:@"data"];
        
        self.currentTabType = [[allTabs objectAtIndex:0]objectForKey:@"id"] ;
        
        [self getPictureList];
        
    }
}
- (void)getAllTabTypesFaild:(NSDictionary*)resultDict
{
    
}

- (void)getListData
{
    [self refresh];
}
- (void)getCategoryData
{
    if (tabTypeArray.count>0) {
        return;
    }
    [self getAllTabTypes];
}
@end
