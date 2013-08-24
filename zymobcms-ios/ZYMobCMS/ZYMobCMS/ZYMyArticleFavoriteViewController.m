//
//  ZYMyArticleFavoriteViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-23.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMyArticleFavoriteViewController.h"

@interface ZYMyArticleFavoriteViewController ()

@end

@implementation ZYMyArticleFavoriteViewController

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
    self.segmentCtrl.hidden = YES;
    self.listTable.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44-35);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNewsList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:self.pageIndex] forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    
    self.requestFlag = [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserFavorite withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getNewsListSuccess:" withFaildRequestMethod:@"getNewsListFaild:"];
    
}

@end
