//
//  ZYPictureCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-3.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageItem.h"

@class ZYPictureCell;
typedef void (^tapOnCellAction) (ZYPictureCell *tapCell,NSInteger tapItemIndex);
@interface ZYPictureCell : UITableViewCell
{
    tapOnCellAction _tapOnCellAction;
    
    ImageItem *leftItem;
    ImageItem *rightItem;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTapOnCell:(tapOnCellAction)tapOnCellAction;

- (void)setContentArray:(NSArray*)imageArray;

+ (CGFloat)pictureCellHeight;

@end
