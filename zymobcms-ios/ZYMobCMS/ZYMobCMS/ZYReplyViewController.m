//
//  ZYReplyViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYReplyViewController.h"

@interface ZYReplyViewController ()

@end

@implementation ZYReplyViewController
@synthesize replyTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *backImgView = [[UIImageView alloc]init];
    backImgView.image = [UIImage imageNamed:@"input_bg.png"];
    backImgView.frame = CGRectMake(10,10,self.view.frame.size.width-20,240-20);
    [self.view addSubview:backImgView];
    [backImgView release];
    
    replyTextView = [[UITextView alloc]init];
    replyTextView.backgroundColor = [UIColor clearColor];
    replyTextView.frame = CGRectMake(25,20,self.view.frame.size.width-50,190);
    [self.view addSubview:replyTextView];
    [replyTextView release];
        
    //跟贴
    oveaSeaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oveaSeaBtn.frame = CGRectMake(0,0,60,30);
    oveaSeaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [oveaSeaBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"top_button.png"] forState:UIControlStateNormal];
    [oveaSeaBtn setTitle:@"发送" forState:UIControlStateNormal];
    [oveaSeaBtn addTarget:self action:@selector(sendReplyAction) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:oveaSeaBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    [replyTextView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeReplyText:) name:UITextViewTextDidChangeNotification object:nil];
    oveaSeaBtn.enabled = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendReplyAction
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:replyTextView.text forKey:@"content"];
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeReply  withParams:params withHelperDelegate:self withSuccessRequestMethod:@"sendReplySucess:" withFaildRequestMethod:@"sendReplyFaild:"];
}
- (void)sendReplySucess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        [SVProgressHUD showSuccessWithStatus:@"反馈成功，感谢您给我们宝贵的意见"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"反馈失败，服务器不给力了"];

    }
    
}
- (void)sendReplyFaild:(NSDictionary*)resultDict
{
    [SVProgressHUD showErrorWithStatus:@"网络不给力"];
}

- (void)observeReplyText:(NSNotification*)noti
{
    BOOL notAllSpace = NO;
    for (int i=0;i<replyTextView.text.length;i++) {
        NSString *subString = [replyTextView.text substringWithRange:NSMakeRange(i,1)];
        if (![subString isEqualToString:@" "]) {
            notAllSpace = YES;
            break;
        }
    }
    if (replyTextView.text.length>0 && notAllSpace) {
        [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"search_red.png"] forState:UIControlStateNormal];
        oveaSeaBtn.enabled = YES;
        [oveaSeaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"top_button.png"] forState:UIControlStateNormal];
        [oveaSeaBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        oveaSeaBtn.enabled = NO;
    }
}

@end
