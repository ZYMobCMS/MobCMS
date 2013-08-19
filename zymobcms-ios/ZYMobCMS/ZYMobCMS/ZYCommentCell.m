//
//  ZYCommentCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYCommentCell.h"



@implementation ZYCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect initRect = CGRectMake(0,0,1,1);
        
        backImgView = [[UIImageView alloc]initWithFrame:initRect];
        backImgView.image = [UIImage imageNamed:@"dialog_box1.png"];
        [self.contentView addSubview:backImgView];
        [backImgView release];
        
        titleView = [[BFAttributedView alloc]initWithFrame:initRect];
        titleView.textDescriptor.fontSize = TitleFontSize;
        titleView.textDescriptor.textColor = [UIColor grayColor];
        [self.contentView addSubview:titleView];
        [titleView release];
        
        dateView = [[BFAttributedView alloc]initWithFrame:initRect];
        dateView.textDescriptor.fontSize = TitleFontSize;
        dateView.textDescriptor.textColor = [UIColor grayColor];
        [self.contentView addSubview:dateView];
        [dateView release];
        
        contentView = [[BFAttributedView alloc]initWithFrame:initRect];
        contentView.textDescriptor.fontSize = ContentFontSize;
        contentView.textDescriptor.lineSpace = ContentLineSpace;
        [self.contentView addSubview:contentView];
        [contentView release];
        
        articleTitleView = [[BFAttributedView alloc]initWithFrame:initRect];
        articleTitleView.textDescriptor.fontSize = ArticleTitleFontSize;
        articleTitleView.textDescriptor.textColor = [UIColor grayColor];
        [self.contentView addSubview:articleTitleView];
        [articleTitleView release];
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
    NSString *title = [contentDict objectForKey:@"login_name"];
    NSString *articleTitle = [contentDict objectForKey:@"title"];
    NSString *content = [contentDict objectForKey:@"content"];
    NSString *date = [contentDict objectForKey:@"create_time"];
    
    
    [titleView setContentText:title];
    [dateView setContentText:date];
    [contentView setContentText:content];
    [articleTitleView setContentText:articleTitle];
    
    CGFloat originY = TopMargin;
    
    CGFloat totalWidth = self.frame.size.width-2*LeftMargin-2*LeftMargin;
    
    CGFloat titleViewHeight = [BFAttributedView getAttributedContentHeight:titleView.contentAttributedString withWdith:totalWidth];
    titleView.frame = CGRectMake(LeftMargin+LeftMargin/2,originY,totalWidth-95,titleViewHeight);
    
    CGFloat dateViewHeight = [BFAttributedView getAttributedContentHeight:dateView.contentAttributedString withWdith:self.frame.size.width];
    dateView.frame = CGRectMake(self.frame.size.width-LeftMargin-95-LeftMargin/2,originY,95,dateViewHeight);
    originY = titleView.frame.origin.y+titleView.frame.size.height + TextMargin;
    
    CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentView.contentAttributedString withWdith:totalWidth];
    contentView.frame = CGRectMake(LeftMargin+LeftMargin/2,originY,totalWidth,contentHeight);
    originY = contentView.frame.origin.y+contentView.frame.size.height+TextMargin;
    
    backImgView.frame = CGRectMake(LeftMargin,TopMargin/2,self.frame.size.width-2*LeftMargin,originY);
    originY = originY + TopMargin/2;
    
    CGFloat articleTitleHeight = [BFAttributedView getAttributedContentHeight:articleTitleView.contentAttributedString withWdith:totalWidth];
    articleTitleView.frame = CGRectMake(LeftMargin,originY,totalWidth,articleTitleHeight);
    originY = articleTitleView.frame.origin.y+articleTitleView.frame.size.height+TopMargin;

}

+ (CGFloat)heightWithContent:(NSDictionary *)contentDict forTable:(UITableView *)table
{
    NSString *title = [contentDict objectForKey:@"login_name"];
    NSString *articleTitle = [contentDict objectForKey:@"title"];
    NSString *content = [contentDict objectForKey:@"content"];
//    NSString *date = [contentDict objectForKey:@"publish_time"];
    
    
    BFAttributeDescriptor *titleDes = [[BFAttributeDescriptor alloc]init];
    titleDes.fontSize = TitleFontSize;
    NSAttributedString *titleAtti = [BFAttributedView createAttributedString:title withDescriptor:titleDes];
    [titleDes release];

    BFAttributeDescriptor *contentDes = [[BFAttributeDescriptor alloc]init];
    contentDes.fontSize = ContentFontSize;
    contentDes.lineSpace = ContentLineSpace;
    NSAttributedString *contentAtti = [BFAttributedView createAttributedString:content withDescriptor:contentDes];
    [contentDes release];

    BFAttributeDescriptor *articleTitleDes = [[BFAttributeDescriptor alloc]init];
    articleTitleDes.fontSize = ArticleTitleFontSize;
    NSAttributedString *articleTitleAtti = [BFAttributedView createAttributedString:articleTitle withDescriptor:articleTitleDes];
    [articleTitleDes release];
    
    CGFloat originY = TopMargin;
    
    CGFloat totalWidth = table.frame.size.width-2*LeftMargin-LeftMargin;
    
    CGFloat titleViewHeight = [BFAttributedView getAttributedContentHeight:titleAtti withWdith:totalWidth];
    CGRect titleRect = CGRectMake(LeftMargin+LeftMargin/2,originY,totalWidth-95,titleViewHeight);

    originY = titleRect.origin.y+titleRect.size.height + TextMargin;
    
    CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentAtti withWdith:totalWidth];
    CGRect contentRect = CGRectMake(LeftMargin+LeftMargin/2,originY,totalWidth,contentHeight);
    originY = contentRect.origin.y+contentRect.size.height+TextMargin;
    
    originY = originY + TopMargin/2;

    CGFloat articleTitleHeight = [BFAttributedView getAttributedContentHeight:articleTitleAtti withWdith:totalWidth];
    CGRect articleTitleRect = CGRectMake(LeftMargin,originY,totalWidth,articleTitleHeight);
    originY = articleTitleRect.origin.y+articleTitleRect.size.height+TopMargin;
    
    return originY;
}

@end
