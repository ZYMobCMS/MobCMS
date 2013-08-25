//
//  ZYSocialShareService.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-25.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYSocialShareService.h"

static ZYSocialShareService *zysocialInstance = nil;

@implementation ZYSocialShareService

+ (ZYSocialShareService*)shareServcie
{
    @synchronized(self){
        if (!zysocialInstance) {
            zysocialInstance = [[self alloc]init];
        }
    }
    return zysocialInstance;
}

- (void)startShareWithText:(NSString *)content withImage:(UIImage *)contentImage forViewController:(UIViewController *)viewController withfinishShareAction:(finishShareAction)finshAction
{
    if (_finshAction) {
        [_finshAction release];
    }
    _finshAction = [finshAction copy];
    
    //设置微信图文分享你可以用下面两种方法
    //1.用微信分享应用类型，用户分享给好友，对方点击跳转到手机应用或者打开url页面。需要另外设置应用下载地址，否则点击朋友圈进入友盟主页
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialData defaultData].extConfig.appUrl = @"http://www.zyprosoft.com";//设置你应用的下载地址
    
    
    UIImage *shareImage = contentImage;       //分享内嵌图片
    
    //如果得到分享完成回调，需要传递delegate参数
    [UMSocialSnsService presentSnsIconSheetView:viewController appKey:useAppkey shareText:content shareImage:shareImage shareToSnsNames:nil delegate:self];
    
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (_finshAction) {
        _finshAction();
    }
}

- (void)dealloc
{
    if (_finshAction) {
        [_finshAction release];
    }
    [super dealloc];
}
@end
