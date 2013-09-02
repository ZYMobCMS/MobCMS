//
//  ZYAboutViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNBaseViewController.h"
#import <MessageUI/MessageUI.h>

@interface ZYAboutViewController : BFNBaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
{
    NSMutableArray *sourceArray;
    UITableView    *listTable;
    
    BOOL _reloading;
}


@end
