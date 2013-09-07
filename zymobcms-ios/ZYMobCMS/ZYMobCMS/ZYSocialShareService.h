//
//  ZYSocialShareService.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-25.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "UMSocialSnsService.h"

typedef void (^finishShareAction) (void);

@interface ZYSocialShareService : UMSocialSnsService<UMSocialUIDelegate>
{
    finishShareAction _finshAction;
}

+ (ZYSocialShareService*)shareServcie;

- (void)startShareWithText:(NSString*)content withImage:(UIImage*)contentImage forViewController:(UIViewController*)viewController withfinishShareAction:(finishShareAction)finshAction;


@end
