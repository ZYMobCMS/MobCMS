//
//  ZYChannelViewController.h
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRootMenuItemModel.h"

@interface ZYChannelViewController : ZYBaseViewController
{
    ZYNewsDataCenter *newsDataCenter;
    ZYPictureDataCenter *pictureDataCenter;
    ZYProductDataCenter *productDataCenter;
    
    NSMutableArray *listArray;
    NSInteger       currentPageIndex;
}
@property (nonatomic,retain)ZYRootMenuItemModel *menuItem;

- (id)initWithMenuItem:(ZYRootMenuItemModel *)mItem;

@end
