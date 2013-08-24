//
//  UIButtonCustomized.h
//  OPinion
//
//  Created by li sha on 12-7-22.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonCustomized : UIButton
{
    UIViewController *additionalViewController;
    UIView *additionalView;
    NSDictionary *additionContent;
}

@property (assign, nonatomic) UIViewController *additionalViewController;
@property (assign, nonatomic) UIView *additionalView;
@property (assign, nonatomic) NSDictionary *additionContent;
@property (assign, nonatomic) UILabel *btnTitle;

@end
