//
//  ZYCommentCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"

@interface ZYCommentCell : UITableViewCell
{
    BFAttributedView *titleView;
    BFAttributedView *contentView;
    BFAttributedView *articleTitleView;
    BFAttributedView *dateView;
}

- (void)setContentDict:(NSDictionary*)contentDict;
+ (CGFloat)heightWithContent:(NSDictionary*)contentDict forTable:(UITableView*)table;

@end
