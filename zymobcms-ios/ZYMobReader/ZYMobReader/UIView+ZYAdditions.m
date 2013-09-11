//
//  UIView+ZYAdditions.m
//  ZYToolKit
//
//  Created by ZYVincent on 12-11-16.
//  Copyright (c) 2012年 barfoo. All rights reserved.
//

#import "UIView+ZYAdditions.h"

@implementation UIView (ZYAdditions)
- (UIImage *)snapshotImage
{
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

@end
