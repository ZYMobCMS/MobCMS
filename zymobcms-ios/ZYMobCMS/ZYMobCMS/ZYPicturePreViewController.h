//
//  ZYPicturePreViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "BFNImagePreViewController.h"

@interface ZYPicturePreViewController : BFNImagePreViewController
{
    UITextView *summaryTextView;
}
@property (nonatomic,retain)NSString *summaryText;

- (id)initWithImageString:(NSString *)imageString withSummaryText:(NSString*)summary;

@end
