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
    
    xmppClient = [[ZYXMPPClient alloc]init];
    [xmppClient setNeedUseCustomHostAddress:YES];
    [xmppClient setJabbredServerAddress:@"172.16.28.45"];
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
    [xmppClient startClientWithJID:@"test@barfoomatomac-mini.local" withPassword:@"123"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_recievedTextView release];
    [_sendTextField release];
    [super dealloc];
}
- (IBAction)sendMessageAction:(id)sender {
    ZYXMPPUser *toUser = [[ZYXMPPUser alloc]init];
    toUser.jID = @"vincent@barfoomatomac-mini.local";
    ZYXMPPMessage *newMessage = [[ZYXMPPMessage alloc]init];
    newMessage.content = self.sendTextField.text;
    
    [xmppClient sendMessageToUser:toUser withContent:newMessage];
}
@end
