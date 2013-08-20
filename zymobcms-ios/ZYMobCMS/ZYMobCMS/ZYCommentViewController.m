//
//  ZYCommentViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYCommentViewController.h"
#import "ZYCommentCell.h"
#import "BFNArticleViewController.h"

@interface ZYCommentViewController ()

@end

@implementation ZYCommentViewController
@synthesize articleId;
@synthesize sourceArray;
@synthesize listTable;
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
    self.articleId = nil;
    self.sourceArray= nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.sourceArray = [[NSMutableArray alloc]init];
    
    self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44)];
    self.listTable.dataSource = self;
    self.listTable.delegate = self;
    self.listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listTable];
    [self.listTable release];
    
    // 拉取刷新
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc]
                          initWithFrame:
                          CGRectMake(0.0f, 0.0f - listTable.bounds.size.height, self.view.frame.size.width,listTable.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    [listTable addSubview:_refreshHeaderView];
    [_refreshHeaderView release];
	[_refreshHeaderView refreshLastUpdatedDate];
    
    [self getHotCommentList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSDictionary *item = [sourceArray objectAtIndex:indexPath.row];
    
    return [ZYCommentCell heightWithContent:item forTable:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ZYCommentCell *cell = (ZYCommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[ZYCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        UIImageView *cellNormalBack = [[UIImageView alloc]init];
        cellNormalBack.backgroundColor = [BFUitils rgbColor:150 green:150 blue:150];
        cell.selectedBackgroundView = cellNormalBack;
        [cellNormalBack release];
    }
    [cell setContentDict:[sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithArticleId:[[self.sourceArray objectAtIndex:indexPath.row]objectForKey:@"article_id"]];
    articleDetailVC.mainTitle = @"文章详情";
    [self.navigationController pushViewController:articleDetailVC animated:YES];
    [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
    [articleDetailVC enableSwipRightToReturn];
    [articleDetailVC release];
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
    [self getHotCommentList];
}


- (void)refresh{
    
    [_refreshHeaderView startLoading:listTable];
    _reloading = YES;
    [self getHotCommentList];
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



#pragma mark - net work
- (void)getHotCommentList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeHotCommentList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getHotCommentListSuccess:" withFaildRequestMethod:@"getHotCommentListFaild:"];
}
- (void)getHotCommentListSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSArray *resultArray = [resultDict objectForKey:@"data"];
        
        if (resultArray.count ==0 || resultArray.count <PageSize) {
            hideLoadMore = YES;
        }
        
        if (_reloading) {
            [sourceArray removeAllObjects];
        }
        
        [sourceArray addObjectsFromArray:[resultDict objectForKey:@"data"]];
        
        [listTable reloadData];
    }
    
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }
    
}
- (void)getHotCommentListFaild:(NSDictionary*)resultDict
{
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }
}

@end
