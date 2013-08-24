//
//  ZYPublicHomeCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-24.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"

@interface ZYPublicHomeCell : UITableViewCell
{
    BFAttributedView *contentTextView;
    UILabel *dateView;
    UIImageView      *relationImageView;
    
    UIImageView      *activeTypeImageView;
}

- (void)setContentDict:(NSDictionary*)contentDict;
+ (CGFloat)heightForContentDict:(NSDictionary*)content forTable:(UITableView*)table;

@end
