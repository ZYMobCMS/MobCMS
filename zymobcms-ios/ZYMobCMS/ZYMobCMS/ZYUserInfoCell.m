//
//  ZYUserInfoCell.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-26.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYUserInfoCell.h"

#define LeftMargin 10
#define TopMarign 10
#define TextMargin 10

@implementation ZYUserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSDictionary *userDict = [ZYUserManager getCurrentUserDict];
        
        nameTagLabel = [[UILabel alloc]init];
        nameTagLabel.frame = CGRectMake(LeftMargin,TopMarign,80,30);
        nameTagLabel.backgroundColor = [UIColor clearColor];
        nameTagLabel.font = [UIFont systemFontOfSize:15];
        nameTagLabel.text = @"用户登录名:";
        [self.contentView addSubview:nameTagLabel];
        [nameTagLabel release];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(LeftMargin+nameTagLabel.frame.size.width+TextMargin,TopMarign,80,30);
        nameLabel.text = [ZYUserManager getCurrentUserLoginName];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        [nameLabel release];
        
        userTypeTagLabel = [[UILabel alloc]init];
        userTypeTagLabel.frame = CGRectMake(LeftMargin,TopMarign+30+TextMargin,80,30);
        userTypeTagLabel.text = @"用户级别:";
        userTypeTagLabel.backgroundColor = [UIColor clearColor];
        userTypeTagLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:userTypeTagLabel];
        [userTypeTagLabel release];
        
        userTypeLabel = [[UILabel alloc]init];
        userTypeLabel.frame = CGRectMake(userTypeTagLabel.frame.size.width,TopMarign+30+TextMargin,80,30);
        [self.contentView addSubview:userTypeLabel];
        userTypeLabel.backgroundColor = [UIColor clearColor];
        userTypeLabel.font = [UIFont systemFontOfSize:15];
        userTypeLabel.text = [userDict objectForKey:@"type_name"];
        [userTypeLabel release];
        
        pointTagLabel = [[UILabel alloc]init];
        pointTagLabel.frame = CGRectMake(userTypeTagLabel.frame.size.width+userTypeLabel.frame.size.width+TextMargin,TopMarign+30+TextMargin,80, 30);
        pointTagLabel.text = @"用户积分:";
        [self.contentView addSubview:pointTagLabel];
        pointTagLabel.backgroundColor = [UIColor clearColor];
        pointTagLabel.font = [UIFont systemFontOfSize:15];
        [pointTagLabel release];
        
        pointLabel = [[UILabel alloc]init];
        pointLabel.frame = CGRectMake(pointTagLabel.frame.origin.x+pointTagLabel.frame.size.width+TextMargin,TopMarign+30+TextMargin,80,30);
        pointLabel.backgroundColor = [UIColor clearColor];
        pointLabel.font = [UIFont systemFontOfSize:15];
        pointLabel.text = [userDict objectForKey:@"points"];
        [self.contentView addSubview:pointLabel];
        [pointLabel release];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
