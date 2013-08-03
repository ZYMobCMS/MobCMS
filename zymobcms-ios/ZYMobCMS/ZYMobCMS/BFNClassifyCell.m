//
//  BFNClassifyCell.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-27.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNClassifyCell.h"

#define MaxImageHeight 52
#define MaxImageWidth  74
#define Left_Right_Margin 10
#define Top_Bottom_Margin 10
#define Text_Image_Margin 5
#define Text_Margin 15
#define TitleSize 17
#define SummarySize 13
#define DateSourceSize 11
#define DateSourceMaxWidth 295

@implementation BFNClassifyCell
@synthesize imageView,titleView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //
        titleView = [[BFAttributedView alloc]initWithFrame:CGRectMake(0,0,1, 1)];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textDescriptor.lineSpace = 6.0f;
        titleView.textDescriptor.fontSize = TitleSize;
        [self.contentView addSubview:titleView];
        [titleView release];
        
        //
        contentImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:contentImgView];
        [contentImgView release];
        
        summaryView = [[BFAttributedView alloc]initWithFrame:CGRectMake(0,0,1,1)];
        summaryView.backgroundColor = [UIColor clearColor];
        summaryView.textDescriptor.lineSpace = 5.0f;
        summaryView.textDescriptor.fontSize = SummarySize;
        [self.contentView addSubview:summaryView];
        [summaryView release];
        
        //
        sourceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        sourceLabel.backgroundColor = [UIColor clearColor];
        sourceLabel.textColor = [BFUitils rgbColor:158 green:158 blue:158];
        sourceLabel.font = [UIFont systemFontOfSize:DateSourceSize];
        [self.contentView addSubview:sourceLabel];
        [sourceLabel release];
        
        //
        dataLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        dataLabel.backgroundColor = [UIColor clearColor];
        dataLabel.textColor = [BFUitils rgbColor:158 green:158 blue:158];
        dataLabel.font = [UIFont systemFontOfSize:DateSourceSize];
        [self.contentView addSubview:dataLabel];
        [dataLabel release];
        
        UIImageView *cellNormalBack = [[UIImageView alloc]init];
        cellNormalBack.backgroundColor = [BFUitils rgbColor:247 green:247 blue:247];
        self.selectedBackgroundView = cellNormalBack;
        [cellNormalBack release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSDictionary *)contentDict
{
//    NSLog(@"contentDict -->%@",contentDict);
    NSString *title = [contentDict objectForKey:@"title"];
    NSString *source = [contentDict objectForKey:@"source"];
    NSString *date = [contentDict objectForKey:@"publish_time"];
    NSString *image = [contentDict objectForKey:@"images"];
    image = [NSString stringWithFormat:@"%@%@",ZYCMS_image_Url,image];
    NSString *summary = [contentDict objectForKey:@"summary"];
    
    

    BOOL hasImage = YES;
    if (image == nil || [image isEqualToString:@""]) {
        hasImage = NO;
    }
    
//    if (hasImage) {
    
        CGFloat originY = Top_Bottom_Margin;
        
        CGFloat titleSize = [BFAttributedView getAttributedContentHeightWithString:title withWdith:self.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin withDescriptor:titleView.textDescriptor];
        
        
        CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateSourceSize] constrainedToSize:CGSizeMake(300,99999) lineBreakMode:UILineBreakModeCharacterWrap];
        
        CGSize sourceSize;
//        if (titleSize+Text_Margin+dateSize.height > MaxImageHeight+Text_Margin) {
//            sourceSize = [source sizeWithFont:[UIFont systemFontOfSize:DateSourceSize] constrainedToSize:CGSizeMake(300-dateSize.width-Text_Margin,99999) lineBreakMode:UILineBreakModeCharacterWrap];
//        }else{
            sourceSize = [source sizeWithFont:[UIFont systemFontOfSize:DateSourceSize] constrainedToSize:CGSizeMake(300-dateSize.width-Text_Margin-Text_Image_Margin-MaxImageWidth,99999) lineBreakMode:UILineBreakModeCharacterWrap];
//        }
        
        //
        titleView.frame = CGRectMake(Left_Right_Margin+MaxImageWidth+Text_Image_Margin,originY,self.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin,titleSize);
        [titleView setContentText:title];
        originY = titleView.frame.origin.y+ titleView.frame.size.height+Text_Margin;
        
        CGFloat summarySize = [BFAttributedView getAttributedContentHeightWithString:summary withWdith:self.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin withDescriptor:summaryView.textDescriptor];
        
        summaryView.frame = CGRectMake(Left_Right_Margin+MaxImageWidth+Text_Image_Margin,originY,self.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin,summarySize);
        [summaryView setContentText:summary];
        originY = summaryView.frame.origin.y+ summaryView.frame.size.height+Text_Margin;
        
        //
        sourceLabel.frame = CGRectMake(Left_Right_Margin+MaxImageWidth,originY,sourceSize.width,sourceSize.height);
        sourceLabel.text = source;
        
        //
        dataLabel.frame = CGRectMake(sourceLabel.frame.origin.x+sourceLabel.frame.size.width+Text_Margin,originY,dateSize.width,sourceSize.height);
        dataLabel.text = date;
        
        //
        contentImgView.frame = CGRectMake(Left_Right_Margin,Top_Bottom_Margin,MaxImageWidth, MaxImageHeight);
        [[BFImageDownloader shareLoader]downloadImageWithUrl:image forView:contentImgView];
        contentImgView.hidden = NO;
        
