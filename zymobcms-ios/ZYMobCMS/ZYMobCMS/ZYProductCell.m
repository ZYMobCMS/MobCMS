//
//  ZYProductCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYProductCell.h"

#define CellHeight 155
#define CellMargin 5

@implementation ZYProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *bView = [[UIView alloc]init];
        bView.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = bView;
        [bView release];
        
        backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width,CellHeight)];
        backImageView.image = [UIImage imageNamed:@"product_cell_bg.png"];
        backImageView.highlightedImage = [UIImage imageNamed:@"product_cell_bg_s.png"];
        [self.contentView addSubview:backImageView];
        [backImageView release];
        
        titleView = [[BFAttributedView alloc]initWithFrame:CGRectMake(155, 13, 145, 41)];
        titleView.textDescriptor.fontSize = 18;
        titleView.textDescriptor.textFont = @"";
        [self.contentView addSubview:titleView];
        [titleView release];
        
        summaryView = [[BFAttributedView alloc]initWithFrame:CGRectMake(155, 62, 145, 36)];
        summaryView.textDescriptor.fontSize = 14;
        [self.contentView addSubview:summaryView];
        [summaryView release];
        
        priceView = [[BFAttributedView alloc]initWithFrame:CGRectMake(155, 125, 20, 21)];
        priceView.textDescriptor.fontSize = 17;
        [self.contentView addSubview:priceView];
        [priceView release];
        
        conentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25,20, 120, 120)];
        [self.contentView addSubview:conentImageView];
        [conentImageView release];
        
        favTagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(220,123,25, 25)];
        favTagImageView.image = [UIImage imageNamed:@"favorite_on.png"];
        [self.contentView addSubview:favTagImageView];
        [favTagImageView release];
        
        favCountView = [[BFAttributedView alloc]initWithFrame:CGRectMake(247, 125, 53, 21)];
        favCountView.textDescriptor.fontSize = 10;
        [self.contentView addSubview:favCountView];
        [favCountView release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

//    if (selected) {
//        backImageView.highlightedImage = [UIImage imageNamed:@"product_cell_bg_s.png"];
//        
//    }else{
//        backImageView.image = [UIImage imageNamed:@"product_cell_bg.png"];
//        
//    }
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
//    if (highlighted) {
//        backImageView.highlightedImage = [UIImage imageNamed:@"product_cell_bg_s.png"];
//
//    }else{
//        backImageView.image = [UIImage imageNamed:@"product_cell_bg.png"];
//
//    }
}

- (void)setProductInfo:(NSDictionary *)productDict
{
    NSString *title = [productDict objectForKey:@"title"];
    NSString *summary = [productDict objectForKey:@"summary"];
    NSString *price = [productDict objectForKey:@"price"];
    NSString *favcount = [productDict objectForKey:@"support_count"];
    NSString *imageUrl = [productDict objectForKey:@"images"];
    
    [titleView setContentText:title];
    [summaryView setContentText:summary];
    [priceView setContentText:price];
    [favCountView setContentText:favcount];
    conentImageView.image = [UIImage imageNamed:@"no_photo.png"];
    [[BFImageDownloader shareLoader]downloadImageWithUrl:imageUrl forView:conentImageView];
    
}

+ (CGFloat)heightForProductCell
{
    return CellHeight+CellMargin;
}


@end
