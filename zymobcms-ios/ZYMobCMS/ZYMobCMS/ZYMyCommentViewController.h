//
//  ZYMyCommentViewController.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-14.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "BFNBaseViewController.h"
#import "BFSegmentControl.h"

@interface ZYMyCommentViewController : ZYCommentViewController<BFSegmentControlDataSource>
{
    BFSegmentControl *segmentCtrl;
    NSMutableArray *segmentArray;
    ZYCommentType       currentRequestType;
}

@end
