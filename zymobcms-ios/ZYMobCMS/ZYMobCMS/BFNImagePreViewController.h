//
//  BFNImagePreViewController.h
//  PPFIphone
//
//  Created by ZYVincent on 13-7-8.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFNImagePreViewController : BFNBaseViewController<UIScrollViewDelegate>
{
    UIScrollView *backScroller;
    
    UIButton *saveBtn;
    UIButton *closeBtn;
    
    UILabel *pageControlView;
}
@property (nonatomic,retain)NSString *imgString;
@property (nonatomic,assign)UIViewController *superVC;

- (id)initWithImageString:(NSString *)imageString;

- (void)closeSelf;

- (void)getAllImagesNow;

@end
