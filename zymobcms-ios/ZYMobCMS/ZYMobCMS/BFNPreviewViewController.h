//
//  BFNPreviewViewController.h
//  PPFIphone
//
//  Created by li sha on 13-6-26.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChromeProgressBar.h"
#import "IMTWebView.h"

@interface BFNPreviewViewController : BFNBaseViewController<IMTWebViewProgressDelegate,UIWebViewDelegate>
{
    ChromeProgressBar *chromeBar;
    IMTWebView *detailWebView;
    NSString *webRequestFlag;
    UIButton *forwardBtn;
    UIButton *backBtn;
    UIButton *refreshBtn;
    NSString *contentString;
    BOOL onFirstPage;
}

@property (retain, nonatomic) NSURLRequest *webRequest;
@property (copy, nonatomic) NSString *webFileName;
@property (assign, nonatomic) NSString *url;
@property (assign, nonatomic) NSString *siteName;
@property BOOL isLoadUrl;

@end
