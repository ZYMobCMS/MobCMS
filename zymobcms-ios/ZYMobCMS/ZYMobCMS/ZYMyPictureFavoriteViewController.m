//
//  ZYMyPictureFavoriteViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-23.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMyPictureFavoriteViewController.h"

@interface ZYMyPictureFavoriteViewController ()

@end

@implementation ZYMyPictureFavoriteViewController

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
    listTable.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44-35);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPictureList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:PageSize]  forKey:@"pageSize"];
    [params setObject:[NSNumber  numberWithInt:pageIndex] forKey:@"pageIndex"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeUserPictureFavoriteList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureListSuccess:" withFaildRequestMethod:@"getPictureListFaild:"];
}

@end
