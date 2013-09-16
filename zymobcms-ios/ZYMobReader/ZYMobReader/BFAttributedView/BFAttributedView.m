//
//  BFAttributedView.m
//  BFOpinion
//
//  Created by ZYVincent on 13-3-15.
//  Copyright (c) 2013年 barfoo. All rights reserved.
//

#import "BFAttributedView.h"

#define MaxTextHeight 99999.0f

@interface BFAttributedView ()
- (NSAttributedString *)attributedStringWithDescriptor:(BFAttributeDescriptor*)descriptor;
@end

@implementation BFAttributedView
@synthesize textDescriptor;
@synthesize contentAttributedString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //默认内容设置
        if (!self.textDescriptor) {
            self.textDescriptor = [[BFAttributeDescriptor alloc]init];
        }
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 内存管理
- (void)dealloc
{
    self.textDescriptor = nil;
    self.contentAttributedString = nil;
    [super dealloc];
}

#pragma mark -设置内容
- (void)setContentText:(NSString *)contentText
{
    if (!contentText) {
        return;
    }
    if (self.contentAttributedString) {
        self.contentAttributedString = nil;
    }
    self.contentAttributedString = [self attributedStringWithDescriptor:self.textDescriptor withString:contentText];

    [self setNeedsDisplay];
}

#pragma mark - 生成多态字符串
- (NSAttributedString*)attributedStringWithDescriptor:(BFAttributeDescriptor *)descriptor withString:(NSString*)string
{
    if (!string) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[[NSMutableAttributedString alloc]initWithString:string]autorelease];
    NSRange textRange = NSMakeRange(0,string.length);
    
    //创建字体
//    CTFontRef fontRef = CTFontCreateWithName(CFStringCreateWithCString(CFAllocatorGetDefault(),[descriptor.textFont UTF8String],kCFStringEncodingUTF8),descriptor.fontSize,NULL);
    CFStringRef fontNameRef = CFStringCreateWithCString(CFAllocatorGetDefault(),[descriptor.textFont UTF8String],kCFStringEncodingUTF8);
    CTFontRef fontRef = CTFontCreateWithName(fontNameRef,descriptor.fontSize,NULL);
    if (fontNameRef) {
        [attributedString addAttribute:(id)kCTFontAttributeName value:(id)fontRef range:NSMakeRange(0,string.length)];
        CFRelease(fontRef);
    }
    CFRelease(fontNameRef);
    
    
    //创建字体颜色
    [attributedString addAttribute:(NSString*)(kCTForegroundColorAttributeName)  value:(id)[descriptor textColor].CGColor range:NSMakeRange(0, string.length)];
    
    //创建对齐方式
    CTTextAlignment alignment;//左对齐
    switch (descriptor.aligment) {
        case BFTextAligmentLeft:
            alignment = kCTLeftTextAlignment;
            break;
        case BFTextAligmentRight:
            alignment = kCTRightTextAlignment;
            break;
        case BFTextAligmentCenter:
            alignment = kCTCenterTextAlignment;
            break;
        default:
            break;
    }
    CTTextAlignment coreTextAlign = alignment;
    CTLineBreakMode coreTextLBMode = kCTLineBreakByCharWrapping;
    CTParagraphStyleSetting paraStyles[2] =
    {
        {.spec = kCTParagraphStyleSpecifierAlignment, .valueSize = sizeof(CTTextAlignment), .value = (const void*)&coreTextAlign},
        {.spec = kCTParagraphStyleSpecifierLineBreakMode, .valueSize = sizeof(CTLineBreakMode), .value = (const void*)&coreTextLBMode},
    };
     CTParagraphStyleRef alignRef = CTParagraphStyleCreate(paraStyles, 2);
    [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(id)alignRef range:textRange];
    CFRelease(alignRef);
    
    //创建行间距
    CGFloat lineSpace=descriptor.lineSpace;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
    lineSpaceStyle.valueSize=sizeof(CGFloat);
    lineSpaceStyle.value=&lineSpace;
    CTParagraphStyleRef lineRef = CTParagraphStyleCreate(&lineSpaceStyle,1);
    [attributedString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)lineRef range:textRange];
    CFRelease(lineRef);
    
    
    //首先检查是否有关键字色彩
    if (descriptor.keywords!=nil) {
        
        for (NSArray *item in descriptor.keywords) {
            
            NSString *keyword = [item objectAtIndex:0];
            UIColor *keyColor = [item objectAtIndex:1];
            
            //绘制关键字颜色
            if (descriptor.isKeywordDistrict) {
                
                for (NSArray *item in descriptor.keywords) {
                    
                    NSString *keyword = [item objectAtIndex:0];
                    UIColor *keyColor = [item objectAtIndex:1];
                    
                    //找到关键字
                    if ([string rangeOfString:keyword].location != NSNotFound) {
                        
                        NSRange keyRange = [string rangeOfString:keyword];
                        
                        //绘制颜色
                        [attributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyColor.CGColor range:keyRange];
                        
                    }
                    
                }
                
            }else{
                NSMutableArray *rangeArray = [[NSMutableArray alloc]init];
                
                for (int i = 0; i < [string length]; i++) {
                    NSString *keyString = [string substringWithRange:NSMakeRange(i, 1)];
                    
                    if([keyword rangeOfString:keyString].length > 0)//判断
                    {
                        NSRange range = [string rangeOfComposedCharacterSequenceAtIndex:i];
                        NSValue *value = [NSValue valueWithRange:range];
                        if (range.length > 0) {
                            
                            [rangeArray addObject:value];
                        }
                    }
                    
                }
                
                for (NSValue *value in rangeArray) {
                    
                    NSRange keyRange = [value rangeValue];
                    
                    [attributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyColor.CGColor range:keyRange];
                    
                }
                [rangeArray release];
            }
        }
        
    }
    
    return attributedString;
}

