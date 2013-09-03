//
//  ZYTestViewController.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-3.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYTestViewController.h"

@interface ZYTestViewController ()

@end

@implementation ZYTestViewController

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
    // Do any additional setup after loading the view from its nib.
    
    menuCenter = [[ZYMenuDataCenter alloc]init];
    userCenter = [[ZYUserDataCenter alloc]init];
    pictureCenter = [[ZYPictureDataCenter alloc]init];
    productCenter = [[ZYProductDataCenter alloc]init];
    commentCenter = [[ZYCommentDataCenter alloc]init];
    newsCenter = [[ZYNewsDataCenter alloc]init];
    
    newsListArray = [[NSMutableArray alloc]init];
    picListArray = [[NSMutableArray alloc]init];
    proListArray = [[NSMutableArray alloc]init];
    newsCommentArray = [[NSMutableArray alloc]init];
    picCommentArray = [[NSMutableArray alloc]init];
    proCommentArray = [[NSMutableArray alloc]init];
    menuArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginAction:(id)sender {
    
    [menuCenter startGetApplicationInfo];
    [menuCenter setGetApplicationInfoSuccessAction:^(ZYApplicationModel *appicationModel) {
        NSLog(@"application name %@",appicationModel.name);
    }];
    [menuCenter setGetApplicationInfoFaildAction:^(NSString *errMsg) {
        NSLog(@"application info faild --->%@",errMsg);
    }];
    [menuCenter startGetMenuList];
    [menuCenter setGetMenuListSuccessAction:^(NSArray *menuListArray) {
        [menuArray addObjectsFromArray:menuListArray];
    }];
    [menuCenter setGetMenuListFaildAction:^(NSString *errMsg) {
        NSLog(@"application menu faild -->%@",errMsg);
    }];
    
}

- (IBAction)userNewsCommentAction:(id)sender {
    
    
}

- (IBAction)rigistAction:(id)sender {
    
    
}

- (IBAction)userPictureComment:(id)sender {
}

- (IBAction)userProductComment:(id)sender {
}

- (IBAction)userNewsFavorite:(id)sender {
}

- (IBAction)userPictureFavorite:(id)sender {
}

- (IBAction)userProductFavorite:(id)sender {
}

- (IBAction)newsCommentList:(id)sender {
}

- (IBAction)commentNews:(id)sender {
}

- (IBAction)favoriteNews:(id)sender {
}

- (IBAction)cancelFavoriteNews:(id)sender {
}

- (IBAction)newsList:(id)sender {
    
    ZYMenuItemModel *newsItem = [menuArray objectAtIndex:0];
    [newsCenter startGetTabTypesByCategoryId:newsItem.categoryId];
    [newsCenter setGetTabTypesSuccessAction:^(NSArray *modelArray) {
        
        NSLog(@"menu tab types --->%@",modelArray);
        
        ZYTabTypeModel *firstItem = [modelArray objectAtIndex:1];
        [newsCenter startGetNewsListWithPageIndex:1 withCategoryId:firstItem.categoryId withTabTypeId:firstItem.tabTypeId];
        
    }];
    [newsCenter setGetTabTypesFaildAction:^(NSString *errMsg) {
        NSLog(@"getTabTypeFaild --->%@",errMsg);
    }];
    
    [newsCenter setGetNewsListSuccessAction:^(NSArray *modelArray) {
        
        [newsListArray addObjectsFromArray:modelArray];
        
        NSLog(@"newsList ---->%@",modelArray);
        
        for (ZYNewsModel *item in newsListArray) {
            
            NSLog(@"newsTitle --->%@",item.title);
        }
        
        ZYNewsModel *firstNews = [newsListArray objectAtIndex:0];
        
        [newsCenter startGetNewsDetailWithArticleId:firstNews.articleId];
    }];
    [newsCenter setGetNewsListFaildAction:^(NSString *errMsg) {
       
        NSLog(@"get news list faild --->%@",errMsg);
    }];
    
    [newsCenter setGetNewsDetailSuccessAction:^(ZYNewsModel *detailModel) {
        
        NSLog(@"article detail content --->%@",detailModel.content);
        
    }];
    [newsCenter setGetNewsDetailFaildAction:^(NSString *errMsg) {
        NSLog(@"article detail faild ----->%@",errMsg);
    }];
}

- (IBAction)pictureList:(id)sender {
    
    ZYMenuItemModel *picItem = [menuArray objectAtIndex:2];
    [pictureCenter startGetPictureTabTypesWithCategoryId:picItem.categoryId];
    [pictureCenter setGetTabTypesSuccessAction:^(NSArray *tabTypeArray) {
       
        ZYTabTypeModel *firstItem = [tabTypeArray objectAtIndex:0];
        
        NSLog(@"picture first tiem --->%@",firstItem.name);
        [pictureCenter startGetPictureListWithCategoryId:firstItem.categoryId withTabTypeId:firstItem.tabTypeId withPageIndex:1];
        
    }];
    [pictureCenter setGetTabTypesFaildAction:^(NSString *errMsg) {
        NSLog(@"get picture tab type faild--->%@",errMsg);
    }];
    [pictureCenter setSuccessGetNewPictureListAction:^(NSArray *newDataArray) {
        NSLog(@"picture list  ---->%@",newDataArray);
    }];
    [pictureCenter setFaildGetNewPictureListAction:^(NSString *errMsg) {
        NSLog(@"picture list faild ---->%@",errMsg);
    }];
}

- (IBAction)pictureCommentList:(id)sender {
}

- (IBAction)supportNewsComment:(id)sender {
}

- (IBAction)favoritePicture:(id)sender {
}

- (IBAction)cancelFavoritePicture:(id)sender {
}

- (IBAction)unsupportNewsComment:(id)sender {
}

- (IBAction)unsupportPictComment:(id)sender {
}

- (IBAction)supportPicComment:(id)sender {
}

- (IBAction)commentPicture:(id)sender {
}

- (IBAction)productList:(id)sender {
    
    ZYMenuItemModel *item = [menuArray objectAtIndex:3];
    [productCenter startGetProductTabTypeWithCategoryId:item.categoryId];
    [productCenter setGetProudctTabTypeSuccessAction:^(NSArray *listArray) {
        
        ZYTabTypeModel *firstItem = [listArray objectAtIndex:0];
        [productCenter startGetProductListWithCategorId:firstItem.categoryId withTabTypeId:firstItem.tabTypeId withPageIndex:1];
        
    }];
    [productCenter setgetProudctTabTypeFaildAction:^(NSString *errMsg) {
        
    }];
    
    [productCenter setGetProductListSuccessAction:^(NSArray *listArray) {
        
        NSLog(@"product listArray ---->%@",listArray);
        
    }];
    [productCenter setGetProudctListFaildAction:^(NSString *errMsg) {
        
    }];
}

- (IBAction)productCommentList:(id)sender {
}

- (IBAction)commentProduct:(id)sender {
}

- (IBAction)favoriteProduct:(id)sender {
}

- (IBAction)cancelFavoriteProduct:(id)sender {
}

- (IBAction)supportProductComment:(id)sender {
}

- (IBAction)unsupportProductComment:(id)sender {
}

- (IBAction)userAcitveList:(id)sender {
}
@end
