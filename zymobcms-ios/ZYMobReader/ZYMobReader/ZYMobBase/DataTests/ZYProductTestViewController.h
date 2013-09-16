//
//  ZYProductTestViewController.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYProductTestViewController : UIViewController
@property (nonatomic,retain)ZYProductDataCenter *dataCenter;
@property (nonatomic,retain)ZYMenuItemModel *mItem;
@property (nonatomic,retain)NSMutableArray *productListArray;
@property (nonatomic,retain)NSMutableArray *tabTypesArray;
@property (nonatomic,retain)NSMutableArray *commentListArray;

- (IBAction)productTabTypes:(id)sender;
- (IBAction)productList:(id)sender;
- (IBAction)productDetail:(id)sender;
- (IBAction)favoriteProduct:(id)sender;
- (IBAction)unFavoriteProduct:(id)sender;
- (IBAction)productCommentList:(id)sender;
- (IBAction)commentProduct:(id)sender;
- (IBAction)supportComment:(id)sender;
- (IBAction)unSupportComment:(id)sender;

@end
