//
//  ZYSnapView.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYSnapView.h"

@implementation ZYSnapView
@synthesize blackBoradView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        blackBoradView = [[UIView alloc]initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        blackBoradView.backgroundColor = [UIColor blackColor];
        blackBoradView.alpha = 0.f;
        [self addSubview:blackBoradView];
        [blackBoradView release];
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
