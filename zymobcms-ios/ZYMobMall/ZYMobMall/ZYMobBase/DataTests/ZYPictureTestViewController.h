//
//  ZYPictureTestViewController.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPictureTestViewController : UIViewController
@property (nonatomic,retain)ZYPictureDataCenter *dataCenter;
@property (nonatomic,retain)ZYMenuItemModel *mItem;
@property (nonatomic,retain)NSMutableArray *picListArray;
@property (nonatomic,retain)NSMutableArray *tabTypesArray;
@property (nonatomic,retain)NSMutableArray *commentListArray;

- (IBAction)pictureTabTypes:(id)sender;
- (IBAction)pictureList:(id)sender;
- (IBAction)pictureDetail:(id)sender;
- (IBAction)favoritePicture:(id)sender;
- (IBAction)unFavoritePicture:(id)sender;
- (IBAction)pictureCommentList:(id)sender;
- (IBAction)commentPicture:(id)sender;
- (IBAction)supportComment:(id)sender;
- (IBAction)unSupportComment:(id)sender;

@end
