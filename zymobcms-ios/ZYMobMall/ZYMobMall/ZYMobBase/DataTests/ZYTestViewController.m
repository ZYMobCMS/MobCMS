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
    
    //蓝色主题
    NSArray *allThemes = [ZYThemeManager returnAllThemes];
    [ZYThemeManager setCurrentThemesWithThemeConfig:[allThemes objectAtIndex:1]];
    
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
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:userTestVC];
        [userNav.navigationBar setBackgroundImage:[ZYThemeManager getImageWithName:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
        [userTestVC release];
        [newControllers addObject:userNav];
        [userNav release];
        
        
        ZYNewsTestViewController *newsTestVC = [[ZYNewsTestViewController alloc]init];
        newsTestVC.title = @"News";
        newsTestVC.mItem = [menuListArray objectAtIndex:0];
        UINavigationController *newsNav = [[UINavigationController alloc]initWithRootViewController:newsTestVC];
        [newsNav.navigationBar setBackgroundImage:[ZYThemeManager getImageWithName:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
        [newsTestVC release];
        [newControllers addObject:newsNav];
        [newsNav release];
        
        ZYPictureTestViewController *picTestVC = [[ZYPictureTestViewController alloc]init];
        picTestVC.mItem = [menuListArray objectAtIndex:2];
        UINavigationController *picNav = [[UINavigationController alloc]initWithRootViewController:picTestVC];
        [picNav.navigationBar setBackgroundImage:[ZYThemeManager getImageWithName:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
        picTestVC.title = @"Picture";
        [newControllers addObject:picNav];
        [picTestVC release];
        [picNav release];
        
        
        ZYProductTestViewController *proTestVC = [[ZYProductTestViewController alloc]init];        
        proTestVC.mItem = [menuListArray objectAtIndex:3];
        proTestVC.title = @"Product";
        UINavigationController *proNav = [[UINavigationController alloc]initWithRootViewController:proTestVC];
        [proNav.navigationBar setBackgroundImage:[ZYThemeManager getImageWithName:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
        [newControllers addObject:proNav];
        [proTestVC release];
        [proNav release];
        
        self.viewControllers = newControllers;
        
        
    }];
    [menuCenter setGetMenuListFaildAction:^(NSString *errMsg) {
        NSLog(@"application menu faild -->%@",errMsg);
    }];

    self.tabBar.tintColor = [ZYThemeManager getThemeColorByKey:@"TabBarColor"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
