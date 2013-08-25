//
//  ZYMyPictureFavoriteViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-23.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMyPictureFavoriteViewController.h"
#import "ZYPicturePreViewController.h"

@interface ZYMyPictureFavoriteViewController ()

@end

@implementation ZYMyPictureFavoriteViewController

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
    listTable.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44-35);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPictureList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:PageSize]  forKey:@"pageSize"];
    [params setObject:[NSNumber  numberWithInt:pageIndex] forKey:@"pageIndex"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserPictureFavoriteList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureListSuccess:" withFaildRequestMethod:@"getPictureListFaild:"];
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
            preVC.pictureId = [item objectForKey:@"picture_id"];
            preVC.pictureTitle = [item objectForKey:@"title"];
            [ZYMobCMSUitil setBFNNavItemForReturn:preVC];
            [self.superNavigationController pushViewController:preVC animated:YES];
            [preVC release];
            
            
        }]autorelease];
    }
    [cell setContentArray:[sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
}


@end
