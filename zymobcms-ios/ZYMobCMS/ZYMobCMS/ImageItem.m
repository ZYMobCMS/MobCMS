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
        self.layer.borderColor = [BFUitils rgbColor:158 green:38 blue:40].CGColor;
        self.layer.borderWidth = 1.5f;
        self.layer.cornerRadius = 3.0f;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(3.0f,3.0f);
        
        self.contentImageView = [[BFImageView alloc]init];
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
        UIImageView *backImgView = [[UIImageView alloc]init];
        backImgView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        backImgView.image = [UIImage imageNamed:@"huabao_cell_bg.png"];
        [self addSubview:backImgView];
        [backImgView release];
        
        self.contentImageView = [[BFImageView alloc]init];
        self.contentImageView.frame = CGRectMake(5,5,frame.size.width-10,self.frame.size.height-10-40);
        [self addSubview:self.contentImageView];
        [self.contentImageView release];
        
        //
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.frame = CGRectMake(5,self.frame.size.height-40-5,self.frame.size.width-10,25);
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.titleLabel];
        [self.titleLabel release];
        
        self.productArray = [[NSMutableArray alloc]init];
        _tapAction = [tapAction copy];
        
        [self addTarget:self action:@selector(tapOnSelfAction) forControlEvents:UIControlEventTouchUpInside];
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
}
- (void)setItemImage:(NSDictionary *)contentDict
{
    NSString *imageUrl = [contentDict objectForKey:@"images"];
    self.contentImageView.image = [UIImage imageNamed:@"no_photo.png"];
    [[BFImageDownloader shareLoader]downloadImageWithUrl:imageUrl forView:self.contentImageView];
}
- (void)setImage:(UIImage *)contentImage
{
    self.contentImageView.image = contentImage;
}

- (void)tapOnSelfAction
{
    if (_tapAction) {
        _tapAction();
    }
}


@end
