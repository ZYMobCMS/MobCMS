//
//  ZYHotNewsCell.h
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didSelectArticle) (NSString *articleId);

@interface ZYHotNewsCell : UITableViewCell
{
    didSelectArticle _selectAction;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withSelectAction:(didSelectArticle)selectAction;

- (void)setContentArray:(NSArray*)contentArray;

@end
