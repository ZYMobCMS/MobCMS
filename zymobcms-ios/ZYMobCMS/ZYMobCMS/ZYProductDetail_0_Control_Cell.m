//
//  ZYProductDetail_0_Control_Cell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYProductDetail_0_Control_Cell.h"

#define ProductDetail_0_Text_FontSize 13
#define ProductDetail_0_Left_Margin 10
#define ProductDetail_0_Top_Margin 10

@implementation ZYProductDetail_0_Control_Cell
@synthesize productId,isFavorited;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGFloat totalWidth = (self.frame.size.width-20)/2-4*ProductDetail_0_Left_Margin;
        
        supportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        supportBtn.frame = CGRectMake(((self.frame.size.width)/2-30-10)/2,ProductDetail_0_Top_Margin,30,30);
        [self.contentView addSubview:supportBtn];
        [supportBtn setBackgroundImage:[UIImage imageNamed:@"comment_btn_normal.png"] forState:UIControlStateNormal];
        [supportBtn addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        
        supportLabel = [[UILabel alloc]init];
        supportLabel.frame = CGRectMake(ProductDetail_0_Left_Margin+10,30+2*ProductDetail_0_Top_Margin,totalWidth,40);
        [self.contentView addSubview:supportLabel];
        [supportLabel release];
        supportLabel.textAlignment = UITextAlignmentCenter;
        supportLabel.backgroundColor = [UIColor clearColor];
        
        favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        favBtn.frame = CGRectMake(self.frame.size.width/2+((self.frame.size.width)/2-30-10)/2,ProductDetail_0_Top_Margin,30, 30);
        [self.contentView addSubview:favBtn];
        [favBtn addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
        
        favLabel = [[UILabel alloc]init];
        favLabel.frame = CGRectMake(self.frame.size.width/2,30+3*ProductDetail_0_Top_Margin,self.frame.size.width/2-10,40);
        [self.contentView addSubview:favLabel];
        [favLabel release];
        favLabel.backgroundColor = [UIColor clearColor];
        favLabel.textAlignment = UITextAlignmentCenter;
        
        //seprator line
        UIImageView *sepratorX = [[UIImageView alloc]init];
        sepratorX.frame = CGRectMake(0,(ZYProductDetail_0_ControllCellHeight)/2,self.frame.size.width-20, 1);
        sepratorX.backgroundColor = [BFUitils rgbColor:211 green:211 blue:211];
        [self.contentView addSubview:sepratorX];
        [sepratorX release];
        
        UIImageView *sepratorY = [[UIImageView alloc]init];
        sepratorY.frame = CGRectMake((self.frame.size.width-20)/2,0,1,ZYProductDetail_0_ControllCellHeight);
        sepratorY.backgroundColor = [BFUitils rgbColor:211 green:211 blue:211];
        [self.contentView addSubview:sepratorY];
        [sepratorY release];
    }
    return self;
}

- (void)dealloc
{
    self.productId = nil;
    if (_beginFavAction) {
        [_beginFavAction release];
    }
    if (_beginCommentAction) {
        [_beginCommentAction release];
    }
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentDict:(NSDictionary *)contentDict
{
    NSString *favoriteCount = [contentDict objectForKey:@"favorite_count"];
    NSString *commentCount = [contentDict objectForKey:@"comment_count"];
    self.productId = [contentDict objectForKey:@"product_id"];
    self.isFavorited = [[contentDict objectForKey:@"isFavorited"]boolValue];
    
    if (isFavorited) {
        [favBtn setBackgroundImage:[UIImage imageNamed:@"favorite_yes.png"] forState:UIControlStateNormal];
    }else{
        [favBtn setBackgroundImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];
    }
    
    favLabel.text = favoriteCount;
    supportLabel.text = commentCount;
}

- (void)setTapBeginFavAction:(beginTapOnFavBtn)beginFavAction
{
    if (_beginFavAction) {
        [_beginFavAction release];
    }
    _beginFavAction = [beginFavAction copy];
}

- (void)setTapBeginCommentAction:(beginTapOnCommentBtn)beginCommentAction
{
    if (_beginCommentAction) {
        [_beginCommentAction release];
    }
    _beginCommentAction = [beginCommentAction copy];
}

- (void)commentAction
{
    if (_beginCommentAction) {
        _beginCommentAction();
    }
}
- (void)favoriteAction
{
    if (![ZYUserManager userIsLogined]) {
        if (_beginFavAction) {
            _beginFavAction();
        }
        return;
    }

    if (isFavorited) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.productId forKey:@"productId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeCancelFavoriteProduct withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteSuccess:" withFaildRequestMethod:@"favoriteFaild:"];
    }else{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.productId forKey:@"productId"];
        
        [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeFavoriteProduct withParams:params withHelperDelegate:self withSuccessRequestMethod:@"favoriteSuccess:" withFaildRequestMethod:@"favoriteFaild:"];
    }
    
}
- (void)favoriteSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
//        NSLog(@"favoriteSuccess");
        if (isFavorited) {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
            self.isFavorited = NO;
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_no.png"] forState:UIControlStateNormal];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
            self.isFavorited = YES;
        }
    }else{
        NSString *msg = [resultDict objectForKey:@"msg"];
        if ([msg isEqualToString:@"已经收藏过该产品"]) {
            [favBtn setBackgroundImage:[UIImage imageNamed:@"picture_favorite_yes.png"] forState:UIControlStateNormal];
            self.isFavorited = YES;
        }
        [SVProgressHUD showErrorWithStatus:msg];
    }
}
- (void)favoriteFaild:(NSDictionary*)resultDict
{
    [SVProgressHUD showErrorWithStatus:@"网络不给力啊"];
}


@end
