//
//  ZYXMPPMessage.h
//  ZYXMPPClient
//
//  Created by barfoo2 on 13-9-5.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYXMPPMessage : NSObject
@property (nonatomic,strong)NSString *user;
@property (nonatomic,strong)NSString *domain;
@property (nonatomic,strong)NSString *resource;
@property (nonatomic,strong)NSString *content;

- (id)initWithMessageDict:(NSDictionary*)msgDict;

@end
