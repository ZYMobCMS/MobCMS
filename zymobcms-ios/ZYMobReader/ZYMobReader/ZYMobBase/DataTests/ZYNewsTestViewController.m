//
//  ZYNewsTestViewController.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYNewsTestViewController.h"
#import "ZYNewsDetailViewController.h"

@interface ZYNewsTestViewController ()

@end

@implementation ZYNewsTestViewController
@synthesize mItem;
@synthesize dataCenter;
@synthesize newsListArray;
@synthesize tabTypesArray;
@synthesize commentListArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataCenter = [[ZYNewsDataCenter alloc]init];
        self.newsListArray = [[NSMutableArray alloc]init];
        self.tabTypesArray = [[NSMutableArray alloc]init];
        self.commentListArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)dealloc
{
    self.mItem = nil;
    self.dataCenter = nil;
    self.newsListArray = nil;
    self.tabTypesArray = nil;
    self.commentListArray = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //用户必须登陆的操作
    [self.dataCenter setUserDoThisActionShouldLoginFirst:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
        self.tabBarController.selectedIndex = 0;//user 
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newsTabTypes:(id)sender {
    
    [self.dataCenter startGetTabTypesByCategoryId:self.mItem.categoryId];
    [self.dataCenter setGetTabTypesSuccessAction:^(NSArray *modelArray) {
        [self.tabTypesArray addObjectsFromArray:modelArray];
        NSLog(@"news tab types --->%@",self.tabTypesArray);
        for (ZYTabTypeModel *item in modelArray) {
            
            NSLog(@"item name --->%@",item.name);
        }
    }];
    [self.dataCenter setGetTabTypesFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];

    }];
}

- (IBAction)newsList:(id)sender {
    ZYTabTypeModel *firstItem = [self.tabTypesArray objectAtIndex:0];
    
    [self.dataCenter startGetNewsListWithPageIndex:1 withCategoryId:firstItem.categoryId withTabTypeId:firstItem.tabTypeId];
    [self.dataCenter setGetNewsListSuccessAction:^(NSArray *modelArray) {
        [self.newsListArray addObjectsFromArray:modelArray];
        NSLog(@"news List ---->%@",self.newsListArray);
    }];
    [self.dataCenter setGetNewsListFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];

    }];
}

- (IBAction)newsDetail:(id)sender {
    
    ZYNewsDetailViewController *detailVC = [[ZYNewsDetailViewController alloc]init];
    detailVC.newsModel = [self.newsListArray objectAtIndex:3];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (IBAction)favoriteNews:(id)sender {
    
    ZYNewsModel *firstNews = [self.newsListArray objectAtIndex:1];
    [self.dataCenter favoriteArticleWithId:firstNews.articleId];
    [self.dataCenter setFavoriteArticleSuccess:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.dataCenter setFavoriteArticleFaild:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)unFavoriteNews:(id)sender {
    ZYNewsModel *firstNews = [self.newsListArray objectAtIndex:1];
    [self.dataCenter unFavoriteArticleWithArticleId:firstNews.articleId];
    [self.dataCenter setUnFavoriteArticleSuccess:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.dataCenter setUnFavoriteArticleFaild:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)newsCommentList:(id)sender {
    
    ZYNewsModel *firstNews = [self.newsListArray objectAtIndex:1];
    [self.dataCenter startGetArticleCommentListWithArticleId:firstNews.articleId withPageIndex:1];
    [self.dataCenter setGetArticleCommentListSuccessAction:^(NSArray *modelArray) {
        NSLog(@"news comment list --->%@",modelArray);
        [self.commentListArray addObjectsFromArray:modelArray];
    }];
    [self.dataCenter setGetArticleCommentListFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}

- (IBAction)commentNews:(id)sender {
    
    ZYNewsModel *firstNews = [self.newsListArray objectAtIndex:1];
    [self.dataCenter commentArticleWithId:firstNews.articleId withContent:@"清水飘过荷叶"];
    [self.dataCenter setCommentArticleSuccessAction:^(ZYCommentModel *commentModel) {
        NSLog(@"comment success name --->%@",commentModel.createTime);
    }];
    [self.dataCenter setCommentArticleFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}

- (IBAction)supportComment:(id)sender {
    ZYCommentModel *firstComment = [self.commentListArray objectAtIndex:0];
    [self.dataCenter supportCommentWithCommentId:firstComment.commentId];
    [self.dataCenter setSupportCommentSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];

    }];
    [self.dataCenter setSupportCommentFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];

    }];
}

- (IBAction)unSupportComment:(id)sender {
    ZYCommentModel *firstComment = [self.commentListArray objectAtIndex:0];
    [self.dataCenter unSupportCommentWithCommentId:firstComment.commentId];
    [self.dataCenter setUnSupportCommentSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];

    }];
    [self.dataCenter setUnSupportCommentFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];

    }];
}
@end
