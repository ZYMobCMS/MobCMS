//
//  BFImageDownloader.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFImageDownloader.h"
#import "BFImageCache.h"
#import "UIImage+Resize.h"

#define MaxImageWidth 1024
#define MaxImageHeight 1800
#define kIndicatorTag 879870

#define ThumbSize CGSizeMake(80,50)
#define ThumbRoundSize CGSizeMake (150,150)


static BFImageDownloader *_instance = nil;
@implementation BFImageDownloader

- (id)init{
    if (self = [super init]) {
        
        _loadQueue = [[NSOperationQueue alloc]init];
    }
    return self;
}
- (void)dealloc{
    [_loadQueue release];
    [super dealloc];
}

+ (BFImageDownloader *)shareLoader
{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [[self alloc]init];
        }
    }
    return _instance;
}

//load image operation method
- (void)loadImageWithArguments:(NSObject *)arguments
{
    NSArray *paramArray = (NSArray *)arguments;
    
    NSURL *imageUrl = [NSURL URLWithString:[paramArray objectAtIndex:0]];
//    BFLogObject(imageUrl);
    UIImageView *imageView = [paramArray objectAtIndex:1];
    BOOL state = [[paramArray objectAtIndex:2]boolValue];
    
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
//    BFLogObject(loadImage);
    
    if (loadImage != nil) {
        
        CGFloat increase = 0.f;
        CGSize newImageSize = CGSizeZero;
        if (loadImage.size.width > MaxImageWidth || loadImage.size.height > MaxImageHeight) {
            
            BOOL increaseXOrY = loadImage.size.height>loadImage.size.width? YES:NO;
            
            if (increaseXOrY) {
                CGFloat newImageHeight = 0.f;
                newImageHeight = loadImage.size.height > MaxImageHeight ? MaxImageHeight:loadImage.size.height;
                
                if (newImageHeight==MaxImageHeight) {
                    increase = MaxImageHeight/loadImage.size.height;
                }
                
                CGFloat newImageWidth = loadImage.size.width*increase;
                
                newImageSize = CGSizeMake(newImageWidth,newImageHeight);
            }else{
                CGFloat newImageWidth = 0.f;
                newImageWidth = loadImage.size.width > MaxImageWidth ? MaxImageWidth:loadImage.size.width;
                
                if (newImageWidth==MaxImageWidth) {
                    increase = MaxImageWidth/loadImage.size.width;
                }
                
                CGFloat newImageHeight = loadImage.size.height*increase;
                
                newImageSize = CGSizeMake(newImageWidth,newImageHeight);
            }
        }
        if(!CGSizeEqualToSize(newImageSize,CGSizeZero)){
            loadImage = [loadImage resizedImage:newImageSize interpolationQuality:kCGInterpolationDefault];
        }
        
        if (state) {
            CGSize itemSize = CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [loadImage drawInRect:imageRect];
            loadImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            imageView.image = loadImage;//圆角
        }else {
            imageView.image = loadImage;//圆角
        }
        
        //缓存图片
        [BFImageCache cacheImage:loadImage withUrl:[imageUrl absoluteString]];
        
        imageView.image = loadImage;

    }else {
        
        imageView.image = nil;
    }
}

- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view
{
    [self downloadImageWithUrl:url forView:view shouldResize:NO];
}

- (void)downloadImageWithUrl:(NSString *)url
{
    if (url == nil) {
        return;
    }
    
    if ([BFImageCache imageForUrl:url]) {
        return;
    }
    
    BFImageGetOperation *newOperation = [BFImageGetOperation initWithImageUrl:url withFinishDelegate:self];
    
    [_loadQueue addOperation:newOperation];
    
}

- (void)downloadImageWithUrl:(NSString *)url forView:(UIView *)view shouldResize:(BOOL)state
{
    if (url == nil) {
        return;
    }
    if (view == nil) {
        return;
    }
    
    if ([BFImageCache imageForUrl:url] != nil) {
        //直接去缓存获取图片
        UIImageView *forView = (UIImageView *)view;
        UIImage *cacheImage = [BFImageCache imageForUrl:url];
        forView.image = cacheImage;        
    }else {
        NSArray *arguments = [NSArray arrayWithObjects:url,view,[NSNumber numberWithBool:state],nil];
        
        NSInvocationOperation *loadOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadImageWithArguments:) object:arguments];
        
        [_loadQueue addOperation:loadOperation];
        [loadOperation release];
        
    }
}

@end
