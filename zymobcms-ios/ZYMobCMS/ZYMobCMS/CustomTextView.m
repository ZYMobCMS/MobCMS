//
//  CustomTextView.m
//  PPFIpad
//
//  Created by ZYVincent on 12-10-31.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import "CustomTextView.h"

@interface UITextView()
- (id)styleString;
@end

@implementation CustomTextView

- (id)styleString
{
    return [[super styleString] stringByAppendingString:@"; line-height: 1.7em"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
