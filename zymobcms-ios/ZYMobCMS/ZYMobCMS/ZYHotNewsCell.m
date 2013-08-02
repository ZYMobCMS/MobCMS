//
//  ZYHotNewsCell.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYHotNewsCell.h"
#import "HotImageView.h"

#define baseImageTag 9899999

@implementation ZYHotNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        [self.contentView addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        [scrollView release];
        
        UIView *grayTagView = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-10,self.frame.size.width,10)];
        grayTagView.alpha=0.5;
        grayTagView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:grayTagView];
        [grayTagView release];
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width*1/3,10)];
        [self.contentView addSubview:pageControl];
        [pageControl release];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withSelectAction:(didSelectArticle)selectAction
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        [self.contentView addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        [scrollView release];
        
        UIView *grayTagView = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-10,self.frame.size.width,10)];
        grayTagView.alpha=0.3;
        grayTagView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:grayTagView];
        [grayTagView release];
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width*1/3,10)];
        [self.contentView addSubview:pageControl];
        [pageControl release];

        _selectAction = [selectAction copy];
    }
    return self;
}

- (void)dealloc
{
    if (_selectAction) {
        [_selectAction release];
    }
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentArray:(NSArray *)contentArray
{
    for (int i=0; i<contentArray.count;i++) {
        
        NSDictionary *item = [contentArray objectAtIndex:i];
        NSString *articleId = [item objectForKey:@"article_id"];
        NSString *imageUrl = [item objectForKey:@"images"];
        imageUrl = [NSString stringWithFormat:@"%@%@",ZYCMS_image_Url,imageUrl];

        if([scrollView viewWithTag:baseImageTag+i]==nil){
            
            HotImageView *newImageView = [[HotImageView alloc]init];
            newImageView.frame = CGRectMake(scrollView.frame.size.width*i,0,scrollView.frame.size.width,scrollView.frame.size.height);
            newImageView.articleId = articleId;
            [scrollView addSubview:newImageView];
            [newImageView release];
            
            [[BFImageDownloader shareLoader]downloadImageWithUrl:imageUrl forView:newImageView];
            
            scrollView.contentSize = CGSizeMake(contentArray.count*scrollView.frame.size.width,scrollView.frame.size.height);
             
        }else{
            
            HotImageView *imageView = (HotImageView*)[scrollView viewWithTag:baseImageTag+i];
            [[BFImageDownloader shareLoader]downloadImageWithUrl:imageUrl forView:imageView];
        }
        
    }
}

@end
