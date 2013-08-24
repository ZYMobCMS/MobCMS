//
//  ZYSwitchCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-24.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapOnSwitchAction) (BOOL switchState);
@interface ZYSwitchCell : UITableViewCell
{
    UILabel *titleLabel;
    UISwitch *switcher;
    tapOnSwitchAction _tapSwitchAction;
}
@property (nonatomic,assign)BOOL activeState;

- (void)setTitle:(NSString*)title;

- (void)setTapSwitchAction:(tapOnSwitchAction)tapSwitchAction;

@end
