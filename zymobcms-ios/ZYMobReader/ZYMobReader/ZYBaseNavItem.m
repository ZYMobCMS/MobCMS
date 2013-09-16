//
//  ZYBaseNavItem.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseNavItem.h"

@implementation ZYBaseNavItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withItemImage:(UIImage *)itemImage withTarget:(id)actionTarget withTapOnSelf:(SEL)tapOnSelf
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:itemImage];
        _mAction = tapOnSelf;
        _mTarget = actionTarget;
        
        [self addTarget:self action:@selector(selfTapInside) forControlEvents:UIControlEventTouchUpInside];
        
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

- (void)selfTapInside
{
    if (_mTarget) {
        
        [_mTarget performSelector:_mAction];
    }
}

@end