+ (CGFloat)getAttributedContentHeight:(NSAttributedString *)aString withWdith:(CGFloat)width
{
    if (!aString||[aString length]==0) {
        return 0.f;
    }
    
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)aString);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}

+ (CGFloat)getAttributedContentHeightWithString:(NSString *)aString withWdith:(CGFloat)width withDescriptor:(BFAttributeDescriptor *)descriptor
{
    NSAttributedString *attriString = [BFAttributedView createAttributedString:aString withDescriptor:descriptor];
    
    return [BFAttributedView getAttributedContentHeight:attriString withWdith:width];
    
}

+ (CGFloat)boundingRectHeightForAttributedString:(NSAttributedString *)aString withWdith:(CGFloat)width
{
    if (!aString) {
        return 0.f;
    }
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)aString);
    CGSize attSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, aString.length), NULL
                                                                  , CGSizeMake(width, MaxTextHeight), NULL);
    CFRelease(frameSetter);
    return attSize.height;
}

+ (NSAttributedString*)createAttributedString:(NSString *)string withDescriptor:(BFAttributeDescriptor *)descriptor
{
    if (!string||string.length==0) {
        return nil;
    }
    
    NSMutableAttributedString *attributedString = [[[NSMutableAttributedString alloc]initWithString:string]autorelease];
    NSRange textRange = NSMakeRange(0,string.length);
    
    //创建字体
    CFStringRef fontNameRef = CFStringCreateWithCString(CFAllocatorGetDefault(),[descriptor.textFont UTF8String],kCFStringEncodingUTF8);
    CTFontRef fontRef = CTFontCreateWithName(fontNameRef,descriptor.fontSize,NULL);
    if (fontNameRef) {
        [attributedString addAttribute:(id)kCTFontAttributeName value:(id)fontRef range:NSMakeRange(0,string.length)];
        CFRelease(fontRef);
    }
    CFRelease(fontNameRef);
    
    //创建字体颜色
    [attributedString addAttribute:(NSString*)(kCTForegroundColorAttributeName)  value:(id)[descriptor textColor].CGColor range:NSMakeRange(0, string.length)];
    
    //创建对齐方式
    CTTextAlignment alignment;//左对齐
    switch (descriptor.aligment) {
        case BFTextAligmentLeft:
            alignment = kCTLeftTextAlignment;
            break;
        case BFTextAligmentRight:
            alignment = kCTRightTextAlignment;
            break;
        case BFTextAligmentCenter:
            alignment = kCTCenterTextAlignment;
            break;
        default:
            break;
    }
    CTTextAlignment coreTextAlign = alignment;
    CTLineBreakMode coreTextLBMode = kCTLineBreakByCharWrapping;
    CTParagraphStyleSetting paraStyles[2] =
    {
        {.spec = kCTParagraphStyleSpecifierAlignment, .valueSize = sizeof(CTTextAlignment), .value = (const void*)&coreTextAlign},
        {.spec = kCTParagraphStyleSpecifierLineBreakMode, .valueSize = sizeof(CTLineBreakMode), .value = (const void*)&coreTextLBMode},
    };
    CTParagraphStyleRef alignRef = CTParagraphStyleCreate(paraStyles, 2);
    [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(id)alignRef range:textRange];
    CFRelease(alignRef);
    
    //创建行间距
    CGFloat lineSpace=descriptor.lineSpace;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec=kCTParagraphStyleSpecifierLineSpacing;//指定为行间距属性
    lineSpaceStyle.valueSize=sizeof(CGFloat);
    lineSpaceStyle.value=&lineSpace;
    CTParagraphStyleRef lineRef = CTParagraphStyleCreate(&lineSpaceStyle,1);
    [attributedString addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)lineRef range:textRange];
    CFRelease(lineRef);
    
    
    //首先检查是否有关键字色彩
    if (descriptor.keywords!=nil) {
        
        for (NSArray *item in descriptor.keywords) {
            
            NSString *keyword = [item objectAtIndex:0];
            UIColor *keyColor = [item objectAtIndex:1];
            
            //绘制关键字颜色
            if (descriptor.isKeywordDistrict) {
                
                for (NSArray *item in descriptor.keywords) {
                    
                    NSString *keyword = [item objectAtIndex:0];
                    UIColor *keyColor = [item objectAtIndex:1];
                    
                    //找到关键字
                    if ([string rangeOfString:keyword].location != NSNotFound) {
                        
                        NSRange keyRange = [string rangeOfString:keyword];
                        
                        //绘制颜色
                        [attributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyColor.CGColor range:keyRange];
                        
                    }
                    
                }

            }else{
                NSMutableArray *rangeArray = [[NSMutableArray alloc]init];
                
                for (int i = 0; i < [string length]; i++) {
                    NSString *keyString = [string substringWithRange:NSMakeRange(i, 1)];
                    
                    if([keyword rangeOfString:keyString].length > 0)//判断
                    {
                        NSRange range = [string rangeOfComposedCharacterSequenceAtIndex:i];
                        NSValue *value = [NSValue valueWithRange:range];
                        if (range.length > 0) {
                            
                            [rangeArray addObject:value];
                        }
                    }
                    
                }
                
                for (NSValue *value in rangeArray) {
                    
                    NSRange keyRange = [value rangeValue];
                    
                    [attributedString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)keyColor.CGColor range:keyRange];
                    
                }
                [rangeArray release];
            }
        }
        
    }
    
    return attributedString;
}

