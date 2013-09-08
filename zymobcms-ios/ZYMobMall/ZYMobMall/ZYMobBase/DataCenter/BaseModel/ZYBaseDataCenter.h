//
//  ZYBaseDataCenter.h
//  ZYMobMall
//
//  Created by barfoo2 on 13-8-28.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYBaseDataCenter : NSObject
{
    NSMutableDictionary *_actionsDict;
    NSMutableArray *_requestFlags;
}
@property (nonatomic,retain)NSMutableDictionary *actionsDict;
@property (nonatomic,retain)NSMutableArray *requestFlags;

- (void)cancelAllRequestNow;

@end
