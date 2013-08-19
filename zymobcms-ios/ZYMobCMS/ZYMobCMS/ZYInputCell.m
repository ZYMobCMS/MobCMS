//
//  ZYInputCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYInputCell.h"

@implementation ZYInputCell
@synthesize tagLabel;
@synthesize inputField;
@synthesize placeHolder;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        tagLabel = [[UILabel alloc]init];
        tagLabel.frame = CGRectMake(5,5,60,34);
        tagLabel.textAlignment = UITextAlignmentCenter;
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:tagLabel];
        [tagLabel release];
        
        inputBackImgView = [[UIImageView alloc]init];
        inputBackImgView.frame = CGRectMake(75,5,self.frame.size.width-60-10-10-30,34);
        inputBackImgView.image = [UIImage imageNamed:@"input.png"];
        [self.contentView addSubview:inputBackImgView];
        [inputBackImgView release];
        
        inputField = [[UITextField alloc]init];
        inputField.frame = CGRectMake(80,11,self.frame.size.width-60-20-10-30,30);
        inputField.placeholder = self.placeHolder;
        [self.contentView addSubview:inputField];
        [inputField release];
    }
    return self;
}

- (void)dealloc
{
    self.placeHolder = nil;
    [super dealloc];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
