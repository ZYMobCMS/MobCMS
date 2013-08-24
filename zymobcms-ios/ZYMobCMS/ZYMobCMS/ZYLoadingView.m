//
//  ZYLoadingView.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYLoadingView.h"

@implementation ZYLoadingView
@synthesize indicatorView,titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        indicatorView = [[UIActivityIndicatorView alloc]init];
        indicatorView.frame = CGRectMake(5,2,50,46);
        [self addSubview:indicatorView];
        [indicatorView release];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(55,2,100,46);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"正在加载...";
        [self addSubview:titleLabel];
        [titleLabel release];
        
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

- (void)startLoading
{
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
    [indicatorView startAnimating];
}

- (void)stopLoading
{
    self.hidden = YES;
    [self.superview sendSubviewToBack:self];
    [indicatorView stopAnimating];
}

@end
