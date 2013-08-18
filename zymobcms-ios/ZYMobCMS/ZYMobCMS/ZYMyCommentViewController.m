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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getHotCommentList
{
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[ZYUserManager getCurrentUserId] forKey:@"userId"];
    [params setObject:[NSNumber numberWithInt:self.pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize ] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserComment  withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getHotCommentListSuccess:" withFaildRequestMethod:@"getHotCommentListFaild:"];
    
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
    BFNArticleViewController *articleDetailVC = [[BFNArticleViewController alloc]initWithArticleId:[[self.sourceArray objectAtIndex:indexPath.row]objectForKey:@"article_id"]];
    articleDetailVC.mainTitle = @"文章详情";
    [self.navigationController pushViewController:articleDetailVC animated:YES];
    [ZYMobCMSUitil setBFNNavItemForReturn:articleDetailVC];
    [articleDetailVC enableSwipRightToReturn];
    [articleDetailVC release];
}

@end
