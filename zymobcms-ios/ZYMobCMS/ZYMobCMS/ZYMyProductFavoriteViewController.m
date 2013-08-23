//
//  ZYMyProductFavoriteViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-23.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMyProductFavoriteViewController.h"

@interface ZYMyProductFavoriteViewController ()

@end

@implementation ZYMyProductFavoriteViewController

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
    listTable.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44-45);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getProductList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:10] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserProductFavoriteList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getProductListSuccess:" withFaildRequestMethod:@"getProductListFaild:"];
}

@end
