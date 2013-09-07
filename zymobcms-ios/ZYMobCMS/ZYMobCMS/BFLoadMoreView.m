//
//  BFLoadMoreView.m
//  BarfooBlog
//
//  Created by ZYVincent on 12-12-13.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "BFLoadMoreView.h"

@implementation BFLoadMoreView
@synthesize titleLabel,indicatorView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.frame = CGRectMake(frame.size.width * 1/16, frame.size.height * 1/8, frame.size.width *2/8, frame.size.height * 6/8);
        [self addSubview:indicatorView];
        [indicatorView release];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [titleLabel setTextColor:[UIColor colorWithRed:54/255.0 green:100/255.0 blue:139/255.0 alpha:1.0]];
        titleLabel.text = @"加载更多...";
        titleLabel.textAlignment = UITextAlignmentCenter;
        //titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.frame = CGRectMake(0,self.frame.size.height * 1/8,self.frame.size.width,self.frame.size.height * 6/8);
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        [titleLabel release];
    }
    return self;
}

- (void)dealloc
{    
    [super dealloc];
}

- (void)startAnimation
{
    indicatorView.frame = CGRectMake(self.frame.size.width *5/18,self.frame.size.height * 2/8,self.frame.size.width *1/18,self.frame.size.height*4/8);
    titleLabel.frame    = CGRectMake(0,self.frame.size.height * 1/8,self.frame.size.width,self.frame.size.height *6/8);
    [self.indicatorView startAnimating];
}

- (void)stopAnimation
{
    titleLabel.frame = CGRectMake(0,self.frame.size.height * 1/8,self.frame.size.width,self.frame.size.height * 6/8);
    [self.indicatorView stopAnimating];
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
