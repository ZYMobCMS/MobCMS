//
//  ImageItem.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-3.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ImageItem.h"
#import "BFImageDownloader.h"

@implementation ImageItem
@synthesize titleLabel,contentImageView;
@synthesize productArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.contentImageView = [[UIImageView alloc]init];
        self.contentImageView.frame = CGRectMake(5,5,frame.size.width-10,self.frame.size.height-10-30);
        [self addSubview:self.contentImageView];
        [self.contentImageView release];
        
        //
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.frame = CGRectMake(5,self.frame.size.height-30-5,self.frame.size.width-10,30);
        [self addSubview:self.titleLabel];
        [self.titleLabel release];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTapAction:(tapOnImageItem)tapAction
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.contentImageView = [[UIImageView alloc]init];
        self.contentImageView.frame = CGRectMake(5,5,frame.size.width-10,self.frame.size.height-10-30);
        [self addSubview:self.contentImageView];
        [self.contentImageView release];
        
        //
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.frame = CGRectMake(5,self.frame.size.height-30-5,self.frame.size.width-10,30);
        [self addSubview:self.titleLabel];
        [self.titleLabel release];
        
        self.productArray = [[NSMutableArray alloc]init];
        _tapAction = [tapAction copy];
    }
    return self;

}

- (void)dealloc
{
    [_tapAction release];
    self.productArray = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setItemContent:(NSDictionary *)contentDict
{

    self.titleLabel.text = [contentDict objectForKey:@"title"];
    NSString *imageUrl = [contentDict objectForKey:@"images"];
    
    [[BFImageDownloader shareLoader]downloadImageWithUrl:imageUrl forView:self.contentImageView];
    
    
    
    
}


@end
