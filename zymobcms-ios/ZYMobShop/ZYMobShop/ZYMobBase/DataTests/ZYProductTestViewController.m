//
//  ZYProductTestViewController.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYProductTestViewController.h"

@interface ZYProductTestViewController ()

@end

@implementation ZYProductTestViewController
@synthesize mItem;
@synthesize dataCenter,tabTypesArray,productListArray,commentListArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataCenter = [[ZYProductDataCenter alloc]init];
        self.productListArray = [[NSMutableArray alloc]init];
        self.tabTypesArray = [[NSMutableArray alloc]init];
        self.commentListArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)dealloc
{
    self.mItem = nil;
    self.dataCenter = nil;
    self.productListArray = nil;
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

- (IBAction)productTabTypes:(id)sender {
    
    [self.dataCenter startGetProductTabTypeWithCategoryId:self.mItem.categoryId];
    [self.dataCenter setGetProudctTabTypeSuccessAction:^(NSArray *listArray) {
       
        NSLog(@"product tab types --->%@",listArray);
        [self.tabTypesArray addObjectsFromArray:listArray];
        
    }];
    [self.dataCenter setgetProudctTabTypeFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)productList:(id)sender {
    
    ZYTabTypeModel *firstTab = [self.tabTypesArray objectAtIndex:0];
    [self.dataCenter startGetProductListWithCategorId:firstTab.categoryId withTabTypeId:firstTab.tabTypeId withPageIndex:1];
    [self.dataCenter setGetProductListSuccessAction:^(NSArray *listArray) {
        
        NSLog(@"product list --->%@",listArray);
        [self.productListArray addObjectsFromArray:listArray];
    }];
    [self.dataCenter setGetProudctListFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)productDetail:(id)sender {
    
    ZYProductModel *firstItem = [self.productListArray objectAtIndex:0];
    [self.dataCenter startGetProductDetailWithProductId:firstItem.productId];
    [self.dataCenter setGetProductDetailSuccessAction:^(ZYProductModel *proudctModel) {
       
        NSLog(@"product detail content ---->%@",proudctModel.content);
        
    }];
    [self.dataCenter setGetProductDetailFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)favoriteProduct:(id)sender {
    
    ZYProductModel *firstItem = [self.productListArray objectAtIndex:0];
    [self.dataCenter favoriteProductWithProductId:firstItem.productId];
    [self.dataCenter setFavoriteProductSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.dataCenter setFavoriteProductFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)unFavoriteProduct:(id)sender {
    ZYProductModel *firstItem = [self.productListArray objectAtIndex:0];
    [self.dataCenter unFavoriteProductWithProductId:firstItem.productId];
    [self.dataCenter setUnFavoriteProductSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.dataCenter setUnFavoriteProductFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)productCommentList:(id)sender {
    ZYProductModel *firstItem = [self.productListArray objectAtIndex:0];
    [self.dataCenter startGetProductCommentListWithPictureId:firstItem.productId withPageIndex:1];
    [self.dataCenter setGetProductCommentListSuccessAction:^(NSArray *modelArray) {
       
        NSLog(@"product comment list  ---->%@",modelArray);
        [self.commentListArray addObjectsFromArray:modelArray];
        
    }];
    [self.dataCenter setGetProductCommentListFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)commentProduct:(id)sender {
    
    ZYProductModel *firstItem = [self.productListArray objectAtIndex:0];
    [self.dataCenter commentProductWithProductId:firstItem.productId withContent:@"非常喜欢啊"];
    [self.dataCenter setCommentProductSuccessAction:^(ZYCommentModel *commentModel) {
        
        [SVProgressHUD showSuccessWithStatus:commentModel.createTime];
    }];
    [self.dataCenter setCommentProductFaildAction:^(NSString *errMsg) {
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
