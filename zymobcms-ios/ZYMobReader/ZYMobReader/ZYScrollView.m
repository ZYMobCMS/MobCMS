//
//  ZYScrollView.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYScrollView.h"

@implementation ZYScrollView
@synthesize contentBackView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        contentBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.contentSize.width,self.contentSize.height)];
        [self addSubview:contentBackView];
        [contentBackView release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
