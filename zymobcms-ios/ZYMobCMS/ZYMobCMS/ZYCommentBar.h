//
//  ZYCommentBar.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^inputBeginAction) (void);
typedef void (^inputEndAction) (void);

typedef enum {
    
    ZYCommentArticle = 0,
    ZYCommentPicture,
    ZYCommentProduct,
    
}ZYCommentType;

typedef enum {
    
    ZYFavoriteArticle = 0,
    ZYFavoritePicture,
    ZYFavoriteProduct,
    
}ZYFavoriteType;

@interface ZYCommentBar : UIView<UITextViewDelegate>
{
    UIImageView *backgroundView;
    UIImageView *inputBackView;
    UIImageView *inputTagView;
    UITextView  *inputTextView;
    UIButton    *favBtn;
    
    inputBeginAction _beginAction;
    inputEndAction   _endAction;
    BOOL             isSendComment;
}
@property (nonatomic,retain)NSString *articleId;
@property (nonatomic,retain)NSString *lastInputString;
@property (nonatomic,retain)UIButton    *favBtn;
@property (nonatomic,assign)BOOL     isFavorited;
@property (nonatomic,assign)ZYCommentType commentType;
@property (nonatomic,assign)ZYFavoriteType favoriteType;


- (id)initWithFrame:(CGRect)frame withBeginAction:(inputBeginAction)bAction withEndAction:(inputEndAction)eAction;

- (void)switchToInputState;
- (void)switchToNormalState;

- (void)setEnableFavorite;
- (void)setDisableFavorite;

- (void)commentReset;

@end
