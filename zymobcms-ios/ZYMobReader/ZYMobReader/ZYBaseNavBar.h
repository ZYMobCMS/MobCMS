//
//  ZYBaseNavBar.h
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYBaseNavBar : UIView

- (id)initBaseReturnBarWithFrame:(CGRect)frame withTarget:(id)baseTarget withReturnSel:(SEL)returnSel;

- (void)insertNavItemWithImage:(UIImage*)itemImage withFrame:(CGRect)frame withTarget:(id)itemTarget withTapSelector:(SEL)tapOnItemSel;

@end
