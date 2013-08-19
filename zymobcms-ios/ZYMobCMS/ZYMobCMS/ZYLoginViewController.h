//
//  ZYLoginViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LoginSuccessAction) (void);
@interface ZYLoginViewController : BFNBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *listTable;

    NSMutableArray *sourceArray;
    
    LoginSuccessAction _successAction;
    
}
- (void)setSuccessLoginAction:(LoginSuccessAction)loginSuccessAction;

@end
