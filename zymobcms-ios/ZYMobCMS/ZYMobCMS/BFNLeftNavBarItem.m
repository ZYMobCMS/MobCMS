//
//  BFNLeftNavBarItem.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNLeftNavBarItem.h"

@implementation BFNLeftNavBarItem
@synthesize itemButton,itemLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        //
        itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.frame = CGRectMake(0,6.5,35,31);
        [itemButton addTarget:self action:@selector(tapOnButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemButton];
        
        //
        itemLabel = [[UILabel alloc]init];
        itemLabel.frame = CGRectMake(40,0,frame.size.width-44,44);
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textColor = [BFUitils rgbColor:158 green:38 blue:40];
        itemLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:itemLabel];
        [itemLabel release];
    }
    return self;
}

- (void)tapOnButton
{
    if (_tapInsideBlock) {
        _tapInsideBlock();
    }
}

- (void)dealloc
{
    [_tapInsideBlock release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setItemNormalImage:(UIImage *)nImage selectedImage:(UIImage *)sImage title:(NSString *)title tapItem:(tapUpInside)tapInside
{
    if (nImage) {
        [itemButton setBackgroundImage:nImage forState:UIControlStateNormal];
    }
    
    if (sImage) {
        [itemButton setBackgroundImage:sImage forState:UIControlStateHighlighted];
    }
    
    itemLabel.text = title;
    
    if (_tapInsideBlock) {
        [_tapInsideBlock release];
    }
    _tapInsideBlock = [tapInside copy];
    
}

@end
