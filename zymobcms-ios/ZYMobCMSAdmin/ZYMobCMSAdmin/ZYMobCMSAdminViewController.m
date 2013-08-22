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
    titleTagLabel.frame = CGRectMake(40,40,80,40);
    [self.view addSubview:titleTagLabel];
    [titleTagLabel release];
    
    messageTitle = [[UITextField alloc]init];
    messageTitle.frame = CGRectMake(90,40,150,40);
    [self.view addSubview:messageTitle];
    [messageTitle release];
    
    UILabel *contentTagLabel = [[UILabel alloc]init];
    contentTagLabel.text = @"内容:";
    contentTagLabel.frame = CGRectMake(40,65,80,40);
    [self.view addSubview:contentTagLabel];
    [contentTagLabel release];
    
    messageContent = [[UITextField alloc]init];
    messageContent.frame = CGRectMake(90,55,150,40);
    [self.view addSubview:messageContent];
    [messageContent release];
    
    UILabel *typeTagLabel = [[UILabel alloc]init];
    typeTagLabel.text = @"类型:";
    typeTagLabel.frame = CGRectMake(40,135,80,40);
    [self.view addSubview:typeTagLabel];
    [typeTagLabel release];
    
    messageType = [[UITextField alloc]init];
    messageType.frame = CGRectMake(90,115,150,40);
    [self.view addSubview:messageType];
    [messageType release];
    
    UILabel *idTagLabel = [[UILabel alloc]init];
    idTagLabel.text = @"数据Id:";
    idTagLabel.frame = CGRectMake(40,170,80,40);
    [self.view addSubview:idTagLabel];
    [idTagLabel release];
    
    messageId = [[UITextField alloc]init];
    messageId.frame = CGRectMake(90,170,150,40);
    [self.view addSubview:messageId];
    [messageId release];
    
    UILabel *destTagLabel = [[UILabel alloc]init];
    destTagLabel.text = @"目标用户:";
    destTagLabel.frame = CGRectMake(40,220,80,40);
    [self.view addSubview:destTagLabel];
    [destTagLabel release];
    
    destUserLoginName = [[UITextField alloc]init];
    destUserLoginName.frame = CGRectMake(90,220,150,40);
    [self.view addSubview:destUserLoginName];
    [destUserLoginName release];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(150,280,80,35);
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
    [params setObject:messageTitle.text forKey:@"title"];
    [params setObject:messageContent.text forKey:@"msgContent"];
    [params setObject:messageType.text forKey:@"msgType"];
    [params setObject:messageId.text forKey:@"msgId"];
    [params setObject:destUserLoginName.text forKey:@"destLoginName"];
    [params setObject:@"" forKey:@"destUserId"];
    [params setObject:[ZYAdminManager shareManager].adminLoginName forKey:@"adminLoginName"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeAdminSendIOSPush withParams:params withHelperDelegate:self withSuccessRequestMethod:@"sendPushNotiSucess:" withFaildRequestMethod:@"sendPushNotiFaild:"];
}

- (void)sendPushNotiSucess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if(!status){
        
        NSString *msg = [resultDict objectForKey:@"msg"];
        
        [SVProgressHUD showErrorWithStatus:msg];
    }
}

- (void)sendPushNotiFaild:(NSDictionary*)resultDict
{
    
}


@end
