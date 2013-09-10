//
//  ZYRootMenuPageView.h
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-10.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYRootMenuPageView : UIView
{
    NSMutableArray *itemsArray;
    NSMutableArray *itemIndexPaths;
}
@property (nonatomic,assign)NSInteger pageIndex;

- (void)setMenuItemArray:(NSArray*)menuItemArray;

@end
