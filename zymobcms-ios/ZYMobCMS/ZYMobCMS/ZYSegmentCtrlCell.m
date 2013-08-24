//
//  ZYSegmentCtrlCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-24.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYSegmentCtrlCell.h"

@implementation ZYSegmentCtrlCell
@synthesize activeState;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(10,5,self.frame.size.width-20-20,44-10);
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        [titleLabel release];
        
        segmentCtrl = [[UISwitch alloc]init];
        segmentCtrl.frame = CGRectMake(self.frame.size.width-10,5,130,44-10);
        [self.contentView addSubview:segmentCtrl];
        [segmentCtrl release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSegmentState:(BOOL)state withTitle:(NSString *)title
{
    self.activeState = state;
    
}

@end
