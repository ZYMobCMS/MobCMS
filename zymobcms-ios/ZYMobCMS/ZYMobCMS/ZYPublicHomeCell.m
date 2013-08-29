//
//  ZYPublicHomeCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-24.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPublicHomeCell.h"

#define TopMargin 10
#define LeftMargin 10
#define TextMargin 10
#define TextImageMargin 10
#define ContentFontSize 14
#define DateFontSize 11
#define ContentLineSpace 6
#define DateWidth 50

#define MaxImageWidth 100
#define MaxImageHeight 60

@implementation ZYPublicHomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect initRect = CGRectMake(0,0,1,1);
        
        contentTextView = [[BFAttributedView alloc]initWithFrame:initRect];
        contentTextView.textDescriptor.fontSize = ContentFontSize;
        contentTextView.textDescriptor.lineSpace = ContentLineSpace;
        [self.contentView addSubview:contentTextView];
        [contentTextView release];
        
        dateView = [[UILabel alloc]initWithFrame:initRect];
        dateView.font = [UIFont systemFontOfSize:DateFontSize];
        dateView.textColor = [UIColor grayColor];
        dateView.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:dateView];
        [dateView release];
        
        relationImageView = [[UIImageView alloc]initWithFrame:initRect];
        [self.contentView addSubview:relationImageView];
        [relationImageView release];
        
        activeTypeImageView = [[UIImageView alloc]initWithFrame:initRect];
        [self.contentView addSubview:activeTypeImageView];
        [activeTypeImageView release];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [selectView setBackgroundColor:[UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1]];
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

- (void)setContentDict:(NSDictionary *)contentDict
{
    NSString *content = [contentDict objectForKey:@"content"];
    NSString *date = [contentDict objectForKey:@"create_time"];
    date = [NSString stringWithFormat:@"%@",[BFUitils intervalSinceNow:date]];
    NSString *images = [contentDict objectForKey:@"relation_images"];    
    NSString *relationTitle = [contentDict objectForKey:@"relation_title"];
    
    BOOL hasImage = YES;
    if ([images isEqualToString:@""]||images==nil) {
        hasImage = NO;
    }
    
    //contentWidth
    CGFloat totalContentWidth = self.frame.size.width-2*LeftMargin;
    
    
    
    if (hasImage) {
        
        UIImage *cacheContentImage = [BFImageCache imageForUrl:images];
        
        CGFloat textContentWidth = 0.f;
        CGFloat imageWidth = 0.f;
        CGFloat imageHeight = 0.f;
        if (cacheContentImage) {
            
            CGFloat cacheWidth = cacheContentImage.size.width;
            imageWidth = MIN(cacheWidth,MaxImageWidth);
            imageHeight = MIN(cacheContentImage.size.height,MaxImageHeight);
            textContentWidth =  totalContentWidth - TextImageMargin - imageWidth;

        }else{
            
            textContentWidth =  totalContentWidth - TextImageMargin - MaxImageWidth;
            imageWidth = MaxImageWidth;
            imageHeight = MaxImageHeight;
        }
        
        CGFloat originY = TopMargin;
        
        //text
        contentTextView.textDescriptor.keywords = [NSArray arrayWithObjects:[NSArray arrayWithObjects:relationTitle,[UIColor blueColor],nil], nil];        contentTextView.textDescriptor.isKeywordDistrict = YES;
        [contentTextView setContentText:content];

        CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentTextView.contentAttributedString withWdith:textContentWidth];
        
        contentTextView.frame = CGRectMake(LeftMargin,originY,textContentWidth,contentHeight);
        
        relationImageView.frame = CGRectMake(LeftMargin+contentTextView.frame.size.width+TextImageMargin,originY,imageWidth,imageHeight);
        [[BFImageDownloader shareLoader]downloadImageWithUrl:images forView:relationImageView];
        relationImageView.hidden = NO;
        originY = contentTextView.frame.origin.y+contentTextView.frame.size.height+TextMargin;

        originY = MAX(MaxImageHeight+TopMargin+TextMargin,originY);
        dateView.text = date;
        CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(totalContentWidth,99999)];
        dateView.frame = CGRectMake(totalContentWidth-dateSize.width+LeftMargin,originY,dateSize.width,dateSize.height);
        
        
        
    }else{
        
        CGFloat textContentWidth = totalContentWidth;

        CGFloat originY = TopMargin;
        
        //text
        contentTextView.textDescriptor.keywords = [NSArray arrayWithObjects:[NSArray arrayWithObjects:relationTitle,[UIColor blueColor],nil], nil];
        contentTextView.textDescriptor.isKeywordDistrict = YES;
        [contentTextView setContentText:content];

        CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentTextView.contentAttributedString withWdith:textContentWidth];
        
        contentTextView.frame = CGRectMake(LeftMargin,originY,textContentWidth,contentHeight);
        
        relationImageView.hidden = YES;
        originY = contentTextView.frame.origin.y+contentTextView.frame.size.height+TextMargin;
        
        dateView.text = date;
        CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(totalContentWidth,99999)];
        dateView.frame = CGRectMake(totalContentWidth-dateSize.width+LeftMargin,originY,dateSize.width,dateSize.height);
        
    }
}

