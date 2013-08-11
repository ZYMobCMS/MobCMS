//
//  BFNBarCustomView.h
//  PPFIphone
//
//  Created by ZYVincent on 13-6-27.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFNBarButton.h"

@interface BFNBarCustomView : UIView
{
    
}

- (id)initWithRootItemButton:(BFNBarButton*)rootItem withFrame:(CGRect)frame;

- (void)insertNewItemButton:(BFNBarButton*)newItem;

@end