//    }else{
//        CGFloat originY = Top_Bottom_Margin;
//        
//        CGFloat titleSize = [BFAttributedView getAttributedContentHeightWithString:title withWdith:self.frame.size.width-2*Left_Right_Margin withDescriptor:titleView.textDescriptor];
//        
//        
//        CGSize dateSize  = [date sizeWithFont:[UIFont systemFontOfSize:DateSourceSize] constrainedToSize:CGSizeMake(300-Text_Margin,99999) lineBreakMode:UILineBreakModeCharacterWrap];
//        
//        CGSize sourceSize = [source sizeWithFont:[UIFont systemFontOfSize:DateSourceSize] constrainedToSize:CGSizeMake(300-dateSize.width-Text_Margin,99999) lineBreakMode:UILineBreakModeCharacterWrap];
//        
//        //
//        titleView.frame = CGRectMake(Left_Right_Margin,originY,self.frame.size.width-2*Left_Right_Margin,titleSize);
//        [titleView setContentText:title];
//        originY = titleView.frame.origin.y+titleView.frame.size.height+Text_Margin;
//        
//        //
//        sourceLabel.frame = CGRectMake(Left_Right_Margin,originY,sourceSize.width,sourceSize.height);
//        sourceLabel.text = source;
//        
//        //
//        dataLabel.frame = CGRectMake(sourceLabel.frame.origin.x+sourceLabel.frame.size.width+Text_Margin,originY,dateSize.width,sourceSize.height);
//        dataLabel.text = date;
//
//        contentImgView.hidden = YES;
//        
//        
//    }
    
}

+ (CGFloat)heightWithContent:(NSDictionary *)contentDict forTableView:(UITableView *)table
{
    NSString *title = [contentDict objectForKey:@"title"];
    NSString *source =  [contentDict objectForKey:@"source"];
    NSString *image = [contentDict objectForKey:@"images"];
    NSString *summary = [contentDict objectForKey:@"summary"];
    BFAttributeDescriptor *textDesriptor = [[BFAttributeDescriptor alloc]init];
    textDesriptor.fontSize = TitleSize;
    BFAttributeDescriptor *summaryDescriptro = [[BFAttributeDescriptor alloc]init];
    summaryDescriptro.fontSize = SummarySize;
    
    BOOL hasImage = YES;
    if (image == nil || [image isEqualToString:@""]) {
        hasImage = NO;
    }
    
//    if (hasImage) {
    
        CGFloat originY = Top_Bottom_Margin;
        
        //desciptor
        CGFloat titleSize = [BFAttributedView getAttributedContentHeightWithString:title withWdith:table.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin withDescriptor:textDesriptor];
        
        CGSize sourceSize = [source sizeWithFont:[UIFont systemFontOfSize:DateSourceSize] constrainedToSize:CGSizeMake(300,99999) lineBreakMode:UILineBreakModeCharacterWrap];

        //
        CGRect titleRect;
        titleRect = CGRectMake(Left_Right_Margin,originY,table.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin,titleSize);
        originY = titleRect.origin.y+titleRect.size.height+Text_Margin;
        
        CGFloat summarySize = [BFAttributedView getAttributedContentHeightWithString:summary withWdith:table.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin withDescriptor:summaryDescriptro];

        CGRect summaryRect;
        summaryRect = CGRectMake(Left_Right_Margin+MaxImageWidth+Text_Image_Margin,originY,table.frame.size.width-2*Left_Right_Margin-MaxImageWidth-Text_Image_Margin,summarySize);
        originY = summaryRect.origin.y+ summaryRect.size.height+Text_Margin;

        //
        CGRect sourceRect;
        sourceRect = CGRectMake(Left_Right_Margin,originY,sourceSize.width,sourceSize.height);
        
        originY = sourceRect.origin.y+sourceRect.size.height+Top_Bottom_Margin;
        
        [textDesriptor release];
        [summaryDescriptro release];
        
        return originY>MaxImageHeight+Top_Bottom_Margin*2? originY:MaxImageHeight+Top_Bottom_Margin*2;
        
//    }else{
//        CGFloat originY = Top_Bottom_Margin;
//        
//        CGFloat titleSize = [BFAttributedView getAttributedContentHeightWithString:title withWdith:table.frame.size.width-2*Left_Right_Margin withDescriptor:textDesriptor];
//        
//        CGSize sourceSize = [source sizeWithFont:[UIFont systemFontOfSize:DateSourceSize] constrainedToSize:CGSizeMake(300,99999) lineBreakMode:UILineBreakModeCharacterWrap];
//        
//        //
//        CGRect titleRect;
//        titleRect = CGRectMake(Left_Right_Margin,originY,table.frame.size.width-2*Left_Right_Margin,titleSize);
//        originY = titleRect.origin.y+titleRect.size.height+Text_Margin;
//        
//        //
//        CGRect sourceRect;
//        sourceRect = CGRectMake(Left_Right_Margin,originY,sourceSize.width,sourceSize.height);
//        originY = sourceRect.origin.y+sourceRect.size.height+Top_Bottom_Margin;
//
//        [textDesriptor release];
//        [summaryDescriptro release];
//        
//        return originY;
//        
//    }
}

@end
