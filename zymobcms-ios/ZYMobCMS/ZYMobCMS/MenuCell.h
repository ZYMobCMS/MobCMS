//
//  MenuCell.h
//  PPFIphone
//
//  Created by ZYVincent on 12-11-30.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titlLabel;
@property (retain, nonatomic) IBOutlet UIImageView *iconImgView;
@property (retain, nonatomic) IBOutlet UIImageView *lineView;
@property (assign,nonatomic)NSInteger itemIndex;

@end
