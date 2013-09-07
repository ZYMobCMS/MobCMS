//
//  ZYPicturePreViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPicturePreViewController.h"
#import "ZYPictureCommentViewController.h"

@interface ZYPicturePreViewController ()

@end

@implementation ZYPicturePreViewController
@synthesize summaryText;
@synthesize pictureId,pictureTitle;
@synthesize isFavorited;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageString:(NSString *)imageString withSummaryText:(NSString *)summary
{
    if (self = [super initWithImageString:imageString]) {
        
        self.summaryText = summary;
    }
    return self;
}

- (void)dealloc
{
    self.pictureTitle = nil;
    self.summaryText = nil;
    self.pictureId = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //reset
    backScroller.frame = CGRectMake(backScroller.frame.origin.x,backScroller.frame.origin.y-44,backScroller.frame.size.width,backScroller.frame.size.height-44);
    saveBtn.frame = CGRectMake(saveBtn.frame.origin.x,saveBtn.frame.origin.y-44,saveBtn.frame.size.width,saveBtn.frame.size.height);
    closeBtn.frame = CGRectMake(closeBtn.frame.origin.x,closeBtn.frame.origin.y-44,closeBtn.frame.size.width,closeBtn.frame.size.height);
    pageControlView.frame = CGRectMake(pageControlView.frame.origin.x,pageControlView.frame.origin.y-44,pageControlView.frame.size.width,pageControlView.frame.size.height);
    
    summaryTextView = [[UITextView alloc]init];
    summaryTextView.frame = CGRectMake(20,0,self.view.frame.size.width-40,70);
    summaryTextView.backgroundColor = [UIColor clearColor];
    summaryTextView.textColor = [UIColor whiteColor];
    summaryTextView.editable = NO;
    summaryTextView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    summaryTextView.text = self.summaryText;
    [self.view addSubview:summaryTextView];
    [summaryTextView release];
    [summaryTextView scrollRectToVisible:CGRectMake(0,0,summaryTextView.frame.size.width,summaryTextView.frame.size.height) animated:YES];
    
    //收藏
    favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favBtn.frame = CGRectMake(saveBtn.frame.origin.x+saveBtn.frame.size.width+5,saveBtn.frame.origin.y,saveBtn.frame.size.width-4,saveBtn.frame.size.height-4);
    [favBtn addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    if (self.isFavorited) {
        [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
    }else{
        [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_no.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:favBtn];
    
    //跟贴
    ZYRightNavItem *rightNavButton = [[ZYRightNavItem alloc]initWithFrame:CGRectMake(80,0,80,30) withLeftIcon:[UIImage imageNamed:@"share_top.png"] withRightIcon:[UIImage imageNamed:@"comment_btn_normal.png"]];
    [rightNavButton setLeftItemAction:^{
        //设置微信图文分享你可以用下面两种方法
        //1.用微信分享应用类型，用户分享给好友，对方点击跳转到手机应用或者打开url页面。需要另外设置应用下载地址，否则点击朋友圈进入友盟主页
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        [UMSocialData defaultData].extConfig.appUrl = @"http://www.zyprosoft.com";//设置你应用的下载地址
        
        
        NSString *shareText = self.pictureTitle;    //分享内嵌文字
        if (self.summaryText.length>140) {
            shareText = [self.summaryText substringWithRange:NSMakeRange(0,140)];
        }
        NSString *firstImage = [[self.imgString componentsSeparatedByString:@"|"]objectAtIndex:0];
        UIImage *shareImage = [BFImageCache imageForUrl:firstImage];                   //分享内嵌图片
        
        //如果得到分享完成回调，需要传递delegate参数
        [UMSocialSnsService presentSnsIconSheetView:self appKey:useAppkey shareText:shareText shareImage:shareImage shareToSnsNames:nil delegate:nil];
    }];
    [rightNavButton setRightItemAction:^{
        [self commentListAction];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    [rightNavButton release];
    
    [self getPictureDetail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commentListAction
{
    if (pictureId) {
        ZYPictureCommentViewController  *commentVC = [[ZYPictureCommentViewController alloc]initWithArticleId:self.pictureId];
        commentVC.mainTitle = @"跟贴";
        [ZYMobCMSUitil setBFNNavItemForReturn:commentVC];
        [self.navigationController pushViewController:commentVC animated:YES];
        commentVC.commentBar.commentType = ZYCommentPicture;
        commentVC.commentBar.favoriteType = ZYFavoritePicture;
        [commentVC release];
    }
    
}

- (void)favoriteAction
{
    if (![ZYUserManager userIsLogined]) {
        ZYLoginViewController *loginVC = [[ZYLoginViewController alloc]init];
        loginVC.mainTitle = @"登录";
        [ZYMobCMSUitil setBFNNavItemForReturn:loginVC];
        [loginVC setSuccessLoginAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
        return;
    }

    if (!self.pictureId) {
        return;
    }
    
    if (isFavorited) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.pictureId forKey:@"pictureId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCancelFavoritePicture withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteSuccess:" withFaildRequestMethod:@"favoriteFaild:"];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.pictureId forKey:@"pictureId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoritePicture withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteSuccess:" withFaildRequestMethod:@"favoriteFaild:"];
    }
    
}
- (void)favoriteSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        NSLog(@"favoriteSuccess");
        if (isFavorited) {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
            self.isFavorited = NO;
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_no.png"] forState:UIControlStateNormal];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
            self.isFavorited = YES;
        }
    }else{
        NSString *msg = [resultDict objectForKey:@"msg"];
        if ([msg isEqualToString:@"已经收藏过该图片"]) {
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
            self.isFavorited = YES;
        }
        [SVProgressHUD showErrorWithStatus:msg];
    }
}
- (void)favoriteFaild:(NSDictionary*)resultDict
{
    [SVProgressHUD showErrorWithStatus:@"网络不给力啊"];
}

- (void)enableFavorite
{
    [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_no.png"] forState:UIControlStateNormal];
}
- (void)disableFavorite
{
    [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
}

- (void)getPictureDetail
{
    if (!self.pictureId) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.pictureId forKey:@"pictureId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypePictureDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getPictureDetailSuccess:" withFaildRequestMethod:@"getPictureDetailFaild:"];
}

- (void)getPictureDetailSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSLog(@"pictureDetail----->%@",resultDict);
                
        NSDictionary *item = [resultDict objectForKey:@"data"];
        if ([[item objectForKey:@"isFavorited"]boolValue]) {
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
            self.isFavorited = YES;
        }else{
            self.isFavorited = NO;
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_no.png"] forState:UIControlStateNormal];
        }
        //resetimageView
        self.imgString = [item objectForKey:@"images"];
        [self getAllImagesNow];
        
    }
}

- (void)getPictureDetailFaild:(NSDictionary*)resultDict
{
    
}


@end
