//
//  ZYAboutCell.h
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-18.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    ZYCellActionMobileCall = 0,
    ZYCellActionPhoneCall,
    ZYCellActionMailSend,
    ZYCellActionMessageSend,
    ZYCellActionOpenUrl,
    ZYCellActionNone,
    
}ZYCellActionType;

@interface ZYAboutCell : UITableViewCell
{
    UILabel *tagLabel;
    UILabel *valueLabel;
}
@property (nonatomic,retain)NSString *typeName;
@property (nonatomic,assign)BOOL hasAction;
@property (nonatomic,assign)ZYCellActionType actionType;

- (void)setContentDict:(NSDictionary*)contentDict;
+ (CGFloat)heightForDict:(NSDictionary*)contentDict forTable:(UITableView*)table;

@end
