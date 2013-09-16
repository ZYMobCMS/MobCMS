//
//  ZYNewsDetailViewController.m
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-8.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYNewsDetailViewController.h"

@interface ZYNewsDetailViewController ()

@end

@implementation ZYNewsDetailViewController
@synthesize newsModel;

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
    [dataCenter dealloc];
    [super dealloc];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [dataCenter cancelAllRequestNow];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    dataCenter = [[ZYNewsDataCenter alloc]init];
    [dataCenter startGetNewsDetailWithArticleId:newsModel.articleId];
    [dataCenter setGetNewsDetailSuccessAction:^(ZYNewsModel *detailModel) {
        self.newsModel = detailModel;
        NSLog(@"self.news content --->%@",self.newsModel.content);
    }];
    [dataCenter setGetNewsDetailFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
