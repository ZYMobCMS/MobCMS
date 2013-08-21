//
//  ZYProductDetail_0_Header_Cell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZYProductDetail_0_Header_CellHeight 120

@interface ZYProductDetail_0_Header_Cell : UITableViewCell
{
    BFImageView *contentImageView;
}
@property (nonatomic,retain)UIImageView *contentImageView;

- (void)setProductImageUrl:(NSString*)url;

@end
