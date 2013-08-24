//
//  ZYLoginViewController.m
//  ZYMobCMSAdmin
//
//  Created by barfoo2 on 13-8-22.
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
    if (_loginSuccess) {
        [_loginSuccess release];
    }
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    userTagLabel = [[UILabel alloc]init];
    userTagLabel.text = @"用户名:";
    userTagLabel.frame = CGRectMake(50,100,70,30);
    [self.view addSubview:userTagLabel];
    [userTagLabel release];
    
    pwdTagLabel = [[UILabel alloc]init];
    pwdTagLabel.text = @"密码:";
    pwdTagLabel.frame = CGRectMake(50,130,70,30);
    [self.view addSubview:pwdTagLabel];
    [pwdTagLabel release];
    
    userTextField = [[UITextField alloc]init];
    userTextField.frame = CGRectMake(130,100,150,40);
    [self.view addSubview:userTextField];
    [userTextField release];
    
    pwdTextField = [[UITextField alloc]init];
    pwdTextField.frame = CGRectMake(130,130,150,40);
    [self.view addSubview:pwdTextField];
    [pwdTextField release];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(150,190,80,35);
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    
    [loginBtn addTarget:self action:@selector(startLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLoginSuccessAction:(LoginSuccessAction)loginSucessAction
{
    if (_loginSuccess) {
        [_loginSuccess release];
    }
    _loginSuccess = [loginSucessAction copy];
}

- (void)startLogin
{
    if (userTextField.text==nil||pwdTextField.text==nil) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:userTextField.text forKey:@"loginName"];
    [params setObject:pwdTextField.text forKey:@"password"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeAdminLogin withParams:params withHelperDelegate:self withSuccessRequestMethod:@"loginSuccess:" withFaildRequestMethod:@"loginFaild:"];
}
- (void)loginSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSDictionary *data = [resultDict objectForKey:@"data"];
        [ZYAdminManager shareManager].adminId = [data objectForKey:@"id"];
        [ZYAdminManager shareManager].adminPassword = [data objectForKey:@"password"];
        [ZYAdminManager shareManager].adminLoginName = [data objectForKey:@"login_name"];
        [ZYAdminManager shareManager].adminEmail = [data objectForKey:@"email"];
        
        if (_loginSuccess) {
            _loginSuccess();
        }
        
    }
}
- (void)loginFaild:(NSDictionary*)resultDict
{
    
}

@end
