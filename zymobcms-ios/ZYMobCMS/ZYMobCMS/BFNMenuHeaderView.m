//
//  BFNMenuHeaderView.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-26.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNMenuHeaderView.h"

@implementation BFNMenuHeaderView
@synthesize headLine,bottomLine,titleLabel;
@synthesize leftTagImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //
        headLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,frame.size.width,2)];
        headLine.hidden = YES;
        [self addSubview:headLine];
        [headLine release];
                
        //
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,2,frame.size.width,frame.size.height-2-2)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        //
        bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,frame.size.height-2,frame.size.width,2)];
        bottomLine.hidden = YES;
        [self addSubview:bottomLine];
        [bottomLine release];
        
    }
    return self;
}
- (void)dealloc
{
    if (_headTapBlock) {
        [_headTapBlock release];
    }
    [super dealloc];
}

- (void)tapOnSelf
{
    leftTagImageView.selected = !leftTagImageView.selected;
    if (_headTapBlock) {
        _headTapBlock (self);
    }
}

- (id)initWithFrame:(CGRect)frame withTapOnHeader:(tapOnMenuHeader)tapOnHeader
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //
        headLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,frame.size.width,2)];
        headLine.hidden = YES;
        [self addSubview:headLine];
        [headLine release];
        
        leftTagImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        leftTagImageView.frame = CGRectMake(5,13,18,18);
        [leftTagImageView setBackgroundImage:[UIImage imageNamed:@"open.png"] forState:UIControlStateSelected];
        [leftTagImageView setBackgroundImage:[UIImage imageNamed:@"fold.png"] forState:UIControlStateNormal];
        [leftTagImageView addTarget:self action:@selector(tapOnSelf) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftTagImageView];
        
        //
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftTagImageView.frame.origin.x+leftTagImageView.frame.size.width+10,2,frame.size.width-leftTagImageView.frame.origin.x-leftTagImageView.frame.size.width-10,frame.size.height-2-2)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor blackColor];
        [self addSubview:titleLabel];
        [titleLabel release];
        
        //
        bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,frame.size.height-2,frame.size.width,2)];
        bottomLine.hidden = YES;
        [self addSubview:bottomLine];
        [bottomLine release];
        
        _headTapBlock = [tapOnHeader copy];
        
        [self addTarget:self action:@selector(tapOnSelf) forControlEvents:UIControlEventTouchUpInside];

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

- (void)setShowLeftIcon:(BOOL)state
{
    
    if (state) {
        leftTagImageView.hidden = NO;

        CGRect oldFrame = titleLabel.frame;
        
        titleLabel.frame = CGRectMake(leftTagImageView.frame.origin.x+leftTagImageView.frame.size.width+10,oldFrame.origin.y,oldFrame.size.width-leftTagImageView.frame.size.width-10,oldFrame.size.height);
    }else{
        
        leftTagImageView.hidden = YES;

        titleLabel.frame = CGRectMake(0,2,self.frame.size.width,self.frame.size.height-2-2);
    }
    
}

- (void)setLeftIconDown:(BOOL)state
{
    leftTagImageView.selected = state;
}

@end
