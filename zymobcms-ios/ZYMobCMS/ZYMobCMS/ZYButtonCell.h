//
//  ZYButtonCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapOnButton) (void);
@interface ZYButtonCell : UITableViewCell
{
    tapOnButton _tapAction;
}
@property (nonatomic,retain)UIButton *actionBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTapOnBtn:(tapOnButton)tapAction;

@end
