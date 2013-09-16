//
//  BFAttributeDescriptor.m
//  BFOpinion
//
//  Created by ZYVincent on 13-3-15.
//  Copyright (c) 2013年 barfoo. All rights reserved.
//

#import "BFAttributeDescriptor.h"

@implementation BFAttributeDescriptor
@synthesize fontSize,lineSpace,textColor,textFont,keywords;
@synthesize aligment,isKeywordDistrict;

- (id)init
{
    if (self = [super init]) {
        
        //默认属性
        self.fontSize = 14;
        self.textFont = @"HeiTi SC";
        self.textColor = [UIColor blackColor];
        self.lineSpace = 3.0f;
        self.aligment = BFTextAligmentLeft;
        self.isKeywordDistrict = NO;
    }
    return self;
}

- (void)dealloc
{
    self.textColor = nil;
    self.textFont = nil;
    self.keywords = nil;
    [super dealloc];
}

@end
