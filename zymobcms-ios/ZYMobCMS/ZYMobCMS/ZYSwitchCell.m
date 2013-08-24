//
//  ZYSwitchCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-24.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYSwitchCell.h"

@implementation ZYSwitchCell
@synthesize activeState;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(10,5,self.frame.size.width-20-20,44-10);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:titleLabel];
        [titleLabel release];
        
        switcher = [[UISwitch alloc]initWithFrame:CGRectMake(self.frame.size.width-10-95,8,60,44-10)];
        switcher.onTintColor = [BFUitils rgbColor:200 green:50 blue:40];
        switcher.on = [ZYUserManager getUserActiveRecordState];
        [self.contentView addSubview:switcher];
        [switcher release];
        
    }
    return self;
}

- (void)dealloc
{
    if (_tapSwitchAction) {
        [_tapSwitchAction release];
    }
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (void)switcherOnOffAction:(UISwitch*)sender
{
    self.activeState = sender.on;
    if(_tapSwitchAction){
        _tapSwitchAction(self.activeState);
    }
}

- (void)setTapSwitchAction:(tapOnSwitchAction)tapSwitchAction
{
    if (_tapSwitchAction) {
        [_tapSwitchAction release];
    }
    _tapSwitchAction = [tapSwitchAction copy];
}

@end
