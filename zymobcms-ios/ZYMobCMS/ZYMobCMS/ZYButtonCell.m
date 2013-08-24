//
//  ZYButtonCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYButtonCell.h"

@implementation ZYButtonCell
@synthesize actionBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *clearBack = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        clearBack.backgroundColor = [UIColor clearColor];
        self.backgroundView = clearBack;
        [clearBack release];
        
        actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = CGRectMake(0,0,self.frame.size.width-20,self.frame.size.height);
        actionBtn.layer.cornerRadius = 6.0f;
        actionBtn.layer.masksToBounds = YES;
        actionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:21];
        [actionBtn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:actionBtn];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTapOnBtn:(tapOnButton)tapAction
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *clearBack = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        clearBack.backgroundColor = [UIColor clearColor];
        self.backgroundView = clearBack;
        [clearBack release];
        
        actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.frame = CGRectMake(0,0,self.frame.size.width-20,self.frame.size.height);
        actionBtn.layer.cornerRadius = 6.0f;
        actionBtn.layer.masksToBounds = YES;
        actionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:21];
        [actionBtn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        [actionBtn addTarget:self action:@selector(tapOnBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:actionBtn];
        
        _tapAction = [tapAction copy];
    }
    return self;
}

- (void)dealloc
{
    if (_tapAction) {
        [_tapAction release];
    }
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapOnBtnAction
{
    if (_tapAction) {
        _tapAction();
    }
}
@end
