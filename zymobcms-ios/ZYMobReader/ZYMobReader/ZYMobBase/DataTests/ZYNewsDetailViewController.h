//
//  ZYNewsDetailViewController.h
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-8.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNewsDetailViewController : UIViewController
{
    ZYNewsDataCenter *dataCenter;
}
@property (nonatomic,retain)ZYNewsModel *newsModel;

@end
