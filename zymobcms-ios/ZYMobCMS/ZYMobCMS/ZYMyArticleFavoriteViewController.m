//
//  ZYMyArticleFavoriteViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-23.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMyArticleFavoriteViewController.h"
#import "BFNArticleViewController.h"

@interface ZYMyArticleFavoriteViewController ()

@end

@implementation ZYMyArticleFavoriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.segmentCtrl.hidden = YES;
    self.listTable.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44-35);
    [_refreshHeaderView startLoading:listTable];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNewsList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:self.pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    
    self.requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserFavorite withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getNewsListSuccess:" withFaildRequestMethod:@"getNewsListFaild:"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:[listArray objectAtIndex:indexPath.row]];
    [item setObject:[[listArray objectAtIndex:indexPath.row]objectForKey:@"article_id"] forKey:@"id"];
    BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithBaseContentDict:item];
    articleDetailVC.mainTitle = @"文章详情";
    [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
    [self.superNavigationController pushViewController:articleDetailVC animated:YES];
    [articleDetailVC enableSwipRightToReturn];
    [articleDetailVC release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
