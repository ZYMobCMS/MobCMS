//
//  ArticleCommentCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ArticleCommentCell.h"

#define LeftMargin 10
#define TopMargin 10
#define TextMargin 10
#define LocationFontSize 10
#define ContentFontSize  13
#define ContentLineSpace 5
#define DateFontSize     10

@implementation ArticleCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        CGRect initRect = CGRectMake(0,0,1,1);
        
        commentContentView = [[BFAttributedView alloc]initWithFrame:initRect];
        [self.contentView addSubview:commentContentView];
        commentContentView.textDescriptor.fontSize = ContentFontSize;
        commentContentView.textDescriptor.lineSpace = ContentLineSpace;
        [commentContentView release];
        
        locationView = [[BFAttributedView alloc]initWithFrame:initRect];
        [self.contentView addSubview:locationView];
        locationView.textDescriptor.fontSize = LocationFontSize;
        [locationView release];
        
        dateView = [[UILabel alloc]initWithFrame:initRect];
        dateView.font = [UIFont systemFontOfSize:DateFontSize];
        [self.contentView addSubview:dateView];
        [dateView release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setcontentDict:(NSDictionary *)contentDict
{
    NSString *creater = [contentDict objectForKey:@"login_name"];
    NSString *content = [contentDict objectForKey:@"content"];
    NSString *location = [contentDict objectForKey:@"location"];
    NSString *date = [contentDict objectForKey:@"create_time"];
    
    NSString *locationUserCombine = [NSString stringWithFormat:@"%@  %@",location,creater];
    
    [commentContentView setContentText:content];
    [locationView setContentText:locationUserCombine];
    [dateView setText:date];
    
    CGFloat totalWidth = self.frame.size.width-2*LeftMargin;
    CGFloat originY = TopMargin;
    
    CGFloat locationHeight = [BFAttributedView getAttributedContentHeight:locationView.contentAttributedString withWdith:totalWidth];
    locationView.frame = CGRectMake(LeftMargin,originY,totalWidth,locationHeight);
    originY = locationView.frame.origin.y+locationView.frame.size.height+TextMargin;
    
    CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:commentContentView.contentAttributedString withWdith:totalWidth];
    commentContentView.frame = CGRectMake(LeftMargin,originY,totalWidth,contentHeight);
    originY = commentContentView.frame.origin.y+commentContentView.frame.size.height+TextMargin;
    
    CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(totalWidth,99999)];
    dateView.frame = CGRectMake(self.frame.size.width-LeftMargin-dateSize.width,originY,dateSize.width,dateSize.height);
    originY = dateView.frame.origin.y+dateView.frame.size.height+TopMargin;
    
}

+ (CGFloat)heightForContentDict:(NSDictionary *)contentDict forTable:(UITableView *)table
{
    NSString *creater = [contentDict objectForKey:@"login_name"];
    NSString *content = [contentDict objectForKey:@"content"];
    NSString *location = [contentDict objectForKey:@"location"];
    NSString *date = [contentDict objectForKey:@"create_time"];
    
    NSString *locationUserCombine = [NSString stringWithFormat:@"%@  %@",location,creater];
    
    BFAttributeDescriptor *locationDesp = [[BFAttributeDescriptor alloc]init];
    locationDesp.fontSize = LocationFontSize;
    NSAttributedString *locationAtti = [BFAttributedView createAttributedString:locationUserCombine withDescriptor:locationDesp];
    [locationDesp release];
    
    BFAttributeDescriptor *contentDesp = [[BFAttributeDescriptor alloc]init];
    contentDesp.fontSize = ContentFontSize;
    contentDesp.lineSpace = ContentLineSpace;
    NSAttributedString *contentAtti = [BFAttributedView createAttributedString:content withDescriptor:contentDesp];
    [contentDesp release];
    
    CGFloat totalWidth = table.frame.size.width-2*LeftMargin;
    CGFloat originY = TopMargin;
    
    CGFloat locationHeight = [BFAttributedView getAttributedContentHeight:locationAtti withWdith:totalWidth];
    CGRect locationRect = CGRectMake(LeftMargin,originY,totalWidth,locationHeight);
    originY = locationRect.origin.y+locationRect.size.height+TextMargin;
    
    CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentAtti withWdith:totalWidth];
    CGRect commentContentRect = CGRectMake(LeftMargin,originY,totalWidth,contentHeight);
    originY = commentContentRect.origin.y+commentContentRect.size.height+TextMargin;
    
    CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(totalWidth,99999)];
    CGRect dateRect = CGRectMake(LeftMargin,originY,totalWidth,dateSize.height);
    originY = dateRect.origin.y+dateRect.size.height+TopMargin;
    
    return originY;
}

@end
