//
//  ZYPictureCell.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-3.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPictureCell.h"

#define TopMargin 15
#define LeftMargin 15
#define CellMargin 0
#define ImageItemMargin 30
#define ImageWidth      130
#define ImageHeight     150

@implementation ZYPictureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    if (_tapOnCellAction) {
        [_tapOnCellAction release];
    }
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withTapOnCell:(tapOnCellAction)tapOnCellAction
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _tapOnCellAction = [tapOnCellAction copy];
        
        leftItem = [[ImageItem alloc]initWithFrame:CGRectMake((self.frame.size.width-2*ImageWidth)/3,10,ImageWidth,ImageHeight) withTapAction:^(void) {
            if (_tapOnCellAction) {
                _tapOnCellAction(self,0);
            }
        }];
        [self.contentView addSubview:leftItem];
        [leftItem release];
        
        rightItem = [[ImageItem alloc]initWithFrame:CGRectMake((self.frame.size.width-2*ImageWidth)*2/3+ImageWidth,10,ImageWidth,ImageHeight ) withTapAction:^(void) {
            if (_tapOnCellAction) {
                _tapOnCellAction(self,1);
            }
        }];
        [self.contentView addSubview:rightItem];
        [rightItem release];
        
    }
    return self;
}

+ (CGFloat)pictureCellHeight
{
    return ImageHeight+CellMargin;
}

- (void)setContentArray:(NSArray *)imageArray
{
    if (imageArray.count==1) {
        leftItem.hidden = NO;
        rightItem.hidden = YES;
        
        [leftItem setItemContent:[imageArray objectAtIndex:0]];
    }else{
        
        [leftItem setItemContent:[imageArray objectAtIndex:0]];
        [rightItem setItemContent:[imageArray objectAtIndex:1]];
    }
}

- (void)setImageArray:(NSArray *)imageArray
{
    if (imageArray.count==1) {
        
        [leftItem setItemImage:[imageArray objectAtIndex:0]];
        
    }else{
        
        [leftItem setItemImage:[imageArray objectAtIndex:0]];

        [rightItem setItemImage:[imageArray objectAtIndex:1]];

    }
}
- (void)setCacheImageForArray:(NSArray *)imageArray
{
    if (imageArray.count==1) {
        
        if ([BFImageCache imageForUrl:[[imageArray objectAtIndex:0]objectForKey:@"images"]]) {
            [leftItem setImage:[BFImageCache imageForUrl:[[imageArray objectAtIndex:0]objectForKey:@"images"]]];
        }
        
    }else{
        
        if ([BFImageCache imageForUrl:[[imageArray objectAtIndex:0]objectForKey:@"images"]]) {
            [leftItem setImage:[BFImageCache imageForUrl:[[imageArray objectAtIndex:0]objectForKey:@"images"]]];
        }
        if ([BFImageCache imageForUrl:[[imageArray objectAtIndex:1]objectForKey:@"images"]]) {
            [rightItem setImage:[BFImageCache imageForUrl:[[imageArray objectAtIndex:1]objectForKey:@"images"]]];
        }
    }
}

- (BOOL)hasCacheForImageArray:(NSArray *)imageArray
{
    BOOL hasCache = YES;
    if (imageArray.count==1) {
        
        if (![BFImageCache imageForUrl:[[imageArray objectAtIndex:0]objectForKey:@"images"]]) {
            return NO;
        }
        
    }else{
        
        if (![BFImageCache imageForUrl:[[imageArray objectAtIndex:0]objectForKey:@"images"]]) {
            return NO;
        }
        if (![BFImageCache imageForUrl:[[imageArray objectAtIndex:1]objectForKey:@"images"]]) {
            return NO;
        }
    }
    
    return hasCache;
}

@end
