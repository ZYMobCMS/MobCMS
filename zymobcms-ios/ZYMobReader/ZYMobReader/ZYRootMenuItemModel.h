//
//  ZYRootMenuItemModel.h
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYMenuItemModel.h"

@interface ZYRootMenuItemModel : ZYMenuItemModel
@property (nonatomic,retain)NSString *tabTypeId;
- (id)initWithTabTypeItem:(ZYTabTypeModel*)tabTypeModel;
@end
