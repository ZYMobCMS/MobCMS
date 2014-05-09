//
//  ZYXMPPClientViewController.h
//  ZYXMPPClient
//
//  Created by barfoo2 on 13-9-5.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXMPPClient.h"

@interface ZYXMPPClientViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextView *recievedTextView;
@property (retain, nonatomic) IBOutlet UITextField *sendTextField;
@property (retain, nonatomic) IBOutlet UITextField *jIDTextField;
@property (retain, nonatomic) IBOutlet UITextField *hostTextFiled;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UITextField *toUserTextField;
@property (retain,nonatomic)ZYXMPPClient *xmppClient;
- (IBAction)sendMessageAction:(id)sender;
- (IBAction)loginNow:(id)sender;
- (IBAction)sendImageAction:(id)sender;

@end
