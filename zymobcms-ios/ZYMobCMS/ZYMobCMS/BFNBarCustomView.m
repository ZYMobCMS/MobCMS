//
//  BFNBarCustomView.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-27.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNBarCustomView.h"

#define BaseTag 899881

@implementation BFNBarCustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithRootItemButton:(BFNBarButton *)rootItem withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        rootItem.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        rootItem.tag = BaseTag;
        [self addSubview:rootItem];
        [rootItem release];
        
    }
    return self;
}

- (void)insertNewItemButton:(BFNBarButton *)newItem
{
    int lastItemTag = 0;
    for (UIView *item in self.subviews) {
        
        if (item.tag > lastItemTag) {
            lastItemTag = item.tag;
        }
    }
        
    newItem.tag = lastItemTag+1;
    UIView *lastItem = [self viewWithTag:lastItemTag];
    newItem.frame = CGRectMake(lastItem.frame.origin.x+lastItem.frame.size.width+10,0,lastItem.frame.size.width,lastItem.frame.size.height);
    [self addSubview:newItem];
    [newItem release];
    CGRect oldFrame = self.frame;
    self.frame = CGRectMake(oldFrame.origin.x,oldFrame.origin.y,oldFrame.size.width+lastItem.frame.size.width+10,oldFrame.size.height);
    
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
