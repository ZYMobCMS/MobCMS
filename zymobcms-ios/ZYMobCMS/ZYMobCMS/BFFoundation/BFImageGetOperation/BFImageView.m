//
//  BFImageView.m
//  OPinion
//
//  Created by ZYVincent on 12-7-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFImageView.h"
#import "BFImageCache.h"
#import "UIImage+Resize.h"
#import <ImageIO/CGImageSource.h>


#define MaxImageWidth 1024
#define MaxImageHeight 1800

#define ThumbSize CGSizeMake(80,50)
#define ThumbRoundSize CGSizeMake (150,150)

@interface BFImageView(PrivateMethod)
- (void)imageDidLoad:(UIImage *)loadImage;
@end
@implementation BFImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _loadImageOueue = [[NSOperationQueue alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [_imageUrl release];
    [_loadImageOueue release];
    [super dealloc];
}

- (id)initWithImageUrl:(NSString *)url
{
    if (self = [super init]) {
        
        _imageUrl = [url copy];
        
        //先检测有没有缓存图片
        if ([BFImageCache imageForUrl:url] != nil) {
            self.image = [BFImageCache imageForUrl:url];
        }else {
            BFImageGetOperation *loadOperation = [BFImageGetOperation initWithImageUrl:url withFinishDelegate:self withNewRect:self.frame];
            [_loadImageOueue addOperation:loadOperation];
            
            
        }
    }
    return self;
}
- (void)setImageUrl:(NSString *)url
{
    _imageUrl = [url copy];
        
    //先检测有没有缓存图片
    if ([BFImageCache imageForUrl:url] != nil) {
        self.image = [BFImageCache imageForUrl:url];
    }else {
        BFImageGetOperation *loadOperation = [[BFImageGetOperation alloc]initWithImageUrl:_imageUrl];
        [loadOperation setFinishGetImageAction:^(UIImage *loadImage){
            [self imageDidLoad:loadImage];
        }];
        [_loadImageOueue addOperation:loadOperation];
        [loadOperation release];
    }
    
}

- (void)setPlaceHolder:(UIImage *)pImage
{
    self.image = pImage;
}

//BFImageGetOperation CallBack Method
- (void)imageDidLoad:(UIImage *)loadImage
{
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
    //缓存图片
    [BFImageCache cacheImage:loadImage withUrl:_imageUrl];
    
    self.image = loadImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
