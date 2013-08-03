//
//  BFNClassifyCell.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-27.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"
#import "BFImageDownloader.h"

@interface BFNClassifyCell : UITableViewCell
{
    BFAttributedView *titleView;
    UIImageView      *contentImgView;
    UILabel          *sourceLabel;
    UILabel          *dataLabel;
    BFAttributedView *summaryView;
}
@property (nonatomic,retain)UIImageView      *contentImgView;
@property (nonatomic,retain)BFAttributedView *titleView;

- (void)setContent:(NSDictionary *)contentDict;
+ (CGFloat)heightWithContent:(NSDictionary*)contentDict forTableView:(UITableView*)table;

@end
