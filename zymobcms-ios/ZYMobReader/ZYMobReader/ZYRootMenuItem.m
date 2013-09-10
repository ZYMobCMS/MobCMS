//
//  ZYRootMenuItem.m
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-10.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYRootMenuItem.h"

@implementation ZYRootMenuItem
@synthesize indexPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        backImgView = [[BFImageView alloc]init];
        backImgView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        [self addSubview:backImgView];
        [backImgView release];
        
        iconImgView = [[BFImageView alloc]init];
        iconImgView.frame = CGRectMake(50,50,50,50);
        [self addSubview:iconImgView];
        [iconImgView release];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(0, 55, frame.size.width,frame.size.height-55);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel release];
    }
    return self;
}
- (void)dealloc
{
    self.indexPath = nil;
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

- (id)initWithMenuItemModel:(ZYMenuItemModel *)menuItem withFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        backImgView = [[BFImageView alloc]init];
        backImgView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        [self addSubview:backImgView];
        [backImgView release];
        
        iconImgView = [[BFImageView alloc]init];
        iconImgView.frame = CGRectMake(50,50,50,50);
        [self addSubview:iconImgView];
        [iconImgView release];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(0, 55, frame.size.width,frame.size.height-55);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.text = menuItem.name;
        [self addSubview:titleLabel];
        [titleLabel release];
        
    }
    return self;
}
- (void)setContentModel:(ZYMenuItemModel *)menuItem
{
    titleLabel.text = menuItem.name;
}
@end
