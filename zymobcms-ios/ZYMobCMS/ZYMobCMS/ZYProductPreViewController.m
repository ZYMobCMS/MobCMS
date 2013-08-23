//
//  ZYProductPreViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-23.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYProductPreViewController.h"
#import "ZYProductCommentViewController.h"

@interface ZYProductPreViewController ()

@end

@implementation ZYProductPreViewController

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

- (void)commentListAction
{
    ZYProductCommentViewController *commentVC = [[ZYProductCommentViewController alloc]initWithArticleId:self.pictureId];
    commentVC.mainTitle = @"跟贴";
    [ZYMobCMSUitil setBFNNavItemForReturn:commentVC];
    commentVC.commentBar.favoriteType = ZYFavoriteProduct;
    commentVC.commentBar.commentType = ZYCommentProduct;
    [self.navigationController pushViewController:commentVC animated:YES];
    [commentVC release];
}

- (void)getPictureDetail
{
    //set params
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setObject:self.pictureId forKey:@"productId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureDetailSuccess:" withFaildRequestMethod:@"getPictureDetailFaild:"];
}

- (void)favoriteAction
{
    if (self.isFavorited) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.pictureId forKey:@"productId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCancelFavoriteProduct withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteSuccess:" withFaildRequestMethod:@"favoriteFaild:"];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.pictureId forKey:@"productId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoriteProduct withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteSuccess:" withFaildRequestMethod:@"favoriteFaild:"];
    }
}

@end
