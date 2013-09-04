//
//  BFImageGetOperation.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFImageGetOperation.h"
#import "UIImage+Resize.h"

#define MaxImageWidth 1024
#define MaxImageHeight 1800

#define ThumbSize CGSizeMake(80,50)
#define ThumbRoundSize CGSizeMake (150,150)

@interface BFImageGetOperation(PrivateMethod)
- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate withNewRect:(CGRect)newRect;
- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate;
@end

@implementation BFImageGetOperation
@synthesize finishGetImageAction;

- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate withNewRect:(CGRect)newRect
{
    if (self = [super init]) {
        
        _delegate = [aDelegate retain];
        _imageUrl = [url copy];
        
        _newRect = newRect;
        _setNewRect = YES;
        
    }
    return self;
}
- (id)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate
{
    if (self = [super init]) {
        
        _delegate = [aDelegate retain];
        _imageUrl = [url copy];
        
        _setNewRect = NO;
        
    }
    return self;
}
- (id)initWithImageUrl:(NSString *)url
{
    if (self = [super init]) {
        
        _imageUrl = [url copy];
        
        _setNewRect = NO;
        
    }
    return self;
}
- (id)initWithImageUrl:(NSString *)url withNewRect:(CGRect)newRect
{
    if (self = [super init]) {
        
        _imageUrl = [url copy];
        
        _setNewRect = YES;
        _newRect = newRect;
        
    }
    return self;
}

- (void)dealloc
{
    if (finishGetImageAction) {
        [finishGetImageAction release];
    }
    [_delegate release];
    [_cacheName release];
    [_imageUrl release];
    [super dealloc];
}

+ (BFImageGetOperation *)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate
{
    BFImageGetOperation *operation = [[[BFImageGetOperation alloc]initWithImageUrl:url withFinishDelegate:aDelegate]autorelease];
    
    return operation;
}
+ (BFImageGetOperation *)initWithImageUrl:(NSString *)url withFinishDelegate:(id)aDelegate withNewRect:(CGRect)newRect
{
    BFImageGetOperation *operation = [[[BFImageGetOperation alloc]initWithImageUrl:url withFinishDelegate:aDelegate withNewRect:newRect]autorelease];
    
    return operation;
}

- (void)main{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    if (!_imageUrl) {
        NSLog(_imageUrl = nil,@"image url can't be nil");
        [self cancel];
    }
    if (_delegate == nil) {
        NSLog(_delegate = nil,@"image get delegate can't be nil");
        [self cancel];
    }
    
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]];

    if (loadImage != nil) {
        UIImage *newImage = nil;
        if (_setNewRect) {
            CGSize itemSize = CGSizeMake(_newRect.size.width, _newRect.size.height);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [loadImage drawInRect:imageRect];
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        newImage = loadImage;
        
        if (self.finishGetImageAction) {
            self.finishGetImageAction(newImage);
        }
        
        if ([_delegate respondsToSelector:@selector(imageDidLoad:)]) {
            [_delegate performSelectorOnMainThread:@selector(imageDidLoad:) withObject:newImage waitUntilDone:NO];
        }
    }
    [pool drain];
}
@end
