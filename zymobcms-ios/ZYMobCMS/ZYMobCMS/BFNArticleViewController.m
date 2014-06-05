//
//  BFNArticleViewController.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNArticleViewController.h"
#import "BFNImagePreViewController.h"
#import "CustomTextView.h"
#import "BFNPreviewViewController.h"
#import "BFNBarButton.h"
#import "CommentListViewController.h"

#define Top_Margin 10
#define Left_Margin 10
#define Text_Text_Margin 10
#define Text_Image_Margin 20

#define TitleFontSize 20
#define DateFontSize 11
#define ContentFontSize 17
#define LikeFontSize 13

@interface BFNArticleViewController ()

@end

@implementation BFNArticleViewController
@synthesize articleDict;
@synthesize contentImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithBaseContentDict:(NSDictionary *)baseDict
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.articleDict = [[NSMutableDictionary alloc]initWithDictionary:baseDict];
        
//        NSLog(@"articleDict init --->%@",self.articleDict);

        
    }
    return self;
}
- (id)initWithArticleId:(NSString *)articleId
{
    if (self = [super init]) {
        
        self.articleDict = [[NSMutableDictionary alloc]init];
        [self loadArticleDetailWithId:articleId];
    }
    return self;
}

- (void)dealloc
{
    self.articleDict = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //MoGo
    adView = [[AdMoGoView alloc] initWithAppKey:MoGo_ID_IPhone
                                         adType:AdViewTypeNormalBanner                                adMoGoViewDelegate:self];
    adView.adWebBrowswerDelegate = self;
    adView.frame = CGRectMake(0.0,0, 320.0, 50.0);
    [self.view addSubview:adView];
    [adView release];
    
    CGRect   initRect = CGRectMake(0,50,self.view.frame.size.width-2*Left_Margin,1);
    //scroll
    scrollView = [[UIScrollView alloc]initWithFrame:initRect];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    //titile
    titleView = [[UILabel alloc]initWithFrame:initRect];
    titleView.font = [UIFont systemFontOfSize:TitleFontSize];
    titleView.textAlignment = UITextAlignmentLeft;
    titleView.numberOfLines = 0;
    [scrollView addSubview:titleView];
    [titleView release];
    
    //date
    dateView = [[UILabel alloc]initWithFrame:initRect];
    dateView.backgroundColor = [UIColor clearColor];
    dateView.textColor = [BFUitils rgbColor:158 green:158 blue:158];
    dateView.font = [UIFont systemFontOfSize:DateFontSize];
    [scrollView addSubview:dateView];
    [dateView release];
    
    //source
    sourceView = [[UILabel alloc]initWithFrame:initRect];
    sourceView.backgroundColor = [UIColor clearColor];
    sourceView.font = [UIFont systemFontOfSize:DateFontSize];
    sourceView.textColor = [BFUitils rgbColor:158 green:158 blue:158];
    [scrollView addSubview:sourceView];
    [sourceView release];
    
    //
    checkArticelBtn = [[UILabel alloc]init];
    checkArticelBtn.backgroundColor = [UIColor clearColor];
    CGSize checkSize = [@"查看原文" sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(100,9999) lineBreakMode:UILineBreakModeCharacterWrap];
    checkArticelBtn.text = @"查看原文";
    checkArticelBtn.font = [UIFont systemFontOfSize:DateFontSize];
    checkArticelBtn.textColor = [BFUitils rgbColor:54 green:108 blue:0];
    checkArticelBtn.frame = CGRectMake(0,0,checkSize.width,checkSize.height);
    UITapGestureRecognizer *checkR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkAticleAction)];
    [checkArticelBtn addGestureRecognizer:checkR];
    [checkR release];
    checkArticelBtn.userInteractionEnabled = YES;
    [scrollView addSubview:checkArticelBtn];
    
    //
    likeLabel = [[UILabel alloc]init];
    likeLabel.frame = CGRectMake(0,0,1,1);
    likeLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fav_bg.png"]];
    likeLabel.font = [UIFont systemFontOfSize:LikeFontSize];
    likeLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:likeLabel];
    likeLabel.textColor = [UIColor whiteColor];
    [likeLabel release];
    
    contentImageView = [[UIImageView alloc]initWithFrame:initRect];
    contentImageView.hidden = YES;
    contentImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnImageView)];
    [contentImageView addGestureRecognizer:tapR];
    [tapR release];
    [scrollView addSubview:contentImageView];
    [contentImageView release];
    
    //text content
    contentTextView = [[BFAttributedView alloc]initWithFrame:initRect];
    contentTextView.textDescriptor.fontSize = ContentFontSize;
    contentTextView.textDescriptor.textColor = [BFUitils rgbColor:12 green:12 blue:12];
    contentTextView.textDescriptor.lineSpace = 5.f;
    [scrollView addSubview:contentTextView];
    [contentTextView release];
    
    //add commentBAr
    CGFloat yDetal = IS_IOS_7? 20.f:0;
    commentBar = [[ZYCommentBar alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-106*2/6-44-yDetal,self.view.frame.size.width, 106*2/6) withBeginAction:^{
        
        //
        if (![ZYUserManager userIsLogined]) {
            ZYLoginViewController *loginVC = [[ZYLoginViewController alloc]init];
            loginVC.mainTitle = @"登录";
            [ZYMobCMSUitil setBFNNavItemForReturn:loginVC];
            [loginVC setSuccessLoginAction:^{
                [loginVC.navigationController popViewControllerAnimated:YES];
            }];
            [self.navigationController pushViewController:loginVC animated:YES];
            [loginVC release];
            [commentBar commentReset];

        }else{
            UIControl *whiteBoard = [[UIControl alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
            whiteBoard.alpha = 0.1;
            whiteBoard.tag = 111222;
            [whiteBoard addTarget:self action:@selector(whilteBoardTouchDown) forControlEvents:UIControlEventTouchDown];
            [self.view insertSubview:whiteBoard belowSubview:commentBar];
            [whiteBoard release];
        }
        
        
    } withEndAction:^{
        
        if ([self.view viewWithTag:111222]) {
            [[self.view viewWithTag:111222]removeFromSuperview];
        }
    }];
    commentBar.layer.cornerRadius = 3.0f;
    commentBar.layer.borderWidth = 2.0f;
    commentBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    commentBar.layer.shadowOpacity = 0.6;
    commentBar.layer.shadowOffset = CGSizeMake(3.0f,-2.0f);
    [commentBar setFavoriteState:[[self.articleDict objectForKey:@"isFavorited"]boolValue]];
    [self.view addSubview:commentBar];
    [commentBar release];
    
    //跟贴
    ZYRightNavItem *rightNavButton = [[ZYRightNavItem alloc]initWithFrame:CGRectMake(80,0,80,30) withLeftIcon:[UIImage imageNamed:@"share_top.png"] withRightIcon:[UIImage imageNamed:@"comment_btn_normal.png"]];
    [rightNavButton setLeftItemAction:^{
        //设置微信图文分享你可以用下面两种方法
        //1.用微信分享应用类型，用户分享给好友，对方点击跳转到手机应用或者打开url页面。需要另外设置应用下载地址，否则点击朋友圈进入友盟主页
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        
        NSString *shareText = [self.articleDict objectForKey:@"title"];    //分享内嵌文字
        NSString *firstImage = [[[self.articleDict objectForKey:@"images"] componentsSeparatedByString:@"|"]objectAtIndex:0];
        UIImage *shareImage = [BFImageCache imageForUrl:firstImage];                   //分享内嵌图片
        
        //如果得到分享完成回调，需要设置delegate为self
        [UMSocialSnsService presentSnsIconSheetView:self appKey:UmengAppKey shareText:shareText shareImage:shareImage shareToSnsNames:nil delegate:self];
    }];
    [rightNavButton setRightItemAction:^{
        [self commentListAction];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    [rightNavButton release];
    
    NSString *articalId = [self.articleDict objectForKey:@"id"];
    if (articalId) {
        commentBar.articleId = articalId;
        [self setBaseContentDict:self.articleDict isShowDetail:NO];
        [self loadArticleDetailWithId:articalId];
    }

}

- (void)whilteBoardTouchDown
{
    [commentBar commentReset];
}

- (void)commentListAction
{
    if (![self.articleDict objectForKey:@"id"]) {
        return;
    }
    CommentListViewController *commentVC = [[CommentListViewController alloc]initWithArticleId:[self.articleDict objectForKey:@"id"]];
    commentVC.mainTitle = @"跟贴";
    [ZYMobCMSUitil setBFNNavItemForReturn:commentVC];
    [self.navigationController pushViewController:commentVC animated:YES];
    commentVC.commentBar.favoriteType = ZYFavoriteArticle;
    commentVC.commentBar.commentType = ZYCommentArticle;
    [commentVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置内容
- (void)setBaseContentDict:(NSDictionary *)baseDict isShowDetail:(BOOL)state
{
    //
    NSString *title = [baseDict objectForKey:@"title"];
    NSString *content = state? [ZYMobCMSUitil replaceNBSP:[baseDict objectForKey:@"content"]]:[baseDict objectForKey:@"summary"];
    
    NSString *date = [articleDict objectForKey:@"publish_time"];
    NSString *source = [articleDict objectForKey:@"source"];
    NSString *favCount = [articleDict objectForKey:@"favorite_count"];
    
    NSString *image = [baseDict objectForKey:@"images"];
    
    NSArray *imageArray = [image componentsSeparatedByString:@"|"];
    image = [imageArray objectAtIndex:0];
    
    //布局
    CGFloat contentWidth = self.view.frame.size.width-2*Left_Margin;
    CGFloat originY = Top_Margin;
    
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:TitleFontSize] constrainedToSize:CGSizeMake(contentWidth,99999) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize imageSize = self.contentImageView.image.size;
    
    CGRect titleRect = CGRectMake(Left_Margin,Top_Margin,contentWidth,titleSize.height);
    originY = titleRect.origin.y+titleRect.size.height+Text_Text_Margin;
    titleView.frame = titleRect;
    titleView.text = title;
    
    CGSize dateSize = [date sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake((contentWidth-Text_Text_Margin)/2,99999) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect dateRect = CGRectMake(Left_Margin, originY, dateSize.width, dateSize.height);

    CGSize sourceSize = [source sizeWithFont:[UIFont systemFontOfSize:DateFontSize] constrainedToSize:CGSizeMake(contentWidth, 99999) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect sourceRect = CGRectZero;
    
    //是否需要分两行
    if (dateSize.width+sourceSize.width+Text_Text_Margin+checkArticelBtn.frame.size.width+3*Text_Text_Margin > contentWidth ) {
        
        //两行
        sourceRect = CGRectMake(Left_Margin,originY,sourceSize.width,sourceSize.height);
        
        checkArticelBtn.frame = CGRectMake(sourceRect.origin.x+sourceRect.size.width+3*Text_Text_Margin,originY,checkArticelBtn.frame.size.width,checkArticelBtn.frame.size.height);

        originY = dateRect.origin.y+dateRect.size.height + Text_Text_Margin;
        
        dateRect = CGRectMake(Left_Margin,originY,dateSize.width,dateSize.height);
        
        originY = dateRect.origin.y+dateRect.size.height + Text_Image_Margin;


    }else{
        
        //一行
        sourceRect = CGRectMake(Left_Margin,originY,sourceSize.width,sourceSize.height);
        
        dateRect = CGRectMake(sourceRect.origin.x+sourceRect.size.width+Text_Text_Margin,originY,dateSize.width,dateSize.height);
        
        checkArticelBtn.frame = CGRectMake(dateRect.origin.x+dateRect.size.width+3*Text_Text_Margin,originY,checkArticelBtn.frame.size.width,checkArticelBtn.frame.size.height);

        originY = sourceRect.origin.y+sourceRect.size.height+Text_Image_Margin;
    }
    sourceView.frame = sourceRect;
    dateView.frame = dateRect;
    sourceView.text = source;
    dateView.text = date;
    
    //图片
    CGRect imageRect = CGRectZero;
    if ([BFImageCache imageForUrl:image]!=nil) {
        
        imageSize = [BFImageCache imageForUrl:image].size;
        if (contentWidth > imageSize.width) {
            imageRect = CGRectMake(Left_Margin+(contentWidth-imageSize.width)/2,originY,imageSize.width,imageSize.height);

        }else{
            imageRect = CGRectMake(Left_Margin,originY,contentWidth,imageSize.height*(contentWidth/imageSize.width));
        }
        contentImageView.frame = imageRect;
        contentImageView.image = [BFImageCache imageForUrl:image];
        contentImageView.hidden = NO;
    
        originY = imageRect.origin.y+ imageRect.size.height + Text_Text_Margin;
        
    }else{
        contentImageView.hidden = YES;
    }
    
    //like
    NSString *favString = [NSString stringWithFormat:@"%@喜欢",favCount];
    CGSize favSize = [favString sizeWithFont:[UIFont systemFontOfSize:LikeFontSize] constrainedToSize:CGSizeMake(self.view.frame.size.width,99999) lineBreakMode:UILineBreakModeCharacterWrap];
    likeLabel.frame = CGRectMake(self.view.frame.size.width-favSize.width-10,60, favSize.width+10,favSize.height);
    likeLabel.text = favString;
    
    //内容
    [contentTextView setContentText:content];
    
    //计算高度
    CGFloat contentHeight = [BFAttributedView getAttributedContentHeight:contentTextView.contentAttributedString  withWdith:contentWidth];
    CGRect contentRect = CGRectMake(Left_Margin,originY,contentWidth,contentHeight);
    contentTextView.frame = contentRect;
    NSLog(@"contentHeight:%f",contentHeight);
    
    originY = contentTextView.frame.origin.y+contentTextView.frame.size.height+Text_Text_Margin;
    
    //重设scroll content
    scrollView.frame = CGRectMake(0,50,self.view.frame.size.width,self.view.frame.size.height-50);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width,originY+106*2/6);
    
    //是否可以收藏
    if ([self.articleDict.allKeys containsObject:@"isFavorite"]) {
        
        BOOL isFavorited = [[self.articleDict objectForKey:@"isFavorite"]boolValue];
        
        commentBar.isFavorited = isFavorited;
    }
}

#pragma mark - 获取文章详情 
- (void)getArticleDetailDataSuccess:(NSDictionary*)data
{
    BOOL status = [[data objectForKey:@"status"] boolValue];
    
    if (status) {
        
        [self.articleDict removeAllObjects];
        [self.articleDict addEntriesFromDictionary:[data objectForKey:@"data"]];
        
//        NSLog(@"articleDict --->%@",self.articleDict);

        [self setBaseContentDict:[data objectForKey:@"data"] isShowDetail:YES];
        [commentBar setFavoriteState:[[[data objectForKey:@"data"]objectForKey:@"isFavorite"]boolValue]];
        
    }
    [self stopLoading];
}
- (void)getArticleDetailDataFaild:(NSDictionary*)data
{
    //    NSLog(@"faild data:%@",data);
    [self stopLoading];
}

- (void)loadArticleDetailWithId:(NSString *)articleId
{
    if (!articleId) {
        return;
    }
    //set params
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setObject:articleId forKey:@"articleId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeArticleDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getArticleDetailDataSuccess:" withFaildRequestMethod:@"getArticleDetailDataFaild:"];
}

#pragma mark - tap on image
- (void)tapOnImageView
{
    NSString *imageString = [self.articleDict objectForKey:@"images"];

    BFNImagePreViewController *imagePreView = [[BFNImagePreViewController alloc]initWithImageString:imageString];
    imagePreView.superVC = self;
    [self presentModalViewController:imagePreView animated:YES];
    [imagePreView getAllImagesNow];
    [imagePreView release];
}

- (void)checkAticleAction
{
    if ([self.articleDict objectForKey:@"links"]) {
        
        BFNPreviewViewController *preVC = [[BFNPreviewViewController alloc]init];
        preVC.url = [self.articleDict objectForKey:@"links"];
        preVC.mainTitle = @"查看原文";
        preVC.isLoadUrl = YES;
        [ZYMobCMSUitil setBFNNavItemForReturn:preVC];
        [self.navigationController pushViewController:preVC animated:YES];
        [preVC release];
    }
}

#pragma mark -
#pragma mark AdMoGoDelegate delegate
/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingModalView{
    return self;
}



/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告开始请求回调");
}
/**
 * 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告接收成功回调");
}
/**
 * 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error{
    NSLog(@"广告接收失败回调");
}
/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView{
    NSLog(@"点击广告回调");
}
/**
 *You can get notified when the user delete the ad
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告关闭回调");
}

#pragma mark -
#pragma mark AdMoGoWebBrowserControllerUserDelegate delegate

/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear{
    NSLog(@"浏览器将要展示");
}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear{
    NSLog(@"浏览器已经展示");
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed{
    NSLog(@"浏览器将要关闭");
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed{
    NSLog(@"浏览器已经关闭");
}
/**
 *直接下载类广告 是否弹出Alert确认
 */
-(BOOL)shouldAlertQAView:(UIAlertView *)alertView{
    return NO;
}

- (void)webBrowserShare:(NSString *)url{
    
}

@end
