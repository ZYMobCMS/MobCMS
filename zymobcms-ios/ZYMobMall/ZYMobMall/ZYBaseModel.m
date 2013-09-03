//
//  ZYBaseModel.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseModel.h"

@implementation ZYBaseModel

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder*)aCoder
{
    
}

+ (NSString*)replaceNBSPString:(NSString *)sourceString
{
    NSMutableString *newString = [NSMutableString stringWithString:sourceString];
    NSRange range = NSMakeRange(0, [newString length]);
    
    NSArray *checkArray = [NSArray arrayWithObjects:@"\\",@"\r",@"&ldquo",@"&rdquo",@";",@"/",@"-",@"<em>",@"</em>",@"!",@"|", nil];
    
    for (int i=0 ; i<[checkArray count];i++) {
        [newString replaceOccurrencesOfString:[checkArray objectAtIndex:i] withString:@"" options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    NSArray *spaceArray = [NSArray arrayWithObjects:@"&nbsp",@"</br>",nil];
    for (int i=0 ; i<[spaceArray count];i++) {
        [newString replaceOccurrencesOfString:[spaceArray objectAtIndex:i] withString:@" " options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    NSArray *lineArray = [NSArray arrayWithObjects:@"<br>",nil];
    for (int i=0 ; i<[lineArray count];i++) {
        [newString replaceOccurrencesOfString:[lineArray objectAtIndex:i] withString:@"\n" options:NSCaseInsensitiveSearch range:range];
        range = NSMakeRange(0,[newString length]);
    }
    
    return newString;
}

@end
