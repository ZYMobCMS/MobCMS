//
//  ZYPictureCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-3.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPictureCell.h"

#define ImageItemMargin 30
#define ImageWidth      85
#define ImageHeight     85

@implementation ZYPictureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    if (_tapOnCellAction) {
        [_tapOnCellAction release];
    }
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTapOnCell:(tapOnCellAction)tapOnCellAction
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _tapOnCellAction = [tapOnCellAction copy];
        
        leftItem = [[ImageItem alloc]initWithFrame:CGRectMake(50,10,ImageWidth,ImageHeight) withTapAction:^(NSString *productId) {
            if (_tapOnCellAction) {
                _tapOnCellAction(productId);
            }
        }];
        [self.contentView addSubview:leftItem];
        [leftItem release];
        
        rightItem = [[ImageItem alloc]initWithFrame:CGRectMake(50+ImageWidth+50,10,ImageWidth,ImageHeight ) withTapAction:^(NSString *productId) {
            if (_tapOnCellAction) {
                _tapOnCellAction(productId);
            }
        }];
        [self.contentView addSubview:rightItem];
        [rightItem release];
        
    }
    return self;
}



@end
