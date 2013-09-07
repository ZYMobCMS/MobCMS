//
//  ZYMenuViewController.m
//  ZYMobCMS
//
//  Created by barfoo2 on 13-8-2.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYMenuViewController.h"
#import "ZYCategoryViewController.h"
#import "MenuCell.h"

@interface ZYMenuViewController ()

@end

@implementation ZYMenuViewController
@synthesize selectIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    self.selectIndexPath = nil;
    [menuArray release];
    [viewControllers release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    menuArray = [[NSMutableArray alloc]init];
    viewControllers = [[NSMutableArray alloc]init];
    
    [self getMenuList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"MenuCellIdentify";
    MenuCell *cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil){
        
        cell = [[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
        cell.titlLabel.textColor = [UIColor blackColor];
    }
    
    NSDictionary *item = [menuArray objectAtIndex:indexPath.row];
    
    cell.titlLabel.text = [item objectForKey:@"name"];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self shouldSelectViewControllerAtIndexPath:indexPath];
}


#pragma mark - 网络数据
- (void)getMenuList{
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeMenuList withParams:nil withHelperDelegate:self withSuccessRequestMethod:@"getMenuListSuccess:" withFaildRequestMethod:@"getMenuListFaild:"];
    
    
}
- (void)getMenuListSuccess:(NSDictionary*)resultDict
{
//    NSLog(@"menuList  ------>%@",resultDict);
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSArray *menuList = [resultDict objectForKey:@"data"];
        
        [menuArray addObjectsFromArray:menuList];
        
        [self buildModulesWithMenuList:menuArray];
        
        //reload data
        [self.tableView reloadData];
        self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self shouldSelectViewControllerAtIndexPath:self.selectIndexPath];
    }
}
- (void)getMenuListFaild:(NSDictionary*)resultDict
{
    
}

- (void)buildModulesWithMenuList:(NSArray*)menuList
{
    for (int i=0; i<menuList.count;i++) {
        
        NSDictionary *item = [menuList objectAtIndex:i];
        BOOL isCategoryType = [[item objectForKey:@"is_category"]boolValue];
        
        if (isCategoryType) {
            
            ZYCategoryViewController *newCategoryVC = [[ZYCategoryViewController alloc]init];
            newCategoryVC.categoryId = [item objectForKey:@"id"];
            newCategoryVC.title = [item objectForKey:@"name"];
            [newCategoryVC refreshContent];
            
            
            UINavigationController *categroyNav = [[UINavigationController alloc]initWithRootViewController:newCategoryVC];
            [viewControllers addObject:categroyNav];
            categroyNav.title = [item objectForKey:@"name"];
            [ZYMobCMSUitil setNavItem:newCategoryVC];

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
}

- (UIViewController*)viewControllerForIndexPath:(NSIndexPath*)indexPath
{
    return [viewControllers objectAtIndex:indexPath.row];
}

- (UIViewController *)currentViewController
{
   return [self viewControllerForIndexPath:self.selectIndexPath];
}

- (void)shouldSelectViewControllerAtIndexPath:(NSIndexPath*)selectPath
{
    self.selectIndexPath = selectPath;
    
    ZYMobCMSAppDelegate *appDelegate = (ZYMobCMSAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    appDelegate.rootViewController.detailViewController = [self currentViewController];
    [appDelegate hiddenMaster];
}
@end
