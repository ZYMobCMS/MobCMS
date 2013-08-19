//
//  ZYInputCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-19.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYInputCell : UITableViewCell
{
    UILabel *tagLabel;
    UITextField *inputField;
    UIImageView *inputBackImgView;
}
@property (nonatomic,retain)UILabel *tagLabel;
@property (nonatomic,retain)UITextField *inputField;
@property (nonatomic,retain)NSString *placeHolder;


@end
