//
//  ZYMobCMSAppDelegate.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-7-27.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMobCMSAppDelegate.h"

@implementation ZYMobCMSAppDelegate
@synthesize sMenuController;
@synthesize zMenuController;
@synthesize rootViewController;

- (void)dealloc
{
    [_window release];
    self.sMenuController = nil;
    self.bMenuController = nil;
    self.rootViewController = nil;
    [super dealloc];
}

- (void)showMaster
{
    [self.rootViewController setShowingMasterViewController:YES animated:YES completion:nil];
}

- (void)hiddenMaster
{
    [self.rootViewController setShowingMasterViewController:NO animated:YES completion:nil];
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    /*
     //如果你要处理自己的url，你可以把这个方法的实现，复制到你的代码中：
     
     if ([url.description hasPrefix:@"sina"]) {
     return (BOOL)[[UMSocialSnsService sharedInstance] performSelector:@selector(handleSinaSsoOpenURL:) withObject:url];
     }
     else if([url.description hasPrefix:@"wx"]){
     return [WXApi handleOpenURL:url delegate:(id <WXApiDelegate>)[UMSocialSnsService sharedInstance]];
     }
     */
    
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //打开调试log的开关
    [UMSocialData openLog:YES];
    //向微信注册
    [WXApi registerApp:@"wxd9a39c7122aa6516"];
    
    //设置友盟appkey
    [UMSocialData setAppKey:useAppkey];
    
    self.rootViewController = [[IRSlidingSplitViewController alloc]init];
    self.bMenuController = [[BFNMenuViewController alloc]init];
    self.rootViewController.masterViewController = self.bMenuController;
    [self.bMenuController tryGetNewApplicationRights];
    [self.window addSubview:self.rootViewController.view];
    
    [self.window makeKeyAndVisible];
    
    // 注册推送服务
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(
                                                                           UIRemoteNotificationTypeAlert |
                                                                           UIRemoteNotificationTypeBadge |
                                                                           UIRemoteNotificationTypeSound
                                                                           )];
    
    return YES;
}

#pragma mark - 推送通知
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"token===>>>%@", deviceToken);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:deviceToken forKey:@"token"];
    [params setObject:@"1" forKey:@"type"];
    //保存TOKEN
    if ([ZYUserManager getCurrentUserLoginName]) {
        [params setObject:[ZYUserManager getCurrentUserLoginName] forKey:@"loginName"];
    }else{
        [params setObject:@"" forKey:@"loginName"];
    }
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserSaveDeivceToken withParams:params withHelperDelegate:self withSuccessRequestMethod:@"saveTokenSuccess:" withFaildRequestMethod:@"saveTokenFaild:"];
    
}
- (void)saveTokenSuccess:(NSDictionary*)resultDict
{
    if ([[resultDict objectForKey:@"status"]boolValue]==NO) {
        NSString *msg = [resultDict objectForKey:@"msg"];
        
        NSLog(@"%@",msg);
    }
}
- (void)saveTokenFaild:(NSDictionary*)resultDict
{
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *str = [NSString stringWithFormat: @"Error: %@", error];
    NSLog(@"gettoken fail===>>>%@", str);
}


- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"push info recieved ------->%@",userInfo);
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
