//
//  ZYXMPPMessage.m
//  ZYXMPPClient
//
//  Created by barfoo2 on 13-9-5.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYXMPPMessage.h"

@implementation ZYXMPPMessage
@synthesize content,user,domain,resource;

- (id)initWithMessageDict:(NSDictionary *)msgDict
{
    if (self = [super init]) {
        
        self.content = [msgDict objectForKey:@"body"];
        
    }
    return self;
}
@end
