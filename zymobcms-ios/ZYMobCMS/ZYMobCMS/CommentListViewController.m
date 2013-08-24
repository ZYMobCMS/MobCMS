//
//  CommentListViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "CommentListViewController.h"
#import "ArticleCommentCell.h"
#import "BFNLeftNavBarItem.h"
#import "ZYLoginViewController.h"

#define PageSize 10

@interface CommentListViewController ()

@end

@implementation CommentListViewController
@synthesize articleId;
@synthesize sourceArray;
@synthesize listTable;
@synthesize pageIndex;
@synthesize commentBar;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (id)initWithArticleId:(NSString *)aId
{
    if (self = [super init]) {
        
        sourceArray = [[NSMutableArray alloc]init];
        
        self.articleId = aId;
        
        if (self.articleId) {
            [self getCommentList];
        }
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    
    self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-106*2/6)];
    self.listTable.dataSource = self;
    self.listTable.delegate = self;
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
    
    //add commentBAr
    commentBar = [[ZYCommentBar alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-106*2/6-44,self.view.frame.size.width, 106*2/6) withBeginAction:^{
        
        //
        if (![ZYUserManager userIsLogined]) {
            ZYLoginViewController *loginVC = [[ZYLoginViewController alloc]init];
            loginVC.mainTitle = @"登录";
            [ZYMobCMSUitil setBFNNavItemForReturn:loginVC];
            [loginVC setSuccessLoginAction:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [self.navigationController pushViewController:loginVC animated:YES];
            [loginVC release];
            [commentBar commentReset];
        }else{
            UIControl *whiteBoard = [[UIControl alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
            whiteBoard.alpha = 0.1;
            whiteBoard.tag = 111222;
            [whiteBoard addTarget:self action:@selector(whilteBoardTouchDown) forControlEvents:UIControlEventTouchDown];
            [self.view insertSubview:whiteBoard belowSubview:commentBar];
            [whiteBoard release];
        }
        
        
    } withEndAction:^{
        
        if ([self.view viewWithTag:111222]) {
            [[self.view viewWithTag:111222]removeFromSuperview];
        }
    }];
    commentBar.layer.cornerRadius = 3.0f;
    commentBar.layer.borderWidth = 2.0f;
    commentBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    commentBar.layer.shadowOpacity = 0.6;
    commentBar.layer.shadowOffset = CGSizeMake(3.0f,-2.0f);
    commentBar.articleId = self.articleId;
    [self.view addSubview:commentBar];
    [commentBar release];


}

- (void)whilteBoardTouchDown
{
    [commentBar commentReset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh{
    
    [_refreshHeaderView startLoading:listTable];
    _reloading = YES;
    [self getCommentList];
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
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *baseView = [[[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,22)]autorelease];
    
    UIImageView *newestView = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,72,22)];
    newestView.image = [UIImage imageNamed:@"last_comment.png"];
    [baseView addSubview:newestView];
    [newestView release];
    
    return baseView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [sourceArray objectAtIndex:indexPath.row];
    
    return [ArticleCommentCell heightForContentDict:item forTable:tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ArticleCommentCell *cell = (ArticleCommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[ArticleCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        [cell setTapOnSupportAction:^{
            if (![ZYUserManager userIsLogined]) {
                ZYLoginViewController *loginVC = [[ZYLoginViewController alloc]init];
                loginVC.mainTitle = @"登录";
                [ZYMobCMSUitil setBFNNavItemForReturn:loginVC];
                [loginVC setSuccessLoginAction:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [self.navigationController pushViewController:loginVC animated:YES];
                [loginVC release];
                return;
            }
        }];
    }
    [cell setcontentDict:[sourceArray objectAtIndex:indexPath.row]];
    
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
    [self getCommentList];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)getCommentList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.articleId forKey:@"articleId"];
    [params setObject:[NSNumber numberWithInt:self.pageIndex]  forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeArticleComment withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getCommentListSuccess:" withFaildRequestMethod:@"getCommentListFaild:"];
}

- (void)getCommentListSuccess:(NSDictionary*)resultDict
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
        
        //
        for (NSDictionary *item in resultArray) {
            NSMutableDictionary *newItem = [NSMutableDictionary dictionaryWithDictionary:item];
            [newItem setObject:[NSNumber numberWithInt:commentBar.commentType] forKey:ZYCommentTypeKey];
            [sourceArray addObject:newItem];
        }
        
        [self.listTable reloadData];
        
    }else{
        
    }
    
    if (_reloading) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listTable];
        _reloading = NO;
    }
}

- (void)getCommentListFaild:(NSDictionary*)resultDict
{
    
}

@end
