//
//  ZYRootMenuItem.h
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-10.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRootMenuItemModel.h"

@interface ZYRootMenuItem : UIControl
{
    BFImageView *backImgView;
    BFImageView *iconImgView;
    UILabel     *titleLabel;
}
@property (nonatomic,retain)NSIndexPath *indexPath;

- (id)initWithMenuItemModel:(ZYMenuItemModel*)menuItem withFrame:(CGRect)frame;
- (void)setContentModel:(ZYMenuItemModel*)menuItem;

@end
