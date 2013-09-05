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
@property (retain,nonatomic)ZYXMPPClient *xmppClient;
- (IBAction)sendMessageAction:(id)sender;

@end
