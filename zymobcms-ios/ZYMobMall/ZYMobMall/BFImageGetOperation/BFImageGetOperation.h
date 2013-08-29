//
//  BFImageGetOperation.h
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ImageGetFinishAction) (UIImage *loadImage);

@interface BFImageGetOperation : NSOperation
{
    NSString *_imageUrl;
    NSString *_cacheName;
    CGRect   _newRect;
    BOOL    _setNewRect;
    
    id  _delegate;
    
}
@property (nonatomic,copy)ImageGetFinishAction finishGetImageAction;

- (id)initWithImageUrl:(NSString *)url;
+ (BFImageGetOperation *)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate;
+ (BFImageGetOperation *)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate withNewRect:(CGRect)newRect;

@end
