//
//  ZYUserInfoCell.h
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-26.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UserInfoCellHeight 80

@interface ZYUserInfoCell : UITableViewCell
{
    UILabel *nameTagLabel;
    UILabel *nameLabel;
    UILabel *userTypeTagLabel;
    UILabel *userTypeLabel;
    UILabel *pointTagLabel;
    UILabel *pointLabel;
}

@end
