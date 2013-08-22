//
//  ZYLoginViewController.h
//  ZYMobCMSAdmin
//
//  Created by barfoo2 on 13-8-22.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LoginSuccessAction) (void);
@interface ZYLoginViewController : UIViewController
{
    UILabel *userTagLabel;
    UILabel *pwdTagLabel;
    UITextField *userTextField;
    UITextField *pwdTextField;
    
    UIButton *loginBtn;
    
    LoginSuccessAction _loginSuccess;
}

- (void)setLoginSuccessAction:(LoginSuccessAction)loginSucessAction;

@end
