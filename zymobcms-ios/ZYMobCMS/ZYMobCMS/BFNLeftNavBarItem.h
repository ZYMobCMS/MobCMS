//
//  BFNLeftNavBarItem.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapUpInside)(void);

@interface BFNLeftNavBarItem : UIView
{
    tapUpInside _tapInsideBlock;
}
@property (nonatomic,retain)UIButton *itemButton;
@property (nonatomic,retain)UILabel  *itemLabel;

- (void)setItemNormalImage:(UIImage*)nImage selectedImage:(UIImage*)sImage title:(NSString*)title tapItem:(tapUpInside)tapInside;

@end
