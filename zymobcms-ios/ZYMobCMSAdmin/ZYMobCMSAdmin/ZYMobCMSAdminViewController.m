//
//  ZYMobCMSAdminViewController.m
//  ZYMobCMSAdmin
//
//  Created by barfoo2 on 13-8-22.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYMobCMSAdminViewController.h"

@interface ZYMobCMSAdminViewController ()

@end

@implementation ZYMobCMSAdminViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *titleTagLabel = [[UILabel alloc]init];
    titleTagLabel.text = @"标题:";
    titleTagLabel.frame = CGRectMake(35,40,65,25);
    [self.view addSubview:titleTagLabel];
    [titleTagLabel release];
    
    messageTitle = [[UITextField alloc]init];
    messageTitle.background = [UIImage imageNamed:@"input.png"];
    messageTitle.frame = CGRectMake(100,40,180,40);
    [self.view addSubview:messageTitle];
    [messageTitle release];
    
    UILabel *contentTagLabel = [[UILabel alloc]init];
    contentTagLabel.text = @"内容:";
    contentTagLabel.frame = CGRectMake(35,100,65,25);
    [self.view addSubview:contentTagLabel];
    [contentTagLabel release];
    
    messageContent = [[UITextField alloc]init];
    messageContent.background = [UIImage imageNamed:@"input.png"];
    messageContent.frame = CGRectMake(100,100,180,40);
    [self.view addSubview:messageContent];
    [messageContent release];
    
    UILabel *typeTagLabel = [[UILabel alloc]init];
    typeTagLabel.text = @"类型:";
    typeTagLabel.frame = CGRectMake(35,160,65,25);
    [self.view addSubview:typeTagLabel];
    [typeTagLabel release];
    
    messageType = [[UITextField alloc]init];
    messageType.background = [UIImage imageNamed:@"input.png"];
    messageType.frame = CGRectMake(100,160,180,40);
    [self.view addSubview:messageType];
    [messageType release];
    
    UILabel *idTagLabel = [[UILabel alloc]init];
    idTagLabel.text = @"数据Id:";
    idTagLabel.frame = CGRectMake(35,210,65,25);
    [self.view addSubview:idTagLabel];
    [idTagLabel release];
    
    messageId = [[UITextField alloc]init];
    messageId.background = [UIImage imageNamed:@"input.png"];
    messageId.frame = CGRectMake(100,210,180,40);
    [self.view addSubview:messageId];
    [messageId release];
    
    UILabel *destTagLabel = [[UILabel alloc]init];
    destTagLabel.text = @"目标用户:";
    destTagLabel.frame = CGRectMake(15,260,85,25);
    [self.view addSubview:destTagLabel];
    [destTagLabel release];
    
    destUserLoginName = [[UITextField alloc]init];
    destUserLoginName.background = [UIImage imageNamed:@"input.png"];
    destUserLoginName.frame = CGRectMake(100,260,180,40);
    [self.view addSubview:destUserLoginName];
    [destUserLoginName release];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(150,320,80,35);
    [loginBtn setTitle:@"发送" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(sendPushNoti) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendPushNoti
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *msgTitle = messageTitle.text? messageTitle.text:@"";
    NSString *msgContent = messageContent.text? messageContent.text:@"";
    NSString *msgType= messageType.text? messageType.text:@"";
    NSString *msgId = messageId.text? messageId.text:@"";
    NSString *msgDestUser = destUserLoginName.text? destUserLoginName.text:@"";

    [params setObject:msgTitle forKey:@"title"];
    [params setObject:msgContent forKey:@"msgContent"];
    [params setObject:msgType forKey:@"msgType"];
    [params setObject:msgId forKey:@"msgId"];
    [params setObject:msgDestUser forKey:@"destLoginName"];
    [params setObject:@"" forKey:@"destUserId"];
    [params setObject:[ZYAdminManager shareManager].adminLoginName forKey:@"adminLoginName"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeAdminSendIOSPush withParams:params withHelperDelegate:self withSuccessRequestMethod:@"sendPushNotiSucess:" withFaildRequestMethod:@"sendPushNotiFaild:"];
}

- (void)sendPushNotiSucess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if(status){
        
        NSString *msg = [resultDict objectForKey:@"data"];
        
        [SVProgressHUD showSuccessWithStatus:msg];
    }else{
        NSString *msg = [resultDict objectForKey:@"msg"];
        
        [SVProgressHUD showErrorWithStatus:msg];
    }
}

- (void)sendPushNotiFaild:(NSDictionary*)resultDict
{
    [SVProgressHUD showErrorWithStatus:@"网络不给力啊!"];
}


@end
