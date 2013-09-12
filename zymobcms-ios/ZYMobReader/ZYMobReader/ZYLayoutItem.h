//
//  ZYLayoutItem.h
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"

typedef enum {
    
    ZYLayoutItemBig = 0,
    ZYLayoutItemNormal,
    ZYLayoutItemAllText,
    
}ZYLayoutItemStyle;

@interface ZYLayoutItem : UIControl
{
    BFAttributedView *titleView;
    BFAttributedView *dateSourceView;
    BFAttributedView *summaryView;
    BFImageView      *contentImgView;
    
    CGFloat           titleFontSize;
    CGFloat           dateFontSize;
    CGFloat           summaryFontSize;
}

- (void)setContentDict:(ZYNewsModel*)contentModel withConfigStyle:(ZYLayoutItemStyle)aStyle;

@end
