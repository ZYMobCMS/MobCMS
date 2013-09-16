//
//  ZYScrollView.h
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYScrollView : UIScrollView
{
    UIImageView *contentBackView;
}
@property (nonatomic,retain)UIImageView *contentBackView;
@end