- (void)drawString:(NSAttributedString *)aString context:(CGContextRef)context rect:(CGRect)rect
{
    CGMutablePathRef path = CGPathCreateMutable(); //1
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, self.frame.size.height);
    CGAffineTransform t2 = CGAffineTransformMakeScale(1, -1);
    CGAffineTransform t = CGAffineTransformConcat(t2, t1);
    
    CGPathAddRect(path, NULL, CGRectApplyAffineTransform(rect, t)); //2
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)aString); //3
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    CFRange frameRange = CTFrameGetVisibleStringRange(frame);
    CTFrameRef frame2 = CTFramesetterCreateFrame(framesetter, frameRange, path, NULL);
    
    CTFrameDraw(frame2, context); //4
    
    CFRelease(frame); //5
    CFRelease(frame2);
    CFRelease(path);
    CFRelease(framesetter);
}

//重绘
 - (void)drawRect:(CGRect)rect
{
     // Drawing code
     CGContextRef context = UIGraphicsGetCurrentContext();
     
     //转换坐标系
     CGContextSetTextMatrix(context, CGAffineTransformIdentity);
     CGContextTranslateCTM(context, 0, self.bounds.size.height);
     CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.contentAttributedString) {
        [self drawString:self.contentAttributedString context:context rect:rect];
    }
}

- (void)setCTFrame:(CTFrameRef)aFrame
{
    ctFrame = aFrame;
}

- (NSMutableAttributedString *)subStringWithHeight:(CGFloat)dHeight
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.contentAttributedString);

    //这两列可以使用掉的文字长度
    CGMutablePathRef path0 = CGPathCreateMutable();
    CGPathAddRect(path0, NULL, CGRectMake(0,0,self.frame.size.width,dHeight));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path0, NULL);
    CFRange frameRange = CTFrameGetVisibleStringRange(frame); //5
    
    NSMutableAttributedString *cloum0String = [[[NSMutableAttributedString alloc ]initWithAttributedString:[self.contentAttributedString attributedSubstringFromRange:NSMakeRange(frameRange.location,frameRange.length)]]autorelease];
    CFRelease(framesetter);
    CFRelease(frame);
    CFRelease(path0);
    
    return cloum0String;
}

@end
