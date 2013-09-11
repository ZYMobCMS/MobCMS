
//
//  ZYRootMenuItemModel.m
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYRootMenuItemModel.h"

@implementation ZYRootMenuItemModel
@synthesize tabTypeId;
- (void)dealloc
{
    self.tabTypeId = nil;
    [super dealloc];
}
- (id)initWithTabTypeItem:(ZYTabTypeModel *)tabTypeModel
{
    if (self = [super init]) {
        
        self.categoryId = tabTypeModel.categoryId;
        self.tabTypeId = tabTypeModel.tabTypeId;
        self.name = tabTypeModel.name;
        self.icon = tabTypeModel.icon;
        self.isLocalIcon = tabTypeModel.isLocalIcon;
        
    }
    return self;
}
@end
