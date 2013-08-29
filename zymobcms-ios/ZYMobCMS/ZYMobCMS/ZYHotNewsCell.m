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
#define CellHeight 170

@implementation ZYHotNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        bScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        [self.contentView addSubview:bScrollView];
        bScrollView.pagingEnabled = YES;
        [bScrollView release];
        
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
        
        bScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,CellHeight)];
        [self.contentView addSubview:bScrollView];
        bScrollView.backgroundColor = [UIColor clearColor];
        bScrollView.delegate = self;
        bScrollView.pagingEnabled = YES;
        [bScrollView release];
        
        UIView *grayTagView = [[UIView alloc]initWithFrame:CGRectMake(0,CellHeight-25,self.frame.size.width,25)];
        grayTagView.alpha=0.5;
        grayTagView.backgroundColor = [UIColor blackColor];
        grayTagView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:grayTagView];
        [grayTagView release];
        
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width*3/4,CellHeight-20,self.frame.size.width*1/4,15)];
        [self.contentView addSubview:pageControl];
        [pageControl release];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(6,CellHeight-25,self.frame.size.width*3/4-6,25)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:titleLabel];
        [titleLabel release];

        _selectAction = [selectAction copy];
        
        mContentArray = [[NSMutableArray alloc]init];
        
        //
        UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnItemAction)];
        [self addGestureRecognizer:tapR];
        [tapR release];
    }
    return self;
}

- (void)dealloc
{
    if (_selectAction) {
        [_selectAction release];
    }
    [mContentArray release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentArray:(NSArray *)contentArray
{
    [mContentArray removeAllObjects];
    [mContentArray addObjectsFromArray:contentArray];
    for (int i=0; i<contentArray.count;i++) {
        
        NSDictionary *item = [contentArray objectAtIndex:i];
        NSString *articleId = [item objectForKey:@"article_id"];
        
        if([bScrollView viewWithTag:baseImageTag+i]==nil){
            
            HotImageView *newImageView = [[HotImageView alloc]init];
            newImageView.frame = CGRectMake(bScrollView.frame.size.width*i,0,bScrollView.frame.size.width,bScrollView.frame.size.height);
            newImageView.articleId = articleId;
            [bScrollView addSubview:newImageView];
            [newImageView release];
                        
            bScrollView.contentSize = CGSizeMake(contentArray.count*bScrollView.frame.size.width,bScrollView.frame.size.height);
            
        }
        
    }
    titleLabel.text = [[contentArray objectAtIndex:0]objectForKey:@"title"];
    pageControl.numberOfPages = mContentArray.count;
}

- (void)setImageInfo:(NSArray *)contentArray
{
    [mContentArray removeAllObjects];
    [mContentArray addObjectsFromArray:contentArray];
    for (int i=0; i<contentArray.count;i++) {
        
        NSDictionary *item = [contentArray objectAtIndex:i];
        NSString *imageUrl = [item objectForKey:@"images"];
        
        if([bScrollView viewWithTag:baseImageTag+i]==nil){
            
            HotImageView *newImageView = [[HotImageView alloc]init];
            newImageView.frame = CGRectMake(bScrollView.frame.size.width*i,0,bScrollView.frame.size.width,bScrollView.frame.size.height);
            [bScrollView addSubview:newImageView];
            [newImageView release];
            
            [[BFImageDownloader shareLoader]downloadImageWithUrl:imageUrl forView:newImageView];
            
            bScrollView.contentSize = CGSizeMake(contentArray.count*bScrollView.frame.size.width,bScrollView.frame.size.height);
            
        }else{
            
            HotImageView *imageView = (HotImageView*)[bScrollView viewWithTag:baseImageTag+i];
            if ([BFImageCache imageForUrl:imageUrl]) {
                imageView.image = [BFImageCache imageForUrl:imageUrl];
            }else{
                imageView.image = [UIImage imageNamed:@"img_faild.png"];
            }
            [[BFImageDownloader shareLoader]downloadImageWithUrl:imageUrl forView:imageView];
        }
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算翻页
    int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) /  scrollView.frame.size.width) + 1;
    pageControl.currentPage = currentPage;
    NSDictionary *item = [mContentArray objectAtIndex:currentPage];
    titleLabel.text = [item objectForKey:@"title"];
}

- (void)tapOnItemAction
{
    if (_selectAction) {
        NSDictionary *item = [mContentArray objectAtIndex:pageControl.currentPage];
        _selectAction(item);
    }
}

@end
