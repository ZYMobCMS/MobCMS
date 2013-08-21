//
//  ZYProductDetail_0_Control_Cell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZYProductDetail_0_ControllCellHeight 100

typedef void (^beginTapOnFavBtn) (void);
typedef void (^beginTapOnCommentBtn) (void);
@interface ZYProductDetail_0_Control_Cell : UITableViewCell
{
    UIButton *supportBtn;
    UILabel *supportLabel;
    
    UIButton *favBtn;
    UILabel *favLabel;

    beginTapOnFavBtn _beginFavAction;
    beginTapOnCommentBtn _beginCommentAction;
}
@property (nonatomic,retain)NSString *productId;
@property (nonatomic,assign)BOOL      isFavorited;

- (void)setTapBeginFavAction:(beginTapOnFavBtn)beginFavAction;
- (void)setTapBeginCommentAction:(beginTapOnCommentBtn)beginCommentAction;

- (void)setContentDict:(NSDictionary*)contentDict;

@end
