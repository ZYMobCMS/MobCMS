//
//  ZYCategoryCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYCategoryCell.h"

#define TopMargin 10
#define LeftMargin 10
#define TextMargin 10
#define TextImageMargin 5
#define TitleFontSize 13
#define SourceFontSize 9
#define SummaryFontSize 12
#define TitleSpace 6
#define SourceSpace 2
#define SummarySpace 4
#define ImageMaxWidth 80
#define ImageMaxHeight 50
#define CellWidth 320

@implementation ZYCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        //
        titleView = [[BFAttributedView alloc]init];
        titleView.frame = CGRectMake(0,0,1,1);
        titleView.textDescriptor.fontSize = TitleFontSize;
        titleView.textDescriptor.lineSpace = TitleSpace;
        titleView.textDescriptor.textFont = @"HelveticaNeue-Bold";
        [self.contentView addSubview:titleView];
        [titleView release];
        
        //
        sourceView = [[BFAttributedView alloc]init];
        sourceView.frame = CGRectMake(0,0,1,1);
        sourceView.textDescriptor.fontSize = SourceFontSize;
        sourceView.textDescriptor.lineSpace = SourceSpace;
        sourceView.textDescriptor.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:sourceView];
        [sourceView release];
        
        //
        summarayView = [[BFAttributedView alloc]init];
        summarayView.frame = CGRectMake(0,0,1,1);
        summarayView.textDescriptor.fontSize = SummaryFontSize;
        summarayView.textDescriptor.lineSpace = SummarySpace;
        summarayView.textDescriptor.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:summarayView];
        [summarayView release];
        
        contentImageView = [[BFImageView alloc]init];
        contentImageView.frame = CGRectMake(0,0,1,1);
        [self.contentView addSubview:contentImageView];
        [contentImageView release];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [selectView setBackgroundColor:[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1]];
        self.selectedBackgroundView = selectView;
        [selectView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setcontentDict:(NSDictionary *)content
{
    NSString *title = [content objectForKey:@"title"];
    NSString *source = [content objectForKey:@"source"];
    NSString *date = [content objectForKey:@"publish_time"];
    NSString *summary = [content objectForKey:@"summary"];
    NSString *imageUrl = [content objectForKey:@"images"];
    imageUrl = [NSString stringWithFormat:@"%@%@",ZYCMS_image_Url,imageUrl];
    
    [titleView setContentText:title];
    NSString *dateSourceCombine = [NSString stringWithFormat:@"%@         %@",source,date];
    [sourceView setContentText:dateSourceCombine];
    
    if ([summary isEqualToString:@""]) {
        summarayView.hidden = YES;
    }else{
        [summarayView setContentText:summary];
        summarayView.hidden = NO;
    }
    
    UIImage *imageCache = [BFImageCache imageForUrl:imageUrl];
    CGSize imageSizeFromCache = imageCache.size;
    
    CGFloat trueCellWidth = 0.f;
    BOOL hasImage = YES;
    if([imageUrl isEqualToString:@""] || imageUrl == nil ){
        
        trueCellWidth = CellWidth - LeftMargin ;
        hasImage = NO;
        
    }else{
        
        
        if (imageCache) {
            CGFloat imageWidth= ImageMaxWidth>imageSizeFromCache.width? imageSizeFromCache.width:ImageMaxWidth;
            trueCellWidth = CellWidth - LeftMargin -TextImageMargin - imageWidth;
            
            if (imageSizeFromCache.width<70||imageSizeFromCache.height<70) {
                hasImage = NO;
            }else{
                hasImage = YES;
            }
        }else{
            trueCellWidth = CellWidth - LeftMargin -TextImageMargin - ImageMaxWidth;
            hasImage = YES;
        }
    }
    
    CGFloat imageWidth = 0.f;
    CGFloat imageHeight = 0.f;
    if(hasImage){
        
        if (imageCache) {
            imageWidth = ImageMaxWidth > imageSizeFromCache.width ? imageSizeFromCache.width:ImageMaxWidth;
            imageHeight = ImageMaxHeight > imageSizeFromCache.height ? imageSizeFromCache.height:ImageMaxHeight;
        }else{
            imageWidth = ImageMaxWidth;
            imageHeight = ImageMaxHeight;
        }
        
        contentImageView.frame = CGRectMake(LeftMargin,TopMargin,imageWidth,imageHeight);
        contentImageView.hidden = NO;
        [contentImageView setImageUrl:imageUrl];
    }else{
        contentImageView.hidden = YES;
    }

    CGFloat originY = TopMargin;
    
    CGFloat titleHeight = [BFAttributedView getAttributedContentHeight:titleView.contentAttributedString withWdith:trueCellWidth];
    titleView.frame = CGRectMake(LeftMargin+imageWidth+TextImageMargin,TopMargin,trueCellWidth,titleHeight);
    originY = titleView.frame.origin.y+titleView.frame.size.height+TextMargin;
    
    CGFloat sourceHeight = [BFAttributedView getAttributedContentHeight:sourceView.contentAttributedString withWdith:trueCellWidth];
    sourceView.frame = CGRectMake(LeftMargin+imageWidth+TextImageMargin,originY,trueCellWidth,sourceHeight);
    originY = sourceView.frame.origin.y+sourceHeight+TextMargin;
    
    if(!summarayView.hidden){
        
        CGFloat summaryHeight = [BFAttributedView getAttributedContentHeight:summarayView.contentAttributedString withWdith:trueCellWidth];
        summarayView.frame = CGRectMake(LeftMargin+imageWidth+TextImageMargin,originY,trueCellWidth,summaryHeight);
        originY = summarayView.frame.origin.y+summaryHeight;
    }
    
    }

+ (CGFloat)heightForContent:(NSDictionary *)content
{
    NSString *title = [content objectForKey:@"title"];
    NSString *date = [content objectForKey:@"date"];
    NSString *source = [content objectForKey:@"source"];
    NSString *summary = [content objectForKey:@"summary"];
    NSString *imageUrl = [content objectForKey:@"images"];
    
    NSString *dateSourceCombine = [NSString stringWithFormat:@"%@         %@",source,date];

    BOOL noSummary = NO;
    if ([summary isEqualToString:@""]) {
        noSummary = YES;
    }else{
        noSummary = NO;
    }
    
    UIImage *imageCache = [BFImageCache imageForUrl:imageUrl];
    CGSize imageSizeFromCache = imageCache.size;
    
    CGFloat trueCellWidth = 0.f;
    BOOL hasImage = YES;
    if([imageUrl isEqualToString:@""] || imageUrl == nil ){
        
        trueCellWidth = CellWidth - LeftMargin;
        hasImage = NO;
    }else{
        
        if (imageCache) {
            CGFloat imageWidth= ImageMaxWidth>imageSizeFromCache.width? imageSizeFromCache.width:ImageMaxWidth;
            trueCellWidth = CellWidth - LeftMargin -TextImageMargin - imageWidth;
            
            if (imageSizeFromCache.width<70||imageSizeFromCache.height<70) {
                hasImage = NO;
            }else{
                hasImage = YES;
            }
            
        }else{
            trueCellWidth = CellWidth - LeftMargin -TextImageMargin - ImageMaxWidth;
            hasImage = YES;
            
        }
    }
    
    CGFloat originY = TopMargin;
    
    BFAttributeDescriptor *titleDescriptor = [[BFAttributeDescriptor alloc]init];
    titleDescriptor.fontSize = TitleFontSize;
    titleDescriptor.lineSpace = TitleSpace;
    titleDescriptor.textFont = @"HelveticaNeue-Bold";
    NSAttributedString *titleString = [BFAttributedView createAttributedString:title withDescriptor:titleDescriptor];
    [titleDescriptor release];
    CGFloat titleHeight = [BFAttributedView getAttributedContentHeight:titleString withWdith:trueCellWidth];
    CGRect titleRect = CGRectMake(LeftMargin,TopMargin,trueCellWidth,titleHeight);
    originY = titleRect.origin.y+titleRect.size.height+TextMargin;
    
    BFAttributeDescriptor *sourceDescriptor = [[BFAttributeDescriptor alloc]init];
    sourceDescriptor.fontSize = SourceFontSize;
    sourceDescriptor.lineSpace = SourceSpace;
    NSAttributedString *sourceString = [BFAttributedView createAttributedString:dateSourceCombine withDescriptor:sourceDescriptor];
    [sourceDescriptor release];
    CGFloat sourceHeight = [BFAttributedView getAttributedContentHeight:sourceString withWdith:trueCellWidth];
    CGRect sourceRect = CGRectMake(LeftMargin,originY,trueCellWidth,sourceHeight);
    originY = sourceRect.origin.y+sourceHeight+TextMargin;
    
    if(!noSummary){
        
        BFAttributeDescriptor *summaryDescriptor = [[BFAttributeDescriptor alloc]init];
        summaryDescriptor.fontSize = SummaryFontSize;
        summaryDescriptor.lineSpace = SummarySpace;
        NSAttributedString *summaryString = [BFAttributedView createAttributedString:summary withDescriptor:summaryDescriptor];
        [summaryDescriptor release];
        CGFloat summaryHeight = [BFAttributedView getAttributedContentHeight:summaryString withWdith:trueCellWidth];
        CGRect summarayRect = CGRectMake(LeftMargin,originY,trueCellWidth,summaryHeight);
        originY = summarayRect.origin.y+summaryHeight+TextMargin;
    }
    
    
    
    if (hasImage) {
        
        CGFloat imageWidth = 0.f;
        CGFloat imageHeight = 0.f;
        if (imageCache) {
            imageWidth = ImageMaxWidth > imageSizeFromCache.width ? imageSizeFromCache.width:ImageMaxWidth;
            imageHeight = ImageMaxHeight > imageSizeFromCache.height ? imageSizeFromCache.height:ImageMaxHeight;
        }else{
            imageWidth = ImageMaxWidth;
            imageHeight = ImageMaxHeight;
        }
        
        if (originY > imageHeight + 2*TopMargin) {
            
            return originY;
        }else{
            return imageHeight + 2*TopMargin;
        }
        
    }else{
        return originY;
    }
    
}


@end
