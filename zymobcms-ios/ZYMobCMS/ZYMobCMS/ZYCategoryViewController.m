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

@interface ZYCategoryViewController ()

@end

@implementation ZYCategoryViewController
@synthesize categoryId,currentTabType;
@synthesize requestFlag;

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
        pageIndex = 0;
    }
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,35,self.view.frame.size.width,self.view.frame.size.height-35-49-44) style:UITableViewStylePlain];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];
    
    // 拉取刷新
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]
                          initWithFrame:
                          CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, self.view.frame.size.width,_tableView.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    [listTable addSubview:_refreshHeaderView];
    [_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];
    
    if (!segmentArray) {
        segmentArray = [[NSMutableArray alloc]init];
    }
    segmentCtrl = [[BFSegmentControl alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,45) withDataSource:self];
    [self.view addSubview:segmentCtrl];
    [segmentCtrl release];
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
    return 320.0/segmentArray.count;
}

//对应索引项得标题是什么
- (NSString*)segmentControl:(BFSegmentControl*)sgmCtrl titleForItemAtIndex:(NSInteger)index
{
    NSDictionary *item = [segmentArray objectAtIndex:index];
    return [item objectForKey:@"name"];
}

//菜单选中了哪一项
- (void)segmentControl:(BFSegmentControl*)sgmCtrl didSelectAtIndex:(NSInteger)index
{
    NSDictionary *item = [segmentArray objectAtIndex:index];
    NSLog(@"item -->%@",item);
    
    self.currentTabType = [item objectForKey:@"id"];
    [self refresh];
}

#pragma mark - tableView delegate and source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60.0f;
    }else{
        CGFloat height = [BFNClassifyCell heightWithContent:[listArray objectAtIndex:indexPath.row] forTableView:tableView];
        return height;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *hotCell = @"hotCell";
        ZYHotNewsCell *cellHot = (ZYHotNewsCell*)[tableView dequeueReusableCellWithIdentifier:hotCell];
        
        if (cellHot == nil) {
            cellHot = [[[ZYHotNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotCell withSelectAction:^(NSString *articleId) {
                
            }]autorelease];
        }
        [cellHot setContentArray:[listArray objectAtIndex:indexPath.row]];
        return cellHot;
        
    }else{
        static NSString * myCell = @"ClassifyCell";
        BFNClassifyCell * cell = (BFNClassifyCell*)[tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[[BFNClassifyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
        }
        [cell setContent:[listArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == [listArray count] - 1))
    {
        BFLoadMoreView *footer = [[BFLoadMoreView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,45)];
        footer.titleLabel.textColor = [BFUitils rgbColor:158 green:158 blue:158];
        
        if (!hideLoadMore) {
            [footer addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
            footer.titleLabel.text = @"加载更多...";
            footer.userInteractionEnabled = YES;
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
    
}

#pragma mark - refresh
- (void)refreshContent
{
    [self getTabType];
    [_refreshHeaderView startLoading:listTable];
}

- (void)refresh{
    
    [_refreshHeaderView startLoading:listTable];
    _reloading = YES;
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
        
        [segmentArray addObjectsFromArray:tabTypes];
        self.currentTabType = [[tabTypes objectAtIndex:0]objectForKey:@"id"];
        
        [segmentCtrl reloadData];
        [self getNewsList];
    }
}

- (void)getTabTypeFaild:(NSDictionary*)resultDict
{
    
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
    NSLog(@"resultDict --->%@",resultDict);
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSDictionary *dataDict = [resultDict objectForKey:@"data"];
        
        if(_reloading){
            [listArray removeAllObjects];
        }
        
        NSArray *hotNews = [dataDict objectForKey:@"hotNews"];
        NSArray *normalList = [dataDict objectForKey:@"newsList"];
        
        [listArray addObject:hotNews];
        [listArray addObjectsFromArray:normalList];
        
        NSLog(@"listArray -->%@",listArray);
        
        [listTable reloadData];
    }
    
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }
}
- (void)getNewsListFaild:(NSDictionary*)resultDict
{
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }
}


@end
