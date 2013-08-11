//
//  ArticleCommentCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"

@interface ArticleCommentCell : UITableViewCell
{
    BFAttributedView *commentContentView;
    UILabel *dateView;
    BFAttributedView *locationView;
}

- (void)setcontentDict:(NSDictionary*)contentDict;
+ (CGFloat)heightForContentDict:(NSDictionary*)contentDict forTable:(UITableView *)table;

@end
