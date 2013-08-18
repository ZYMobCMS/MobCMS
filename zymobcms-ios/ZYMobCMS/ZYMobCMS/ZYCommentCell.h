//
//  ZYCommentCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"

#define LeftMargin 10
#define TopMargin 10
#define TextMargin 10
#define TitleFontSize 14
#define ContentFontSize 13
#define ArticleTitleFontSize 11
#define ContentLineSpace 6

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
