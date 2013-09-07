//
//  ZYLoginViewController.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYLoginViewController.h"

@interface ZYLoginViewController ()

@end

@implementation ZYLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [userCenter release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    loginNameField = [[UITextField alloc]init];
    loginNameField.borderStyle = UITextBorderStyleRoundedRect;
    loginNameField.frame = CGRectMake(50,20,220,40);
    [self.view addSubview:loginNameField];
    [loginNameField release];
    
    passwordField = [[UITextField alloc]init];
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.frame = CGRectMake(50,70,220,60);
    [self.view addSubview:passwordField];
    [passwordField release];
    
    userCenter = [[ZYUserDataCenter alloc]init];
    [userCenter setLoginSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];

    }];
    [userCenter setLoginFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
    [userCenter setRigistFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showSuccessWithStatus:errMsg];
    }];
    [userCenter setRigistSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    
    BFNBarButton *loginBtn = [[BFNBarButton alloc]initWithFrame:CGRectMake(50,160,60,35) withImage:nil withTapOnBarButton:^(BFNBarButton *sender) {
        [userCenter startLoginWithName:loginNameField.text withPassword:passwordField.text];
        [loginNameField resignFirstResponder];
        [passwordField resignFirstResponder];
    }];
    [self.view addSubview:loginBtn];
    loginBtn.backgroundColor = [UIColor blueColor];
    [loginBtn setTitle:@"登录"];
    [loginBtn release];
    
    BFNBarButton *rigistBtn = [[BFNBarButton alloc]initWithFrame:CGRectMake(150,160,60,35) withImage:nil withTapOnBarButton:^(BFNBarButton *sender) {
        [userCenter startRigistWithName:loginNameField.text withPassword:passwordField.text];
        [loginNameField resignFirstResponder];
        [passwordField resignFirstResponder];
    }];
    [self.view addSubview:rigistBtn];
    rigistBtn.backgroundColor = [UIColor redColor];
    [rigistBtn setTitle:@"注册"];
    [rigistBtn release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
