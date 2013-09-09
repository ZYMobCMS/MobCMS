//
//  ZYUserTestViewController.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYUserTestViewController.h"

@interface ZYUserTestViewController ()

@end

@implementation ZYUserTestViewController
@synthesize userActiveDataCenter,userDataCenter,newsDataCenter,picDataCenter,proDataCenter,commentDataCenter;
@synthesize commentListArray,favoriteListArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userDataCenter = [[ZYUserDataCenter alloc]init];
        self.userActiveDataCenter = [[ZYUserActiveDataCenter alloc]init];
        self.newsDataCenter = [[ZYNewsDataCenter alloc]init];
        self.picDataCenter = [[ZYPictureDataCenter alloc]init];
        self.proDataCenter = [[ZYProductDataCenter alloc]init];
        self.commentDataCenter = [[ZYCommentDataCenter alloc]init];
        self.commentListArray = [[NSMutableArray alloc]init];
        self.favoriteListArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)dealloc
{
    self.commentDataCenter = nil;
    self.userActiveDataCenter = nil;
    self.userDataCenter = nil;
    self.newsDataCenter = nil;
    self.picDataCenter = nil;
    self.proDataCenter = nil;
    self.commentListArray = nil;
    self.favoriteListArray = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rigistAction:(id)sender {
    
    NSString *loginName = @"超级新秀";
    NSString *password = @"123";
    [self.userDataCenter startRigistWithName:loginName withPassword:password];
    [self.userDataCenter setRigistSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.userDataCenter setRigistFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)loginAction:(id)sender {
    
    NSString *loginName = @"超级新秀";
    NSString *password = @"123";
    
    [self.userDataCenter startLoginWithName:loginName withPassword:password];
    [self.userDataCenter setLoginSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.userDataCenter setLoginFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)userNewsCommentList:(id)sender {
    
    [self.userDataCenter startGetuserNewsCommentListWithPageIndex:1];
    [self.userDataCenter setGetUserNewsCommentListSuccessAction:^(NSArray *modelArray) {
        NSLog(@"user news comment list -->%@",modelArray);
        
        ZYCommentModel *firstComment = [modelArray objectAtIndex:0];
        
        [self.newsDataCenter startGetNewsDetailWithArticleId:firstComment.relationId];
        
    }];
    [self.userDataCenter setGetUserNewsCommentListFaild:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
    [self.newsDataCenter setGetNewsDetailSuccessAction:^(ZYNewsModel *detailModel) {
        NSLog(@"user news comment article detail --->%@",detailModel.content);
    }];
    [self.newsDataCenter setGetNewsDetailFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)userPictureCommentList:(id)sender {
    
    [self.userDataCenter startGetUserPictureCommentListWithPageIndex:1];
    [self.userDataCenter setGetUserPicCommentListSuccessAction:^(NSArray *modelArray) {
        NSLog(@"user pict comment list --->%@",modelArray);
        ZYCommentModel *firstComment = [modelArray objectAtIndex:0];
        [self.picDataCenter startGetPictureDetailWithPictureId:firstComment.relationId];
    }];
    [self.userDataCenter setGetUserPicCommentListFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    [self.picDataCenter setSuccessGetPictureDetailAction:^(ZYPictureModel *newPicture) {
        NSLog(@"picture detail content --->%@",newPicture.summary);
    }];
    [self.picDataCenter setFaildGetPictureDetailAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)userProductCommentList:(id)sender {
    [self.userDataCenter startGetUserProductCommentListWithPageIndex:1];
    [self.userDataCenter setGetuserProductCommentListSuccessAction:^(NSArray *modelArray) {
        NSLog(@"product comment lis -->%@",modelArray);
        ZYCommentModel *firstComment = [modelArray objectAtIndex:0];
        [self.proDataCenter startGetProductDetailWithProductId:firstComment.relationId];
    }];
    [self.userDataCenter setGetUserProductCommentListFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    [self.proDataCenter setGetProductDetailSuccessAction:^(ZYProductModel *proudctModel) {
        NSLog(@"product detail content --->%@",proudctModel.content);
    }];
    [self.proDataCenter setGetProductDetailFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)userNewsFavoriteList:(id)sender {
    [self.userDataCenter startGetUserNewsFavListWithPageIndex:1];
    [self.userDataCenter setGetUserNewsFavSuccessAction:^(NSArray *modelArray) {
        NSLog(@"user news favorite list -->%@",modelArray);
        ZYNewsModel *firstNews = [modelArray objectAtIndex:0];
        [self.newsDataCenter startGetNewsDetailWithArticleId:firstNews.articleId];
    }];
    [self.userDataCenter setGetUserNewsFavFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)userPictureFavoriteList:(id)sender {
    [self.userDataCenter startGetUserPicFavListWithPageIndex:1];
    [self.userDataCenter setGetuserPicFavSuccessAction:^(NSArray *modelArray) {
       
        NSLog(@"user picture favorite list ---->%@",modelArray);
        ZYPictureModel *firstPic = [modelArray objectAtIndex:0];
        [self.picDataCenter startGetPictureDetailWithPictureId:firstPic.pictureId];
        
    }];
    [self.userDataCenter setGetuserPicFavFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)userProductFavoriteList:(id)sender {
    
    [self.userDataCenter startGetUserProductFavListWithPageIndex:1];
    [self.userDataCenter setGetUserProductFavSuccess:^(NSArray *modelArray) {
        NSLog(@"user product favorite list --->%@",modelArray);
        ZYProductModel *firstPro = [modelArray objectAtIndex:0];
        [self.proDataCenter startGetProductDetailWithProductId:firstPro.productId];
    }];
    [self.userDataCenter setGetuserProductFavFaild:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}

- (IBAction)userActiveHome:(id)sender {
    
    [self.userActiveDataCenter startGetUserActiveListWithPageIndex:1];
    [self.userActiveDataCenter setGetUserActiveListSuccess:^(NSArray *modelArray) {
        
        NSLog(@"user active list --->%@",modelArray);
        
    }];
    [self.userActiveDataCenter setGetUserActiveListFaild:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)hotComments:(id)sender {
    
    [self.commentDataCenter startGetHotCommentListWithPageIndex:1];
    [self.commentDataCenter setGetHotCommentListSuccessAction:^(NSArray *modelArray) {
       
        NSLog(@"hot comment list --->%@",modelArray);
        ZYCommentModel *firstComment = [modelArray objectAtIndex:0];
        [self.newsDataCenter startGetNewsDetailWithArticleId:firstComment.relationId];
        
    }];
    [self.commentDataCenter setGetHOtCommentListFaildAction:^(NSString *errMsg) {
        
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}
@end
