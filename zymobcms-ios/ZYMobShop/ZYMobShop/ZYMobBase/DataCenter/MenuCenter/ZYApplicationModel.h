//
//  ZYApplicationModel.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-27.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYApplicationModel : ZYBaseModel
@property (nonatomic,retain)NSString *name;

- (id)initWithContentDict:(NSDictionary*)content;

@end
