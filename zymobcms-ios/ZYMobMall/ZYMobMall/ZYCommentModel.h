//
//  ZYCommentModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCommentModel : ZYBaseModel

- (id)initWithSummaryDict:(NSDictionary*)contentDict;
- (id)initWithDetailDict:(NSDictionary*)contentDict;

@end
