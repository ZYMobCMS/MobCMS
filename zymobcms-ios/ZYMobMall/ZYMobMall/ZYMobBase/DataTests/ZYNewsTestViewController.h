//
//  ZYNewsTestViewController.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNewsTestViewController : UIViewController
@property (nonatomic,retain)ZYNewsDataCenter *dataCenter;
@property (nonatomic,retain)ZYMenuItemModel *mItem;
@property (nonatomic,retain)NSMutableArray *newsListArray;
@property (nonatomic,retain)NSMutableArray *tabTypesArray;
@property (nonatomic,retain)NSMutableArray *commentListArray;

- (IBAction)newsTabTypes:(id)sender;
- (IBAction)newsList:(id)sender;
- (IBAction)newsDetail:(id)sender;
- (IBAction)favoriteNews:(id)sender;
- (IBAction)unFavoriteNews:(id)sender;
- (IBAction)newsCommentList:(id)sender;
- (IBAction)commentNews:(id)sender;
- (IBAction)supportComment:(id)sender;
- (IBAction)unSupportComment:(id)sender;

@end
