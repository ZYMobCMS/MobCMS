//
//  ZYPictureCommentViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPictureCommentViewController.h"

@interface ZYPictureCommentViewController ()

@end

@implementation ZYPictureCommentViewController

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
    [params setObject:self.articleId forKey:@"pictureId"];
    [params setObject:[NSNumber numberWithInt:self.pageIndex]  forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureCommentList withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getCommentListSuccess:" withFaildRequestMethod:@"getCommentListFaild:"];
}

@end
