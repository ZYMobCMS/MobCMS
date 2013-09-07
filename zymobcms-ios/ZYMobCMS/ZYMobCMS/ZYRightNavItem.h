//
//  ZYRightNavItem.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-25.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^tapOnNavLeftItemAction) (void);
typedef void (^tapOnNavRightItemAction) (void);
@interface ZYRightNavItem : UIView
{
    tapOnNavLeftItemAction _tapOnLeftItemAction;
    tapOnNavRightItemAction _tapOnRightItemAction;
}
- (id)initWithFrame:(CGRect)frame withLeftIcon:(UIImage*)leftIcon withRightIcon:(UIImage*)rightIcon;

- (void)setLeftItemAction:(tapOnNavLeftItemAction)leftItemAction;
- (void)setRightItemAction:(tapOnNavRightItemAction)rightItemAction;

@end
