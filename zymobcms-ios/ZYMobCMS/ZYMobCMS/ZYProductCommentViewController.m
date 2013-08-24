//
//  ZYProductCommentViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYProductCommentViewController.h"

@interface ZYProductCommentViewController ()

@end

@implementation ZYProductCommentViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCommentList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.articleId forKey:@"productId"];
    [params setObject:[NSNumber numberWithInt:self.pageIndex]  forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductCommentList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getCommentListSuccess:" withFaildRequestMethod:@"getCommentListFaild:"];
}

@end
