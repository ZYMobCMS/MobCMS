//
//  BFAttributeDescriptor.h
//  BFOpinion
//
//  Created by ZYVincent on 13-3-15.
//  Copyright (c) 2013年 barfoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

typedef enum{
    
    BFTextAligmentLeft = 0,
    BFTextAligmentRight,
    BFTextAligmentCenter,
    
}BFTextAligment;

@interface BFAttributeDescriptor : NSObject
{
    UIColor *textColor;
    NSArray *keywords;
    NSString *textFont;
    CGFloat lineSpace;
    CGFloat fontSize;
    BFTextAligment aligment;
}
@property (nonatomic,retain)UIColor *textColor;
@property (nonatomic,retain)NSString *textFont;
@property (nonatomic,assign)CGFloat lineSpace;
@property (nonatomic,assign)CGFloat fontSize;
@property (nonatomic,retain)NSArray *keywords;
@property (nonatomic,assign)BFTextAligment aligment;
@property (nonatomic,assign)BOOL    isKeywordDistrict;//严格关键字



@end
