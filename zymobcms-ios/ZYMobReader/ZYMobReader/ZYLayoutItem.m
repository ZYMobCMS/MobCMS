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
        titleFontSize = 13.0f;
        summaryFontSize = 11.0f;
        dateFontSize = 10.f;
        
        titleView = [[BFAttributedView alloc]initWithFrame:initRect];
        titleView.textDescriptor.fontSize = titleFontSize;
        [self addSubview:titleView];
        [titleView release];
        
        dateSourceView = [[BFAttributedView alloc]initWithFrame:initRect];
        dateSourceView.textDescriptor.fontSize = dateFontSize;
        [self addSubview:dateSourceView];
        [dateSourceView release];
        
        summaryView = [[BFAttributedView alloc]initWithFrame:initRect];
        [self addSubview:summaryView];
        [summaryView release];
        
        contentImgView = [[BFImageView alloc]initWithFrame:initRect];
        [self addSubview:contentImgView];
        [contentImgView release];
        
        leftMargin = 5.0f;
        textMargin =  5.0f;
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

- (void)setContentDict:(ZYNewsModel *)contentModel withConfigStyle:(ZYLayoutItemStyle)aStyle
{
    ZYNewsModel *destModel = (ZYNewsModel*)contentModel;
    NSString *firstImage = [[destModel.images componentsSeparatedByString:@"|"]objectAtIndex:0];
    if (firstImage==nil) {
        [self buildContentWithTitle:destModel.title withImage:firstImage withDate:destModel.publishTime withSource:destModel.source withSummary:destModel.summary withStyle:ZYLayoutItemNormal];
    }else{
       [self buildContentWithTitle:destModel.title withImage:firstImage withDate:destModel.publishTime withSource:destModel.source withSummary:destModel.summary withStyle:aStyle]; 
    }
    

}
- (void)buildContentWithTitle:(NSString*)title withImage:(NSString*)imageUrl withDate:(NSString*)date withSource:(NSString*)source withSummary:(NSString*)summary withStyle:(ZYLayoutItemStyle)aStyle
{
    NSString *intervalString = [BFUitils intervalSinceNow:date];
    NSRange dayRang = [intervalString rangeOfString:@"天"];
    NSMutableString *dateSourceCombine = [NSMutableString string];
    if (dayRang.location != NSNotFound) {
        [dateSourceCombine appendFormat:@"%@  %@",source,intervalString];
    }else{
        [dateSourceCombine appendFormat:@"%@",source];
    }
    [titleView setContentText:title];
    [dateSourceView setContentText:dateSourceCombine];

    switch (aStyle) {
        case ZYLayoutItemBig:
        {
            summaryView.hidden = YES;
            dateSourceView.hidden = YES;
            
            contentImgView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
            
            CGFloat titleHeight = [BFAttributedView getAttributedContentHeight:titleView.contentAttributedString withWdith:self.frame.size.width-2*leftMargin];
            titleView.frame = CGRectMake(leftMargin,self.frame.size.height-leftMargin-titleHeight,self.frame.size.width-2*leftMargin,titleHeight);
            
            
        }
            break;
        case ZYLayoutItemNormal:
        {
            summaryView.hidden = YES;
            dateSourceView.hidden = NO;
            
            CGFloat contentWidth = self.frame.size.width-2*leftMargin;
            CGFloat titleHeight = [BFAttributedView getAttributedContentHeight:titleView.contentAttributedString withWdith:contentWidth];
            titleView.frame = CGRectMake(leftMargin,0,self.frame.size.width-2*leftMargin,titleHeight);
            
            CGFloat dateHeight = [BFAttributedView getAttributedContentHeight:dateSourceView.contentAttributedString withWdith:contentWidth];
            dateSourceView.frame = CGRectMake(leftMargin,titleHeight+textMargin,contentWidth,dateHeight);
            
        }
            break;
        case ZYLayoutItemAllText:
        {
            summaryView.hidden = NO;
            dateSourceView.hidden = NO;
            [summaryView setContentText:summary];
            
            CGFloat contentWidth = self.frame.size.width-2*leftMargin;
            CGFloat titleHeight = [BFAttributedView getAttributedContentHeight:titleView.contentAttributedString withWdith:contentWidth];
            titleView.frame = CGRectMake(leftMargin,0,self.frame.size.width-2*leftMargin,titleHeight);
            
            CGFloat dateHeight = [BFAttributedView getAttributedContentHeight:dateSourceView.contentAttributedString withWdith:contentWidth];
            dateSourceView.frame = CGRectMake(leftMargin,titleHeight+textMargin,contentWidth,dateHeight);
            
            CGFloat summaryHeight = [BFAttributedView getAttributedContentHeight:summaryView.contentAttributedString withWdith:contentWidth];
            summaryView.frame = CGRectMake(leftMargin,titleHeight+textMargin+dateHeight+textMargin,contentWidth,summaryHeight);
            
        }
            break;
        default:
        {
            
        }
            break;
    }
    
}

@end
