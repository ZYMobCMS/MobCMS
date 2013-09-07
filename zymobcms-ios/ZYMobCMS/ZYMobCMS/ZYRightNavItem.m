//
//  ZYRightNavItem.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-25.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYRightNavItem.h"

@implementation ZYRightNavItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withLeftIcon:(UIImage *)leftIcon withRightIcon:(UIImage *)rightIcon
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect leftItemRect = CGRectMake(0,0,32,32);
        BFNBarButton *leftButton = [[BFNBarButton alloc]initWithFrame:leftItemRect withImage:leftIcon withTapOnBarButton:^(BFNBarButton *sender) {
            if (_tapOnLeftItemAction) {
                _tapOnLeftItemAction();
            }
        }];
        [self addSubview:leftButton];
        [leftButton release];
        
        CGRect rightItemRect = CGRectMake(45,0,30,30);
        BFNBarButton *rightButton = [[BFNBarButton alloc]initWithFrame:rightItemRect withImage:rightIcon withTapOnBarButton:^(BFNBarButton *sender) {
            if (_tapOnRightItemAction) {
                _tapOnRightItemAction();
            }
        }];
        [self addSubview:rightButton];
        [rightButton release];
        
    }
    return self;
}

- (void)setLeftItemAction:(tapOnNavLeftItemAction)leftItemAction
{
    if (_tapOnLeftItemAction) {
        [_tapOnLeftItemAction release];
    }
    _tapOnLeftItemAction = [leftItemAction copy];
}

- (void)setRightItemAction:(tapOnNavRightItemAction)rightItemAction
{
    if (_tapOnRightItemAction){
        [_tapOnRightItemAction release];
    }
    _tapOnRightItemAction = [rightItemAction copy];
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
