//
//  ZYProductDetail_0_Text_Cell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"


@interface ZYProductDetail_0_Text_Cell : UITableViewCell
{
    BFAttributedView *contentTextView;
}

- (void)setContentString:(NSString *)content;
+ (CGFloat)heightForContent:(NSString*)content forTable:(UITableView*)table;

@end
