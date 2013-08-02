//
//  BFLoadMoreView.h
//  BarfooBlog
//
//  Created by ZYVincent on 12-12-13.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFLoadMoreView : UIControl
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UIActivityIndicatorView *indicatorView;

- (void)startAnimation;
- (void)stopAnimation;

@end
