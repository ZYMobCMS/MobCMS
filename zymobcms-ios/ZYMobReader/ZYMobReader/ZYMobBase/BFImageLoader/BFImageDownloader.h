//
//  BFImageDownloader.h
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ThumbKey @"thumb_cache_key"

@interface BFImageDownloader : NSObject
{
    NSOperationQueue *_loadQueue;
}

+ (BFImageDownloader *)shareLoader;
- (void)downloadImageWithUrl:(NSString *)url;
- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view;
- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view shouldResize:(BOOL)state;

@end
