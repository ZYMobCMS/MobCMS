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
@synthesize pictureId;
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
    [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_no.png"] forState:UIControlStateNormal];
    [self.view addSubview:favBtn];
    
    //跟贴
    UIButton *oveaSeaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oveaSeaBtn.frame = CGRectMake(0,0,30,30);
    oveaSeaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [oveaSeaBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"comment_btn_normal.png"] forState:UIControlStateNormal];
    [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"commnet_btn_selected.png"] forState:UIControlStateSelected];
    [oveaSeaBtn addTarget:self action:@selector(commentListAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:oveaSeaBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
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

    if (isFavorited) {
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.pictureId forKey:@"pictureId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoritePicture withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteSuccess:" withFaildRequestMethod:@"favoriteFaild:"];
}
- (void)favoriteSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        NSLog(@"favoriteSuccess");
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        self.isFavorited = YES;
        [self disableFavorite];
        
    }else{
        NSString *msg = [resultDict objectForKey:@"msg"];
        [SVProgressHUD showErrorWithStatus:msg];
        self.isFavorited = NO;
        [self enableFavorite];
    }
}
- (void)favoriteFaild:(NSDictionary*)resultDict
{
    [SVProgressHUD showErrorWithStatus:@"网络链接失败，请检查网络"];
    self.isFavorited = NO;
    [self enableFavorite];
}

- (void)enableFavorite
{
    [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_no.png"] forState:UIControlStateNormal];
}
- (void)disableFavorite
{
    [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
}


@end
