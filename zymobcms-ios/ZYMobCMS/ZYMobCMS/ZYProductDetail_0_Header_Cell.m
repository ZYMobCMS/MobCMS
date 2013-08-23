//
//  ZYProductDetail_0_Header_Cell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYProductDetail_0_Header_Cell.h"

@implementation ZYProductDetail_0_Header_Cell
@synthesize contentImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        contentImageView = [[BFImageView alloc]init];
        contentImageView.frame = CGRectMake(5,5,self.frame.size.width-20-10,ZYProductDetail_0_Header_CellHeight-10);
        contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:contentImageView];
        [contentImageView release];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProductImageUrl:(NSString *)url
{
    [contentImageView setImageUrl:url];
}


@end
