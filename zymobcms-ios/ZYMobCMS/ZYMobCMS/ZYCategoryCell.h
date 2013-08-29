//
//  ZYCategoryCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"

@interface ZYCategoryCell : UITableViewCell
{
    BFAttributedView *titleView;
    BFAttributedView *sourceView;
    BFAttributedView *summarayView;
    BFImageView      *contentImageView;
}
@property (nonatomic,retain)BFImageView *contentImageView;

- (void)setcontentDict:(NSDictionary*)content;
- (void)setImageInfo:(NSDictionary*)content;

+ (CGFloat)heightForContent:(NSDictionary*)content;

@end
