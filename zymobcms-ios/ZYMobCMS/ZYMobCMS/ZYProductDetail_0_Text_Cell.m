//
//  ZYProductDetail_0_Text_Cell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYProductDetail_0_Text_Cell.h"

#define ProductDetail_0_Text_FontSize 14
#define ProductDetail_0_Left_Margin 5
#define ProductDetail_0_Top_Margin 5

@implementation ZYProductDetail_0_Text_Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        contentTextView = [[BFAttributedView alloc]initWithFrame:CGRectMake(0,0,1,1)];
        contentTextView.textDescriptor.fontSize = ProductDetail_0_Text_FontSize;
        [self.contentView addSubview:contentTextView ];
        [contentTextView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentString:(NSString *)content
{
    [contentTextView setContentText:content];
    
    CGFloat totalWidth = self.frame.size.width-20-2*ProductDetail_0_Left_Margin;
    
    CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentTextView.contentAttributedString withWdith:totalWidth];
    
    contentTextView.frame = CGRectMake(ProductDetail_0_Left_Margin,ProductDetail_0_Top_Margin,totalWidth,contentHeight);
}

+ (CGFloat)heightForContent:(NSString *)content forTable:(UITableView *)table
{
    BFAttributeDescriptor *contentDes = [[BFAttributeDescriptor alloc]init];
    contentDes.fontSize = ProductDetail_0_Text_FontSize;
    NSAttributedString *contentAtti = [BFAttributedView createAttributedString:content withDescriptor:contentDes];
    [contentDes release];
    
    CGFloat totalWidth = table.frame.size.width-20-2*ProductDetail_0_Left_Margin;
    
    CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentAtti withWdith:totalWidth];
    
    return MAX(2*ProductDetail_0_Top_Margin+contentHeight,44);
}

@end
