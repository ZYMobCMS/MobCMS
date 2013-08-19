//
//  ZYPullHeaderView.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPullHeaderView.h"

@implementation ZYPullHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //logo
        UIImageView *zylogo = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-80)/2-4,self.frame.size.height-30,80,40)];
        zylogo.image = [UIImage imageNamed:@"zylogo.png"];
        [self addSubview:zylogo];
        [zylogo release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
