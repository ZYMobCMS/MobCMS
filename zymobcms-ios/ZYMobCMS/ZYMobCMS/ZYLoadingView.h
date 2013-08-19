//
//  ZYLoadingView.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYLoadingView : UIView
@property (nonatomic,retain)UIActivityIndicatorView *indicatorView;
@property (nonatomic,retain)UILabel     *titleLabel;

- (void)startLoading;
- (void)stopLoading;
@end
