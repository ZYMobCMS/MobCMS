//
//  ZYShareSettingViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-25.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "BFNBaseViewController.h"

@interface ZYShareSettingViewController : BFNBaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    UITableView   *_snsTableView;
        
    UISwitch *_changeSwitcher;
}
@end
