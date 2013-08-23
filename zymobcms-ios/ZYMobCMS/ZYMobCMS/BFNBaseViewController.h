//
//  BFNBaseViewController.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYLoadingView.h"

@interface BFNBaseViewController : UIViewController
{
    ZYLoadingView *lodingView;
}
@property (nonatomic,retain)NSString *mainTitle;
@property (nonatomic,assign)BOOL      isSwipTurnOn;
@property (nonatomic,assign)BOOL      isCategoryType;
@property (nonatomic,assign)UINavigationController *superNavigationController;

- (void)enableSwipRightToReturn;
- (void)desableSwipRightToReturn;
- (void)startLoading;
- (void)stopLoading;

- (void)getListData;
- (void)getCategoryData;

@end
