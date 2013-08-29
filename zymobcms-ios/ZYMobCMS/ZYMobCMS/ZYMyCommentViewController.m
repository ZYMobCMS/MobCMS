//
//  ZYMyCommentViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-14.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMyCommentViewController.h"
#import "BFNArticleViewController.h"
#import "ZYMyCommentCell.h"
#import "ZYPicturePreViewController.h"
#import "ZYProductDetail_0_ViewController.h"

@interface ZYMyCommentViewController ()

@end

@implementation ZYMyCommentViewController

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
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_refreshHeaderView startLoading:self.listTable];

    self.listTable.frame = CGRectMake(0,35,self.view.frame.size.width,self.view.frame.size.height-35-44);
    if (!segmentArray) {
        segmentArray = [[NSMutableArray alloc]init];
        [segmentArray addObject:@"文章评论"];
        [segmentArray addObject:@"图片评论"];
        [segmentArray addObject:@"产品评论"];
    }
    segmentCtrl = [[BFSegmentControl alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,45) withDataSource:self];
    [self.view addSubview:segmentCtrl];
    currentRequestType = ZYCommentArticle;
    [segmentCtrl release];
    
    //设置右上角刷新
    BFNBarButton *refreshBtn = [[BFNBarButton alloc]initWithFrame:CGRectMake(0,0,29,29) withImage:[UIImage imageNamed:@"refresh.png"] withTapOnBarButton:^(BFNBarButton *sender) {
        [self refresh];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:refreshBtn];
    [refreshBtn release];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    if ([self.sourceArray count]==0) {
        BFLoadMoreView *footer = [[BFLoadMoreView alloc]initWithFrame:CGRectMake(0,0,self.listTable.frame.size.width,45)];
        footer.titleLabel.textColor = [BFUitils rgbColor:158 green:158 blue:158];
        footer.titleLabel.text = @"您还没有发表过评论";
        self.listTable.tableFooterView = footer;
        [footer release];
    }
    
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
    NSString *item = [segmentArray objectAtIndex:index];
    return item;
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
    currentRequestType = index;
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getHotCommentList
{
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:self.pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize ] forKey:@"pageSize"];
    
    ZYCMSRequestType requestType;
    switch (currentRequestType) {
        case ZYCommentArticle:
            requestType = ZYCMSRequestTypeUserComment;
            break;
        case ZYCommentPicture:
            requestType = ZYCMSRequestTypeUserPictureCommentList;
            break;
        case ZYCommentProduct:
            requestType = ZYCMSRequestTypeUserProductCommentList;
            break;
            
        default:
            break;
    }
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:requestType  withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getHotCommentListSuccess:" withFaildRequestMethod:@"getHotCommentListFaild:"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.sourceArray objectAtIndex:indexPath.row];
    
    return [ZYMyCommentCell heightWithContent:item forTable:tableView];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ZYMyCommentCell *cell = (ZYMyCommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[ZYMyCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    [cell setContentDict:[self.sourceArray objectAtIndex:indexPath.row]];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (currentRequestType) {
        case ZYCommentArticle:
        {
            BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithArticleId:[[self.sourceArray objectAtIndex:indexPath.row]objectForKey:@"article_id"]];
            articleDetailVC.mainTitle = @"文章详情";
            [self.navigationController pushViewController:articleDetailVC animated:YES];
            [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
            [articleDetailVC enableSwipRightToReturn];
            [articleDetailVC release];
        }
            break;
        case ZYCommentPicture:
        {
            NSDictionary *item = [self.sourceArray objectAtIndex:indexPath.row];
            ZYPicturePreViewController *preVC = [[ZYPicturePreViewController alloc]initWithImageString:[item objectForKey:@"images"] withSummaryText:[item objectForKey:@"summary"]];
            preVC.mainTitle = [item objectForKey:@"title"];
            preVC.pictureId = [item objectForKey:@"picture_id"];
            preVC.pictureTitle = [item objectForKey:@"title"];
            [ZYMobCMSUitil setBFNNavItemForReturn:preVC];
            [self.navigationController pushViewController:preVC animated:YES];
            [preVC release];
        }
            break;
        case ZYCommentProduct:
        {
            ZYProductDetail_0_ViewController *detailVC = [[ZYProductDetail_0_ViewController alloc]init];
            detailVC.productId = [[self.sourceArray objectAtIndex:indexPath.row]objectForKey:@"product_id"];
            detailVC.productImages = [[self.sourceArray objectAtIndex:indexPath.row]objectForKey:@"images"];
            detailVC.productTitle = [[self.sourceArray objectAtIndex:indexPath.row]objectForKey:@"title"];
            detailVC.mainTitle = @"产品详情";
            [ZYMobCMSUitil setBFNNavItemForReturn:detailVC];
            [self.navigationController pushViewController:detailVC animated:YES];
            [detailVC release];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
