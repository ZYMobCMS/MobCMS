//
//  BFNBarButton.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-27.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFNBarButton;
typedef void (^tapOnBarButton) (BFNBarButton *sender);

@interface BFNBarButton : UIView
{
    UIButton *itemBtn;
    
    tapOnBarButton _tapOnItemBlock;
}

- (void)setTitle:(NSString*)title;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage*)itemImage withTapOnBarButton:(tapOnBarButton)tapOnBarBtn;

@end
