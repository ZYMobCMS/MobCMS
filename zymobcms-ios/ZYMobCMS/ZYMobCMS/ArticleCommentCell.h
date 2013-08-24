//
//  ArticleCommentCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFAttributedView.h"

typedef void (^tapOnSupportBtn) (void);


@interface ArticleCommentCell : UITableViewCell
{
    BFAttributedView *commentContentView;
    UILabel *dateView;
    BFAttributedView *locationView;
    
    UIButton *supportBtn;
    UILabel  *supportLabel;
    
    tapOnSupportBtn  _tapOnSupportAction;

}
@property (nonatomic,retain)NSString *commentId;
@property (nonatomic,assign)BOOL isSupported;
@property (nonatomic,assign)ZYCommentType commentType;

- (void)setTapOnSupportAction:(tapOnSupportBtn)tapOnSupportAction;

- (void)setcontentDict:(NSDictionary*)contentDict;
+ (CGFloat)heightForContentDict:(NSDictionary*)contentDict forTable:(UITableView *)table;

@end
