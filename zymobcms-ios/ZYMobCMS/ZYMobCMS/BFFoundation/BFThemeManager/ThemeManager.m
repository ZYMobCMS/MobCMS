//
//  ThemeManager.m
//
//  Created by li sha on 12-7-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThemeManager.h"
#import "JSONKit.h"

@implementation ThemeManager

@synthesize currentThemeHeader, themeType;

static ThemeManager *instance=nil;

+ (void)initialize
{   
	if ([self class]==[ThemeManager class]) {
        
		[[ThemeManager sharedThemeManager] setThemeForPath:nil];

        // [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
	}
}


// 为当前用户设置主题
- (void)setThemeForPath:(NSString *)themePath
{
    NSString *defaultPath = [NSString stringWithFormat:@"%@", themePath];
    NSString *curThemePath = THEME_PATH;
    if (themeType == 1) {
        curThemePath = BFNEW_THEME_PATH;
    }
    
    if (themePath == nil) {
        NSString *defaultTheme = [[self getThemes] objectAtIndex:0];
        NSString *folderPath = [[NSString alloc] initWithFormat:@"%@/%@", curThemePath, defaultTheme];
        defaultPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:folderPath];
        [folderPath release];
    }
    
    NSString *currentUid = [ZYUserManager getCurrentUserId];
    if (!currentUid) {
        currentUid = @"defaultUID";
    }
    
//    NSMutableDictionary *_pathDict = [OpinionSetting getSettingDictForKey:kKeyForThemeHeader];
//    [_pathDict setValue:defaultPath forKey:currentUid];
//    
//    [[NSUserDefaults standardUserDefaults] setValue:[_pathDict JSONData] forKey:kKeyForThemeHeader];
//    [[NSUserDefaults standardUserDefaults] synchronize]; 
    
    self.currentThemeHeader = defaultPath;
}


+ (ThemeManager *)sharedThemeManager
{   
	@synchronized(self)
	{
		if (instance==nil) {
			instance=[[ThemeManager alloc] init];
		}
	}
	return instance;
}


- (id)init
{
	if (self=[super init]) {
        
//        self.currentThemeHeader = [OpinionSetting getSettingDataForKey:kKeyForThemeHeader];
        
    }
	return self;
}


// 获取主题目录
- (NSMutableArray *)getThemes
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *curThemePath = THEME_PATH;
    if (themeType == 1) {
        curThemePath = BFNEW_THEME_PATH;
    }
    NSString *home=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:curThemePath];
    
    NSDirectoryEnumerator *direnum = [manager enumeratorAtPath:home];
    
    NSMutableArray *files = [NSMutableArray arrayWithCapacity:0];
    NSString *filename ;
    while (filename = [direnum nextObject]) {
        if ([[filename pathExtension] isEqualToString:@""]) 
            [files addObject: filename];
    }
    
    //    NSEnumerator *fileenum;
    //    fileenum = [files objectEnumerator];
    //    while (filename = [fileenum nextObject])
    //        NSLog(@"%@", filename);
    
    return files;
}


// 换肤
- (void)ChangeSkin:(NSString *)currentSkin
{
    NSString *curThemePath = THEME_PATH;
    if (themeType == 1) {
        curThemePath = BFNEW_THEME_PATH;
    }
    NSString *themeName = [[NSString alloc] initWithFormat:@"%@/%@", curThemePath, currentSkin];
    NSString *defaultPath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:themeName];
    self.currentThemeHeader = defaultPath;
    
    [self setThemeForPath:self.currentThemeHeader];
    [themeName release];
}


- (void)dealloc
{   
	[currentThemeHeader release];
    
	[super dealloc];
}


@end