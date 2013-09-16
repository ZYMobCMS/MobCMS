//
//  ZYBaseNavItem.h
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYBaseNavItem : UIControl
{
    id _mTarget;
    SEL _mAction;
}

- (id)initWithFrame:(CGRect)frame withItemImage:(UIImage*)itemImage withTarget:(id)actionTarget withTapOnSelf:(SEL)tapOnSelf;

@end
