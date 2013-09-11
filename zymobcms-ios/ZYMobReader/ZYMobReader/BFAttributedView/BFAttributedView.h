//
//  BFAttributedView.h
//  BFOpinion
//
//  Created by ZYVincent on 13-3-15.
//  Copyright (c) 2013年 barfoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "BFAttributeDescriptor.h"

@interface BFAttributedView : UIView
{
    CTFrameRef ctFrame;
}
@property (nonatomic,retain)BFAttributeDescriptor *textDescriptor;
@property (nonatomic,retain)NSAttributedString *contentAttributedString;

+ (NSAttributedString*)createAttributedString:(NSString*)string withDescriptor:(BFAttributeDescriptor*)descriptor;
+ (CGFloat)getAttributedContentHeight:(NSAttributedString*)aString withWdith:(CGFloat)width;
+ (CGFloat)boundingRectHeightForAttributedString:(NSAttributedString*)aString withWdith:(CGFloat)width;
+ (CGFloat)getAttributedContentHeightWithString:(NSString*)aString withWdith:(CGFloat)width withDescriptor:(BFAttributeDescriptor*)descriptor;

- (NSAttributedString*)attributedStringWithDescriptor:(BFAttributeDescriptor *)descriptor withString:(NSString*)string;

- (NSMutableAttributedString*)subStringWithHeight:(CGFloat)dHeight;

- (void)setContentText:(NSString *)contentText;

- (void)drawString:(NSAttributedString *)aString context:(CGContextRef)context rect:(CGRect)rect;

- (void)setCTFrame:(CTFrameRef)aFrame;

@end
