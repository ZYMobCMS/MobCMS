//
//  ZYMenuViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMenuViewController.h"
#import "ZYCategoryViewController.h"

@interface ZYMenuViewController ()

@end

@implementation ZYMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    [menuArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    menuArray = [[NSMutableArray alloc]init];
    
    
    [self getMenuList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络数据
- (void)getMenuList{
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeMenuList withParams:nil withHelperDelegate:self withSuccessRequestMethod:@"getMenuListSuccess:" withFaildRequestMethod:@"getMenuListFaild:"];
    
    
}
- (void)getMenuListSuccess:(NSDictionary*)resultDict
{
    NSLog(@"menuList  ------>%@",resultDict);
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSArray *menuList = [resultDict objectForKey:@"data"];
        
        [menuArray addObjectsFromArray:menuList];
        
        [self buildModulesWithMenuList:menuArray];
    }
}
- (void)getMenuListFaild:(NSDictionary*)resultDict
{
    
}

- (void)buildModulesWithMenuList:(NSArray*)menuList
{
    NSMutableArray *buildControllers = [NSMutableArray array];
    for (int i=0; i<menuList.count;i++) {
        
        NSDictionary *item = [menuList objectAtIndex:i];
        BOOL isCategoryType = [[item objectForKey:@"is_category"]boolValue];
        
        if (isCategoryType) {
            
            ZYCategoryViewController *newCategoryVC = [[ZYCategoryViewController alloc]init];
            newCategoryVC.categoryId = [item objectForKey:@"id"];
            newCategoryVC.title = [item objectForKey:@"name"];
            [newCategoryVC refreshContent];
            
            UINavigationController *categroyNav = [[UINavigationController alloc]initWithRootViewController:newCategoryVC];
            [buildControllers addObject:categroyNav];
            categroyNav.title = [item objectForKey:@"name"];
            
            [newCategoryVC release];
            [categroyNav release];
        }else{
            
            NSInteger moduleId = [[item objectForKey:@"id"]intValue];
            
            switch (moduleId) {
                case 1:
                {
                    
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
    }
    self.viewControllers = buildControllers;
    
}

@end