+ (CGFloat)heightForContentDict:(NSDictionary *)contentDict forTable:(UITableView *)table
{
    NSString *content = [contentDict objectForKey:@"content"];
    NSString *date = [contentDict objectForKey:@"create_time"];
    NSString *images = [contentDict objectForKey:@"relation_images"];
    
    BOOL hasImage = YES;
    if ([images isEqualToString:@""]||images==nil) {
        hasImage = NO;
    }
    
    //contentWidth
    CGFloat totalContentWidth = table.frame.size.width-2*LeftMargin;
    
    BFAttributeDescriptor *contentDes = [[BFAttributeDescriptor alloc]init];
    contentDes.fontSize = ContentFontSize;
    contentDes.lineSpace = ContentLineSpace;
    NSAttributedString *contentAtti = [BFAttributedView createAttributedString:content withDescriptor:contentDes];
    [contentDes release];
        
    CGFloat originY = TopMargin;
    if (hasImage) {
        
        UIImage *cacheContentImage = [BFImageCache imageForUrl:images];
        
        CGFloat textContentWidth = 0.f;
        CGFloat imageWidth = 0.f;
        CGFloat imageHeight = 0.f;
        if (cacheContentImage) {
            
            CGFloat cacheWidth = cacheContentImage.size.width;
            imageWidth = MIN(cacheWidth,MaxImageWidth);
            imageHeight = MIN(cacheContentImage.size.height,MaxImageHeight);
            textContentWidth =  totalContentWidth - TextImageMargin - imageWidth;
            
        }else{
            
            textContentWidth =  totalContentWidth - TextImageMargin - MaxImageWidth;
            imageWidth = MaxImageWidth;
            imageHeight = MaxImageHeight;
        }
        
        
        
        //text
        CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentAtti withWdith:textContentWidth];
        
        CGRect contentRect = CGRectMake(LeftMargin,originY,textContentWidth,contentHeight);
        
        originY = contentRect.origin.y+contentRect.size.height+TextMargin;
        originY = MAX(MaxImageHeight+TopMargin+TextMargin,originY);

        CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(totalContentWidth,99999)];
        CGRect dateRect = CGRectMake(totalContentWidth-dateSize.width+LeftMargin,originY,dateSize.width,dateSize.height);
        
        originY = dateRect.origin.y+dateRect.size.height+TopMargin;
        
    }else{
        
        CGFloat textContentWidth = totalContentWidth;
                
        //text
        CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentAtti withWdith:textContentWidth];
        
        CGRect contentRect = CGRectMake(LeftMargin,originY,textContentWidth,contentHeight);
        
        originY = contentRect.origin.y+contentRect.size.height+TextMargin;
        
        CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(totalContentWidth,99999)];
        CGRect dateRect = CGRectMake(totalContentWidth-dateSize.width+LeftMargin,originY,dateSize.width,dateSize.height);
        
        originY = dateRect.origin.y+dateRect.size.height+TopMargin;
        
    }
    
    return MAX(originY,MaxImageHeight+2*TopMargin+TextMargin);
}


@end
