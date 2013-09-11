//
//  ZYBaseNavBar.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseNavBar.h"
#import "ZYBaseNavItem.h"

@implementation ZYBaseNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initBaseReturnBarWithFrame:(CGRect)frame withTarget:(id)baseTarget withReturnSel:(SEL)returnSel
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self insertNavItemWithImage:[ZYThemeManager getImageWithName:@"artilce_icon_return.png"] withFrame:CGRectMake(3,2,36,36) withTarget:baseTarget withTapSelector:returnSel];
        
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

- (void)insertNavItemWithImage:(UIImage *)itemImage withFrame:(CGRect)frame withTarget:(id)itemTarget withTapSelector:(SEL)tapOnItemSel 
{
    ZYBaseNavItem *newItem = [[ZYBaseNavItem alloc]initWithFrame:frame withItemImage:itemImage withTarget:itemTarget withTapOnSelf:tapOnItemSel];
    [self addSubview:newItem];
    [newItem release];
}


@end
