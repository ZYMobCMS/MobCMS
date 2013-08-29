//
//  ZYHotNewsCell.h
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didSelectArticle) (NSDictionary *articleItem);

@interface ZYHotNewsCell : UITableViewCell<UIScrollViewDelegate>
{
    didSelectArticle _selectAction;
    
    NSMutableArray *mContentArray;
    
    UIScrollView *bScrollView;
    UIPageControl *pageControl;
    
    UILabel *titleLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withSelectAction:(didSelectArticle)selectAction;

- (void)setContentArray:(NSArray*)contentArray;
- (void)setImageInfo:(NSArray *)contentArray;

@end
