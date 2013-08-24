//
//  ThemeManager.h
//
//  Created by li sha on 12-7-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kKeyForThemeHeader @"KeyForThemeHeader"
#define THEME_PATH @"Theme"
#define BFNEW_THEME_PATH @"BFNewTheme"

typedef enum {

    ZYThemeTypeBlue = 0,
    
}ZYThemeType;

@interface ThemeManager : NSObject {
	NSString *currentThemeHeader;
    ZYThemeType themeType;
}

@property(nonatomic,retain)NSString *currentThemeHeader;
@property (nonatomic,assign)ZYThemeType themeType;

+ (ThemeManager *)sharedThemeManager;

- (void)ChangeSkin:(NSString *)currentSkin;

- (NSMutableArray *)getThemes;

- (void)setThemeForPath:(NSString *)defaultPath;

@end
