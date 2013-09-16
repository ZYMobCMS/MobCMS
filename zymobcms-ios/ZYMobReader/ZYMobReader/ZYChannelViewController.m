//
//  ZYChannelViewController.m
//  ZYMobReader
//
//  Created by barfoo2 on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYChannelViewController.h"

@interface ZYChannelViewController ()

@end

@implementation ZYChannelViewController
@synthesize menuItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    self.menuItem = nil;
    [newsDataCenter release];
    [pictureDataCenter release];
    [productDataCenter release];
    [listArray release];
    [super dealloc];
}

- (id)initWithMenuItem:(ZYMenuItemModel *)mItem
{
    if (self = [super init]) {
        
        newsDataCenter = [[ZYNewsDataCenter alloc]init];
        pictureDataCenter = [[ZYPictureDataCenter alloc]init];
        productDataCenter = [[ZYProductDataCenter alloc]init];
        listArray = [[NSMutableArray alloc]init];
        currentPageIndex = 1;
        
        self.menuItem = menuItem;
        
        switch ([self.menuItem.moduleId intValue]) {
            case 1:
            {
                [newsDataCenter setGetNewsListSuccessAction:^(NSArray *modelArray) {
                    currentPageIndex++;
                    [listArray addObjectsFromArray:modelArray];
                    if (currentPageIndex<2) {
                       [newsDataCenter startGetNewsListWithPageIndex:currentPageIndex withCategoryId:self.menuItem.categoryId withTabTypeId:self.menuItem.tabTypeId];
                    }
                    NSLog(@"listArray -->%@",listArray);
                }];
                [newsDataCenter setGetNewsListFaildAction:^(NSString *errMsg) {
                    [SVProgressHUD showErrorWithStatus:errMsg];
                }];
                [newsDataCenter startGetNewsListWithPageIndex:currentPageIndex withCategoryId:self.menuItem.categoryId withTabTypeId:self.menuItem.tabTypeId];
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            default:
                break;
        }
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
