//
//  ZYTestViewController.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-3.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYMobBase.h"

@interface ZYTestViewController : UIViewController
{
    ZYMenuDataCenter *menuCenter;
    ZYUserDataCenter *userCenter;
    ZYProductDataCenter *productCenter;
    ZYPictureDataCenter *pictureCenter;
    ZYCommentDataCenter *commentCenter;
    ZYNewsDataCenter *newsCenter;
    
    NSMutableArray *newsListArray;
    NSMutableArray *picListArray;
    NSMutableArray *proListArray;
    NSMutableArray *userActiveArray;
    NSMutableArray *newsCommentArray;
    NSMutableArray *picCommentArray;
    NSMutableArray *proCommentArray;
    NSMutableArray *menuArray;
}

- (IBAction)LoginAction:(id)sender;
- (IBAction)userNewsCommentAction:(id)sender;
- (IBAction)rigistAction:(id)sender;
- (IBAction)userPictureComment:(id)sender;
- (IBAction)userProductComment:(id)sender;
- (IBAction)userNewsFavorite:(id)sender;
- (IBAction)userPictureFavorite:(id)sender;
- (IBAction)userProductFavorite:(id)sender;
- (IBAction)newsCommentList:(id)sender;
- (IBAction)commentNews:(id)sender;
- (IBAction)favoriteNews:(id)sender;
- (IBAction)cancelFavoriteNews:(id)sender;
- (IBAction)newsList:(id)sender;
- (IBAction)pictureList:(id)sender;
- (IBAction)pictureCommentList:(id)sender;
- (IBAction)supportNewsComment:(id)sender;
- (IBAction)favoritePicture:(id)sender;
- (IBAction)cancelFavoritePicture:(id)sender;
- (IBAction)unsupportNewsComment:(id)sender;
- (IBAction)unsupportPictComment:(id)sender;
- (IBAction)supportPicComment:(id)sender;
- (IBAction)commentPicture:(id)sender;
- (IBAction)productList:(id)sender;
- (IBAction)productCommentList:(id)sender;
- (IBAction)commentProduct:(id)sender;
- (IBAction)favoriteProduct:(id)sender;
- (IBAction)cancelFavoriteProduct:(id)sender;
- (IBAction)supportProductComment:(id)sender;
- (IBAction)unsupportProductComment:(id)sender;
- (IBAction)userAcitveList:(id)sender;

@end
