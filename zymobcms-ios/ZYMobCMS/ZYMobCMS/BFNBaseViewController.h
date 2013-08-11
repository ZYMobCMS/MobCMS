//
//  BFNBaseViewController.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFNBaseViewController : UIViewController
{
    
}
@property (nonatomic,retain)NSString *mainTitle;
@property (nonatomic,assign)BOOL      isSwipTurnOn;

- (void)enableSwipRightToReturn;
- (void)desableSwipRightToReturn;

@end
