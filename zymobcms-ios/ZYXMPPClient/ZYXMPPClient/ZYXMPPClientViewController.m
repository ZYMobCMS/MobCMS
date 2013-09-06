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
    [super dealloc];
}
- (IBAction)sendMessageAction:(id)sender {
    ZYXMPPUser *toUser = [[ZYXMPPUser alloc]init];
    toUser.jID = self.toUserTextField.text;
    ZYXMPPMessage *newMessage = [[ZYXMPPMessage alloc]init];
    newMessage.content = self.sendTextField.text;
    
    if (toUser.jID) {
        [xmppClient sendMessageToUser:toUser withContent:newMessage];
    }
}

- (IBAction)loginNow:(id)sender {
    
    xmppClient = [[ZYXMPPClient alloc]init];
    [xmppClient setNeedUseCustomHostAddress:YES];
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
        
    }];
    [xmppClient startClientWithJID:self.jIDTextField.text withPassword:self.passwordTextField.text];

}
@end
