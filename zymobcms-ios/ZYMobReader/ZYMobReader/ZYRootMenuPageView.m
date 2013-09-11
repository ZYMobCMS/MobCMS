//
//  ZYRootMenuPageView.m
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-10.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYRootMenuPageView.h"
#import "ZYRootMenuItem.h"

#define ItemInnerMargin 8
#define ItemRoundMargin 20
#define RightMargin 80


@implementation ZYRootMenuPageView
@synthesize pageIndex;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)dealloc
{
    [itemsArray release];
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

- (void)initSubViews
{
    for (int i=0; i<itemsArray.count; i++) {
        
        int col = i%2;
        int row = (int)(i/2);
        
//        NSLog(@"col --->%d   row ----->%d",col,row);
        CGFloat itemWitdh = (self.frame.size.width-ItemRoundMargin-RightMargin-ItemInnerMargin)/2;
        CGFloat itemHeight = (self.frame.size.height - 2*ItemRoundMargin -3*ItemInnerMargin)/4;
        
        CGRect itemRect = CGRectMake(col*itemWitdh+ItemRoundMargin+ItemInnerMargin*col,row*itemHeight+ItemRoundMargin+ItemInnerMargin*row
                                     ,itemWitdh,itemHeight);
        ZYMenuItemModel *itemModel = [itemsArray objectAtIndex:i];

        if ([itemIndexPaths containsObject:[NSIndexPath indexPathForRow:row inSection:col]]) {
            
            for (ZYRootMenuItem *existItem in self.subviews) {
                
                if (existItem.indexPath == [NSIndexPath indexPathForRow:row inSection:col]) {
                    
                    [existItem setContentModel:itemModel];
                    existItem.frame = itemRect;
                    existItem.backgroundColor = [UIColor orangeColor];
                    
                }
            }
            
        }else{
            ZYRootMenuItem *item = [[ZYRootMenuItem alloc]initWithMenuItemModel:itemModel withFrame:itemRect];
            item.indexPath = [NSIndexPath indexPathForRow:row inSection:col];
            item.backgroundColor = [UIColor blueColor];
            [itemIndexPaths addObject:item.indexPath];
            [self addSubview:item];
            [item setTapOnItemAction:^(void) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(rootMenuPageView:didSelectAtIndex:)]) {
                    [self.delegate rootMenuPageView:self didSelectAtIndex:i];
                }
            }];
            [item release];
        }
    }
    
}

- (void)setMenuItemArray:(NSArray *)menuItemArray
{
    if (!itemsArray) {
        itemsArray = [[NSMutableArray alloc]init];
    }
    if (!itemIndexPaths) {
        itemIndexPaths = [[NSMutableArray alloc]init];
    }
    
    [itemsArray removeAllObjects];
    [itemsArray addObjectsFromArray:menuItemArray];

    [self initSubViews];
}

@end
