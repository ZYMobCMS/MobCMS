//
//  ZYRootMenuPageView.h
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-10.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYRootMenuPageView;
@protocol ZYRootMenuPageViewDelegate <NSObject>

- (void)rootMenuPageView:(ZYRootMenuPageView*)pageView didSelectAtIndex:(NSInteger)selectIndex;

@end
@interface ZYRootMenuPageView : UIView
{
    NSMutableArray *itemsArray;
    NSMutableArray *itemIndexPaths;
}
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,assign)id<ZYRootMenuPageViewDelegate> delegate;

- (void)setMenuItemArray:(NSArray*)menuItemArray;

@end
