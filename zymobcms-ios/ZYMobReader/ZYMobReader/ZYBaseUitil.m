//
//  ZYBaseUitil.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseUitil.h"
#import "ZYMobReaderAppDelegate.h"

@implementation ZYBaseUitil
+ (void)rootNavPopViewController:(UIViewController*)destController
{
    ZYMobReaderAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    [appDelegate.rootNavController popDetailViewController:destController];

}
@end
