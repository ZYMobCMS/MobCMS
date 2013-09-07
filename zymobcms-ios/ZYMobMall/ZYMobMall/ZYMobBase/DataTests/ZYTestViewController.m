//
//  ZYTestViewController.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-3.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYTestViewController.h"
#import "ZYUserTestViewController.h"
#import "ZYPictureTestViewController.h"
#import "ZYProductTestViewController.h"
#import "ZYNewsTestViewController.h"

@interface ZYTestViewController ()

@end

@implementation ZYTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    menuCenter = [[ZYMenuDataCenter alloc]init];
    menuArray = [[NSMutableArray alloc]init];
    
    [menuCenter startGetApplicationInfo];
    [menuCenter setGetApplicationInfoSuccessAction:^(ZYApplicationModel *appicationModel) {
        NSLog(@"application name %@",appicationModel.name);
    }];
    [menuCenter setGetApplicationInfoFaildAction:^(NSString *errMsg) {
        NSLog(@"application info faild --->%@",errMsg);
    }];
    [menuCenter startGetMenuList];
    [menuCenter setGetMenuListSuccessAction:^(NSArray *menuListArray) {
        
        NSMutableArray *newControllers = [NSMutableArray array];
        ZYUserTestViewController *userTestVC = [[ZYUserTestViewController alloc]init];
        userTestVC.title = @"User";
        [newControllers addObject:userTestVC];
        [userTestVC release];
        
        ZYNewsTestViewController *newsTestVC = [[ZYNewsTestViewController alloc]init];
        newsTestVC.title = @"News";
        newsTestVC.mItem = [menuListArray objectAtIndex:0];
        [newControllers addObject:newsTestVC];
        [newsTestVC release];
        
        ZYPictureTestViewController *picTestVC = [[ZYPictureTestViewController alloc]init];
        [newControllers addObject:picTestVC];
        picTestVC.mItem = [menuListArray objectAtIndex:2];
        picTestVC.title = @"Picture";
        [picTestVC release];
        
        ZYProductTestViewController *proTestVC = [[ZYProductTestViewController alloc]init];
        [newControllers addObject:proTestVC];
        proTestVC.mItem = [menuListArray objectAtIndex:3];
        proTestVC.title = @"Product";
        [proTestVC release];
        
        self.viewControllers = newControllers;
        
        
    }];
    [menuCenter setGetMenuListFaildAction:^(NSString *errMsg) {
        NSLog(@"application menu faild -->%@",errMsg);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
