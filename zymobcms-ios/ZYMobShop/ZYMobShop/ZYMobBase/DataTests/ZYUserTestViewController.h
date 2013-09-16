//
//  ZYUserTestViewController.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYUserTestViewController : UIViewController
@property (nonatomic,retain)ZYUserDataCenter *userDataCenter;
@property (nonatomic,retain)ZYUserActiveDataCenter *userActiveDataCenter;
@property (nonatomic,retain)ZYNewsDataCenter *newsDataCenter;
@property (nonatomic,retain)ZYPictureDataCenter *picDataCenter;
@property (nonatomic,retain)ZYProductDataCenter *proDataCenter;
@property (nonatomic,retain)ZYCommentDataCenter *commentDataCenter;
@property (nonatomic,retain)NSMutableArray *commentListArray;
@property (nonatomic,retain)NSMutableArray *favoriteListArray;

- (IBAction)rigistAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)userNewsCommentList:(id)sender;
- (IBAction)userPictureCommentList:(id)sender;
- (IBAction)userProductCommentList:(id)sender;
- (IBAction)userNewsFavoriteList:(id)sender;
- (IBAction)userPictureFavoriteList:(id)sender;
- (IBAction)userProductFavoriteList:(id)sender;
- (IBAction)userActiveHome:(id)sender;
- (IBAction)hotComments:(id)sender;

@end
