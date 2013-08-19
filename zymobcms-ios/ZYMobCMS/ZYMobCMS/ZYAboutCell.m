//
//  ZYAboutCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-18.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYAboutCell.h"

#define ValueLabeFontSize 13

@implementation ZYAboutCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,5,100,34)];
        tagLabel.textAlignment = UITextAlignmentCenter;
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:tagLabel];
        [tagLabel release];
        
        valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(115,5,100,34)];
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.numberOfLines = 0;
        valueLabel.font = [UIFont systemFontOfSize:ValueLabeFontSize];
        [self.contentView addSubview:valueLabel];
        [valueLabel release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentDict:(NSDictionary *)contentDict
{
    NSString *tagName =[NSString stringWithFormat:@"%@:",[contentDict objectForKey:@"tag"]];
    NSString *value = [contentDict objectForKey:@"value"];
    
    tagLabel.text = tagName;
    
    CGSize valueSize = [value sizeWithFont:[UIFont systemFontOfSize:ValueLabeFontSize] constrainedToSize:CGSizeMake(self.frame.size.width-115-30,99999)];
    
    valueLabel.frame = CGRectMake(115,5,valueSize.width,MAX(valueSize.height,34));
    valueLabel.text = value;
    
}

+ (CGFloat)heightForDict:(NSDictionary *)contentDict forTable:(UITableView *)table
{
    NSString *value = [contentDict objectForKey:@"value"];
    
    CGSize valueSize = [value sizeWithFont:[UIFont systemFontOfSize:ValueLabeFontSize] constrainedToSize:CGSizeMake(table.frame.size.width-115-30,99999)];
    
    return MAX(valueSize.height + 10,44);
}

@end
