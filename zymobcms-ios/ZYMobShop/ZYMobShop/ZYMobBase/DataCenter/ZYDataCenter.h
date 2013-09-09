//
//  ZYDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYUserDataCenter.h"
#import "BFNetworkHelper.h"
#import "ZYBaseModel.h"
#import "ZYBaseDataCenter.h"
#import "ZYMenuDataCenter.h"
#import "ZYUserDataCenter.h"
#import "ZYProductDataCenter.h"
#import "ZYPictureDataCenter.h"
#import "ZYNewsDataCenter.h"
#import "ZYCommentDataCenter.h"
#import "ZYUserActiveDataCenter.h"
#import "ZYThemeManager.h"
#import "BFImageView.h"
#import "BFImageDownloader.h"
#import "BFImageCache.h"

typedef enum {

    ZYBaseTypeArticle = 0,
    ZYBaseTypePicture,
    ZYBaseTypeProduct,
    
}ZYBaseType;

#define ZYListPageSize 10
