//
//  BFNArticleViewController.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNBaseViewController.h"
#import "BFAttributedView.h"
#import "BFImageCache.h"
#import "ZYCommentBar.h"

#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"

@interface BFNArticleViewController : BFNBaseViewController<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate>
{
    UILabel *titleView;
    
    UILabel *dateView;
    UILabel *sourceView;
    
    UIImageView      *contentImageView;
    
//    UITextView       *contentTextView;
    BFAttributedView *contentTextView;
    
    UIScrollView     *scrollView;
    
    UILabel         *checkArticelBtn;
    UILabel         *likeLabel;
    
    
    ZYCommentBar    *commentBar;
    
    AdMoGoView *adView;
}
@property (nonatomic,retain)NSMutableDictionary *articleDict;
@property (nonatomic,retain)UIImageView      *contentImageView;

- (id)initWithBaseContentDict:(NSDictionary*)baseDict;
- (id)initWithArticleId:(NSString*)articleId;


@end
