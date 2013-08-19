//
//  ZYAboutCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-18.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYAboutCell : UITableViewCell
{
    UILabel *tagLabel;
    UILabel *valueLabel;
}

- (void)setContentDict:(NSDictionary*)contentDict;
+ (CGFloat)heightForDict:(NSDictionary*)contentDict forTable:(UITableView*)table;

@end
