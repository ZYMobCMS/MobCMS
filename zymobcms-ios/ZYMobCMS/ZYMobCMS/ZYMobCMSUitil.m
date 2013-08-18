//
//  ZYMobCMSUitil.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMobCMSUitil.h"
#import "UIButtonCustomized.h"
#import "BFNLeftNavBarItem.h"

@implementation ZYMobCMSUitil

/*
 *
 * 设置navgactionitem leftbuttonitem 图标及显示主菜单
 * 必须实现 （showMaster：）方法
 *
 */
+ (void)setNavItem:(UIViewController *)viewObj
{
    UIButtonCustomized *leftBtn = [UIButtonCustomized buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 8, 28, 18);
    [leftBtn addTarget:self action:@selector(showMaster:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setAdditionalViewController:viewObj];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    viewObj.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
}
+ (void)showMaster:(UIButtonCustomized *)sender
{
    ZYMobCMSAppDelegate *delegate = (ZYMobCMSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [delegate showMaster];
}

+ (void)setBFNNavItemForReturn:(BFNBaseViewController *)viewObj
{
    ZYMobCMSAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    BFNLeftNavBarItem *leftBarItem = [[BFNLeftNavBarItem alloc]initWithFrame:CGRectMake(0,0,200,44)];
    UIImage *nImage = [UIImage imageNamed:@"return.png"];
    
    [leftBarItem setItemNormalImage:nImage selectedImage:nil title:viewObj.mainTitle tapItem:^{
        [viewObj.navigationController popViewControllerAnimated:YES];
        
        BFNBaseViewController *topVC = (BFNBaseViewController*)[(UINavigationController*)delegate.rootViewController.detailViewController topViewController];
        if (topVC.isSwipTurnOn) {
            delegate.rootViewController.openTouchRecieve = NO;
        }else{
            delegate.rootViewController.openTouchRecieve = YES;
        }
    }];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
    viewObj.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    delegate.rootViewController.openTouchRecieve = NO;
    [viewObj enableSwipRightToReturn];
}

+ (void)setBFNNavItemForMenu:(BFNBaseViewController *)viewObj
{
    BFNLeftNavBarItem *leftBarItem = [[BFNLeftNavBarItem alloc]initWithFrame:CGRectMake(0,0,200,44)];
    UIImage *nImage = [UIImage imageNamed:@"menu.png"];
    
    [leftBarItem setItemNormalImage:nImage selectedImage:nil title:viewObj.mainTitle tapItem:^{
        ZYMobCMSAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [delegate showMaster];
    }];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
    viewObj.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
}

+ (NSString*)replaceNBSP:(NSString *)sourceString
{    
    NSMutableString *newString = [NSMutableString stringWithString:sourceString];
    NSRange range = NSMakeRange(0, [newString length]);
    
    NSArray *checkArray = [NSArray arrayWithObjects:@"\\",@"\t",@"\r",@"&ldquo",@"&rdquo",@";",@"/",@"-",@"<em>",@"</em>",@"!",@"|", nil];
    
    for (int i=0 ; i<[checkArray count];i++) {
        [newString replaceOccurrencesOfString:[checkArray objectAtIndex:i] withString:@"" options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    NSArray *spaceArray = [NSArray arrayWithObjects:@"&nbsp",@"</br>",nil];
    for (int i=0 ; i<[spaceArray count];i++) {
        [newString replaceOccurrencesOfString:[spaceArray objectAtIndex:i] withString:@" " options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    NSArray *lineArray = [NSArray arrayWithObjects:@"<br>",nil];
    for (int i=0 ; i<[lineArray count];i++) {
        [newString replaceOccurrencesOfString:[lineArray objectAtIndex:i] withString:@"\n" options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    return newString;

}


@end
