//
//  ZYSegmentCtrlCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-24.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYSegmentCtrlCell : UITableViewCell
{
    UILabel *titleLabel;
    UISwitch *segmentCtrl;
}
@property (nonatomic,assign)BOOL activeState;

- (void)setSegmentState:(BOOL)state withTitle:(NSString*)title;

@end
