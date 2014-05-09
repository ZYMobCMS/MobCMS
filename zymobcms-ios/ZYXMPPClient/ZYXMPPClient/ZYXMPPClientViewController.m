//
//  ZYXMPPClientViewController.m
//  ZYXMPPClient
//
//  Created by barfoo2 on 13-9-5.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYXMPPClientViewController.h"

@interface ZYXMPPClientViewController ()

@end

@implementation ZYXMPPClientViewController
@synthesize xmppClient;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
       
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_recievedTextView release];
    [_sendTextField release];
    [_jIDTextField release];
    [_hostTextFiled release];
    [_passwordTextField release];
    [_toUserTextField release];
    [xmppClient release];
    [super dealloc];
}
- (IBAction)sendMessageAction:(id)sender {
    ZYXMPPUser *toUser = [[ZYXMPPUser alloc]init];
    toUser.jID = self.toUserTextField.text;
    ZYXMPPMessage *newMessage = [[ZYXMPPMessage alloc]init];
    newMessage.content = self.sendTextField.text;
    
    if (toUser.jID) {
        [xmppClient sendMessageToUser:toUser withContent:newMessage];
        NSMutableString *appendString = [NSMutableString stringWithString:self.recievedTextView.text];
        [appendString appendFormat:@"%@\n",newMessage.content];
        self.recievedTextView.text = appendString;
    }
}

- (IBAction)loginNow:(id)sender {
    
    xmppClient = [[ZYXMPPClient alloc]init];
    [xmppClient setNeedUseCustomHostAddress:YES];
    [xmppClient setNeedAutoJIDWithCustomHostName:YES];
    [xmppClient setJabbredServerAddress:self.hostTextFiled.text];
    
    [xmppClient setStartClientSuccessAction:^(NSString *successMsg) {
        NSLog(@"%@",successMsg);
        
    }];
    [xmppClient setStartClientFaildAction:^(NSString *faildMsg) {
        
        NSLog(@"%@",faildMsg);
    }];
    [xmppClient setDidRecievedMessage:^(ZYXMPPMessage *newMessage) {
        
        NSMutableString *appendString = [NSMutableString stringWithString:self.recievedTextView.text];
        [appendString appendFormat:@"%@\n",newMessage.content];
        self.recievedTextView.text = appendString;
        
        //程序运行在前台，消息正常显示
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
        {
            
        }else{//如果程序在后台运行，收到消息以通知类型来显示
            UILocalNotification *localNotification = [[UILocalNotification alloc] init];
            localNotification.alertAction = @"Ok";
            localNotification.alertBody = [NSString stringWithFormat:@"From: %@\n\n%@",newMessage.user,appendString];//通知主体
            localNotification.soundName = @"crunch.wav";//通知声音
            localNotification.applicationIconBadgeNumber = 1;//标记数
            [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];//发送通知
        }
        
    }];
    [xmppClient startClientWithJID:self.jIDTextField.text withPassword:self.passwordTextField.text];

}

- (IBAction)sendImageAction:(id)sender {
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"af.jpeg"], 0.5);
    [xmppClient sendFileWithData:imageData withFileName:@"af.jpeg" toJID:self.toUserTextField.text];
}

@end
