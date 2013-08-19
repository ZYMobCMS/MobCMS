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
    UIButton   *favBtn;
}

@property (nonatomic,retain)NSString *summaryText;
@property (nonatomic,retain)NSString *pictureId;
@property (nonatomic,assign)BOOL isFavorited;

- (id)initWithImageString:(NSString *)imageString withSummaryText:(NSString*)summary;

@end
