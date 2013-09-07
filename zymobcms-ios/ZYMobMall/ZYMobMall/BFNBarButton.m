//
//  BFNBarButton.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-27.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNBarButton.h"

@implementation BFNBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    if (_tapOnItemBlock) {
        [_tapOnItemBlock release];
    }
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)itemImage withTapOnBarButton:(tapOnBarButton)tapOnBarBtn
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        [itemBtn setBackgroundImage:itemImage forState:UIControlStateNormal];
        [itemBtn addTarget:self action:@selector(tapOnSelf) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        
        _tapOnItemBlock = [tapOnBarBtn copy];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [itemBtn setTitle:title forState:UIControlStateNormal];
}

- (void)tapOnSelf
{
    if (_tapOnItemBlock) {
        _tapOnItemBlock(self);
    }
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
