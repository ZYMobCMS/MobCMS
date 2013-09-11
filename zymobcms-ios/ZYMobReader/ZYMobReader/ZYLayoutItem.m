//
//  ZYLayoutItem.m
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYLayoutItem.h"

@implementation ZYLayoutItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect initRect = CGRectMake(0,0,1,1);
        
        titleView = [[BFAttributedView alloc]initWithFrame:initRect];
        [self addSubview:titleView];
        [titleView release];
        
        dateSourceView = [[BFAttributedView alloc]initWithFrame:initRect];
        [self addSubview:dateSourceView];
        [dateSourceView release];
        
        summaryView = [[BFAttributedView alloc]initWithFrame:initRect];
        [self addSubview:summaryView];
        [summaryView release];
        
        contentImgView = [[BFImageView alloc]initWithFrame:initRect];
        [self addSubview:contentImgView];
        [contentImgView release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setContentDict:(ZYBaseModel *)contentModel withConfigStyle:(ZYLayoutItemStyle)aStyle
{
    if ([contentModel isKindOfClass:[ZYNewsModel class]]) {
        ZYNewsModel *destModel = (ZYNewsModel*)contentModel;
        switch (aStyle) {
            case ZYLayoutItemBig:
            {
                contentImgView.hidden = NO;
                contentImgView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
                
            }
                break;
            case ZYLayoutItemNormal:
            {
                
            }
                break;
            default:
                break;
        }
    }
    if ([contentModel isKindOfClass:[ZYPictureModel class]]) {
        ZYPictureModel *destModel = (ZYPictureModel*)contentModel;
        switch (aStyle) {
            case ZYLayoutItemBig:
            {
                
            }
                break;
            case ZYLayoutItemNormal:
            {
                
            }
                break;
            default:
                break;
        }
    }
    if ([contentModel isKindOfClass:[ZYProductModel class]]) {
        ZYProductModel *destModel = (ZYProductModel*)contentModel;
        switch (aStyle) {
            case ZYLayoutItemBig:
            {
                
            }
                break;
            case ZYLayoutItemNormal:
            {
                
            }
                break;
            default:
                break;
        }
    }
    
    
    
}

@end
