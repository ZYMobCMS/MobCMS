//
//  MenuCell.m
//  PPFIphone
//
//  Created by ZYVincent on 12-11-30.
//  Copyright (c) 2012年 li sha. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize titlLabel;
@synthesize iconImgView;
@synthesize itemIndex;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self = (MenuCell*)[BFUitils viewFromNibWithName:@"MenuCell" owner:self];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [titlLabel release];
    [iconImgView release];
    [_lineView release];
    [super dealloc];
}
@end
