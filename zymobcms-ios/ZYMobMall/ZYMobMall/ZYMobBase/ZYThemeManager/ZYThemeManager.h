//
//  ZYThemeManager.h
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-8.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

/*******
 *****  用于切换主题图片
 *****
 *******/

#import <Foundation/Foundation.h>

#define ZYThemeManagerSettingUDF @"ZYThemeManagerSettingUDF"
#define ZYThemeSettingPlistName @"ZYTheme"
#define ZYThemeResourceFolderName @"ZYTheme"

@interface ZYThemeManager : NSObject
+ (void)setDefaultTheme;
+ (NSArray *)returnAllThemes;
+ (void)setCurrentThemesWithThemeConfig:(NSDictionary*)configDict;
+ (UIImage*)getImageWithName:(NSString*)imageName;
+ (UIColor*)getThemeColorByKey:(NSString*)key;
@end
