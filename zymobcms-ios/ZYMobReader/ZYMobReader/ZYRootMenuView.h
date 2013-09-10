//
//  ZYRootMenuView.h
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-10.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRootMenuPageView.h"

@class ZYRootMenuView;
@protocol ZYRootMenuViewDataSource<NSObject>

- (NSInteger)numberOfPagesInMenuView:(ZYRootMenuView *)menuView;
- (NSArray *)menuItemsInMenuView:(ZYRootMenuView*)menuView atPageIndex:(NSInteger)pageIndex;
- (void)menuView:(ZYRootMenuView*)menuView didSelectAtPageIndex:(NSInteger)pageIndex atItemIndexPath:(NSIndexPath*)selectIndexPath;

@end

@interface ZYRootMenuView :UIView
{
}
@property (nonatomic,assign)id<ZYRootMenuViewDataSource> dataSource;

@end
