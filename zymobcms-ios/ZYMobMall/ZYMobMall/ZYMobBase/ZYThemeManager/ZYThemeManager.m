//
//  ZYThemeManager.m
//  ZYMobMall
//
//  Created by ZYVincent on 13-9-8.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYThemeManager.h"

@implementation ZYThemeManager

+ (void)setDefaultTheme
{
    NSArray *allThemes = [ZYThemeManager returnAllThemes];
    
    [ZYThemeManager setCurrentThemesWithThemeConfig:[allThemes objectAtIndex:0]];
    
}

+ (NSArray*)returnAllThemes
{
    NSString *themsPlist = [[NSBundle mainBundle]pathForResource:ZYThemeSettingPlistName ofType:@"plist"];
    NSDictionary *rootDict = [NSDictionary dictionaryWithContentsOfFile:themsPlist];
    
    NSArray *allThemes = [rootDict objectForKey:@"Themes"];
    
    NSMutableArray *allThemesDirs = [NSMutableArray array];
    for (int i=0;i<allThemes.count;i++) {
        
        NSDictionary *item = [allThemes objectAtIndex:i];
        NSString *themeDir = [item objectForKey:@"SourceDirName"];
        
        NSMutableDictionary *configDict = [NSMutableDictionary dictionary];
        [configDict setObject:themeDir forKey:@"themeDir"];
        [configDict setObject:[NSNumber numberWithInt:i] forKey:@"themeIndex"];
        
        [allThemesDirs addObject:configDict];
    }
    
    return allThemesDirs;
}

+ (void)setCurrentThemesWithThemeConfig:(NSDictionary *)configDict
{
    [[NSUserDefaults standardUserDefaults]setObject:configDict forKey:ZYThemeManagerSettingUDF];

}

+ (UIImage*)getImageWithName:(NSString *)imageName
{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZYThemeManagerSettingUDF]) {
        [self setDefaultTheme];
    }
    
    NSString *basePath = [[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:ZYThemeResourceFolderName];
    NSDictionary *themeConfig = [[NSUserDefaults standardUserDefaults]objectForKey:ZYThemeManagerSettingUDF];
    NSString *themePath = [basePath stringByAppendingPathComponent:[themeConfig objectForKey:@"themeDir"]];

    NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];

    return [UIImage imageWithContentsOfFile:imagePath];

}

+ (UIColor*)getThemeColorByKey:(NSString *)key
{
    NSString *themsPlist = [[NSBundle mainBundle]pathForResource:ZYThemeSettingPlistName ofType:@"plist"];
    NSDictionary *rootDict = [NSDictionary dictionaryWithContentsOfFile:themsPlist];
    
    NSArray *allThemes = [rootDict objectForKey:@"Themes"];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:ZYThemeManagerSettingUDF]) {
        [self setDefaultTheme];
    }
    NSDictionary *themeConfig = [[NSUserDefaults standardUserDefaults]objectForKey:ZYThemeManagerSettingUDF];

    NSDictionary *currentThemeDict = [allThemes objectAtIndex:[[themeConfig objectForKey:@"themeIndex"]intValue]];
    NSDictionary *colorConfigDict = [currentThemeDict objectForKey:@"ColorSettings"];

    NSString *colorString = [colorConfigDict objectForKey:key];

    return [ZYThemeManager colorFromString:colorString];

}

+ (UIColor *)colorFromString:(NSString*)cString
{
    NSArray *colorArray = [cString componentsSeparatedByString:@","];
    
    CGFloat redValue = [[colorArray objectAtIndex:0]intValue]/255.0f;
    CGFloat greenValue = [[colorArray objectAtIndex:1]intValue]/255.0f;
    CGFloat blueValue = [[colorArray objectAtIndex:2]intValue]/255.0f;
    
    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1];
}

@end
