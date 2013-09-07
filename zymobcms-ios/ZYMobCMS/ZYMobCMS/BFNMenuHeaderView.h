//
//  BFNMenuHeaderView.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-26.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFNMenuHeaderView;

typedef void (^tapOnMenuHeader) (BFNMenuHeaderView *headerView);

@interface BFNMenuHeaderView : UIControl
{
    tapOnMenuHeader _headTapBlock;
}
@property (retain, nonatomic) UIImageView *headLine;
@property (retain, nonatomic) UIImageView *bottomLine;
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UIButton *leftTagImageView;

- (id)initWithFrame:(CGRect)frame withTapOnHeader:(tapOnMenuHeader)tapOnHeader;
- (void)setShowLeftIcon:(BOOL)state;
- (void)setLeftIconDown:(BOOL)state;

@end
