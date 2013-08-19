//
//  BFNMenuViewController.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNMenuViewController.h"
#import "MenuCell.h"
#import "SystemCell.h"
#import "BFNMenuHeaderView.h"

#define ApplicationNameUDF @"ApplicationNameUDF"

@interface BFNMenuViewController ()

@end

@implementation BFNMenuViewController
@synthesize tableBasicData, tableSysData, menuTableView;
@synthesize selectVCIndexPath;
@synthesize lastSelectIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //存放上层内容性质视图
        if (!viewControllers) {
            viewControllers = [[NSMutableArray alloc]init];
        }
        
        //存放系统设置类视图
        if (!sysViewControllers) {
            sysViewControllers = [[NSMutableArray alloc]init];
        }
        
        //功能标题
        self.tableBasicData = [[NSMutableArray alloc]initWithCapacity:0];
        
        //系统设置标题
        self.tableSysData = [[NSMutableArray alloc]initWithCapacity:0];
        
        //选中视图
        self.selectVCIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        
    }
    return self;
}

- (void)dealloc
{
    self.tableBasicData = nil;
    self.tableSysData = nil;
    self.selectVCIndexPath = nil;
    
    [sysViewControllers release];
    [viewControllers release];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //标题
    titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0,0,self.view.frame.size.width,42);
    titleLabel.text = @"  通用移动内容管理";
    titleLabel.backgroundColor = [BFUitils rgbColor:226 green:226 blue:226];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [BFUitils rgbColor:158 green:38 blue:40];
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    //分割线
    UIImageView *spLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,titleLabel.frame.origin.y+titleLabel.frame.size.height, self.view.frame.size.width,2)];
    spLine.image = [UIImage imageNamed:@"menu_line.png"];
    [self.view addSubview:spLine];
    [spLine release];
    
    //初始化
    menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,titleLabel.frame.size.height+2,self.view.frame.size.width,self.view.frame.size.height-titleLabel.frame.size.height-2) style:UITableViewStylePlain];
    menuTableView.delegate = self;
    menuTableView.dataSource = self;
    menuTableView.backgroundColor = [BFUitils rgbColor:226 green:226 blue:226];
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:menuTableView];
    [menuTableView release];
    
    [self getApplicationName];
    
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observeLoginSuccessNoti:) name:ZYCMS_LOGIN_SUCESS_NOTI object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回当前选中视图
- (UIViewController*)currentVC
{
    ZYMobCMSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    UIViewController *sVC = [self viewControllerForIndexPath:self.selectVCIndexPath];
    
    appDelegate.rootViewController.openTouchRecieve = YES;
    
    
    return sVC;
}

- (UIViewController*)viewControllerForIndexPath:(NSIndexPath*)indexPath
{
    UIViewController *sVC = nil;
    
    if (viewControllers.count == 0 && sysViewControllers.count == 0) {
        
        UIViewController *defaultController = [[[UIViewController alloc]init]autorelease];
        defaultController.view.backgroundColor = [UIColor whiteColor];
        defaultController.title = @"";
        [ZYMobCMSUitil setNavItem:defaultController];
        return defaultController;
        
    }
    
    if (self.tableSysData.count > 0 && self.tableBasicData.count > 0) {
        switch (indexPath.section) {
            case 0:
            {
                sVC = [viewControllers objectAtIndex:indexPath.row];
            }
                break;
            case 1:
            {
                
                sVC = [sysViewControllers objectAtIndex:indexPath.row];
            }
                break;
            default:
                sVC = nil;
                break;
        }
    }else if (self.tableBasicData.count >0 && self.tableSysData.count == 0) {
        sVC = [viewControllers objectAtIndex:indexPath.row];
    }else if (self.tableSysData.count > 0 && self.tableBasicData.count == 0) {
        sVC = [sysViewControllers objectAtIndex:indexPath.row];
    }
    return sVC;
}

#pragma mark - 当前该选中哪个视图
- (void)shouldSelectVCAtSection:(NSInteger)section rowIndex:(NSInteger)index
{
    self.lastSelectIndexPath = self.selectVCIndexPath;
    
    
    self.selectVCIndexPath = [NSIndexPath indexPathForRow:index inSection:section];
    
    NSInteger itemIndexLast;
    if (lastSelectIndexPath.section == 0) {
        itemIndexLast = [[[tableBasicData objectAtIndex:self.lastSelectIndexPath.row]objectAtIndex:2]intValue];
    }else{
        itemIndexLast = [[[tableSysData objectAtIndex:self.lastSelectIndexPath.row]objectAtIndex:1]intValue];
    }
    MenuCell *selectCellLast = (MenuCell*)[menuTableView cellForRowAtIndexPath:self.lastSelectIndexPath];
    selectCellLast.iconImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu_item_%d.png",itemIndexLast]];
    
    NSInteger itemIndex;
    if (selectVCIndexPath.section == 0) {
        itemIndex = [[[tableBasicData objectAtIndex:self.selectVCIndexPath.row]objectAtIndex:2]intValue];
    }else{
        itemIndex = [[[tableSysData objectAtIndex:self.selectVCIndexPath.row]objectAtIndex:1]intValue];
    }
    MenuCell *selectCell = (MenuCell*)[menuTableView cellForRowAtIndexPath:selectVCIndexPath];
    selectCell.iconImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu_item_%d_selected.png",itemIndex]];
    
    
    
    ZYMobCMSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    UIViewController *currentVC = [self currentVC];
    
    //不可以为空
    if (currentVC == nil) {
        return;
    }
    
    appDelegate.rootViewController.detailViewController = nil;
    
    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:currentVC];
    
    if ([BFUitils isIOSVersionOver5]) {
        [newNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
    }else {
        [newNav.navigationBar drawRect:newNav.navigationBar.frame];
    }
    newNav.view.frame = appDelegate.rootViewController.view.frame;
    appDelegate.rootViewController.detailViewController = newNav;
    [newNav release];
    
    [appDelegate hiddenMaster];
}

#pragma mark - 获取菜单
- (NSArray*)orderMenuItemWithArray:(NSArray*)menuData
{
    return [menuData sortedArrayUsingComparator:^NSComparisonResult(NSDictionary*item1,NSDictionary*item2){
        
        NSInteger orderNum1 = [[item1 objectForKey:@"index"]intValue];
        NSInteger orderNum2 = [[item2 objectForKey:@"index"]intValue];
        
        int result = orderNum1 - orderNum2;
        
        return result < 0 ? NSOrderedAscending : result > 0 ? NSOrderedDescending : NSOrderedSame;
        
    }];
}

//根据排序数组，返回功能数组

- (NSString*)featureCodeToClassName:(NSInteger)code
{
    NSString *className = nil;
    switch (code) {
        case 13:
            className = @"ZYPictureController";
            break;
        case 14:
            className = @"ZYProductViewController";
            break;
        case 15:
            className = @"ZYCommentViewController";
            break;
        case 16:
            className = @"ZYSettingViewController";
            break;
            
        default:
            className = nil;
            break;
    }
    return className;
}

- (NSArray*)returnFeatureClassArrayWithSortArray:(NSArray*)sortArray
{
    NSMutableArray *featureClassArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i=0; i<sortArray.count; i++) {
        
        NSDictionary *item = [sortArray objectAtIndex:i];
        
        NSInteger featureCode = [[item objectForKey:@"id"]intValue];
        
        NSString *featureName = [item objectForKey:@"name"];
        
        NSString *isCategory = [item objectForKey:@"is_category"];
        
        if ([isCategory intValue]==1) {
            
            NSMutableArray *itemArray = [NSMutableArray arrayWithObject:@"ZYCategoryViewController"];
            [itemArray addObject:featureName];
            [itemArray addObject:[item objectForKey:@"id"]];
            [itemArray addObject:isCategory];
            [featureClassArray addObject:itemArray];
            
            continue;
        }
        
        if ([self featureCodeToClassName:featureCode]!=nil) {
            
            NSMutableArray *itemArray = [NSMutableArray arrayWithObject:[self featureCodeToClassName:featureCode]];
            [itemArray addObject:featureName];
            [itemArray addObject:[item objectForKey:@"id"]];
            [itemArray addObject:isCategory];
            [featureClassArray addObject:itemArray];
            
        }
    }
    
    return featureClassArray;
}



- (void)buildFeaturePagesWithFeatureClassArray:(NSArray*)featureArray
{
    for (int i=0; i<featureArray.count; i++) {
        
        NSArray *itemArray = [featureArray objectAtIndex:i];
        
        if ([[itemArray objectAtIndex:0]isEqualToString:@"ZYCategoryViewController"]) {
            
            ZYCategoryViewController *newCategory = [[ZYCategoryViewController alloc]init];
            newCategory.categoryId = [itemArray objectAtIndex:2];
            newCategory.mainTitle = [itemArray objectAtIndex:1];
            [ZYMobCMSUitil setBFNNavItemForMenu:newCategory];
            [viewControllers addObject:newCategory];
            [newCategory release];
            
        }
        
        if ([[itemArray objectAtIndex:0]isEqualToString:@"ZYPictureController"]) {
            
            ZYPictureController *pictureController = [[ZYPictureController alloc]init];
            pictureController.mainTitle = [itemArray objectAtIndex:1];
            [ZYMobCMSUitil setBFNNavItemForMenu:pictureController];
            [viewControllers addObject:pictureController];
            [pictureController release];
            
        }
        
        if ([[itemArray objectAtIndex:0]isEqualToString:@"ZYProductViewController"]) {
            
            ZYProductViewController *productVC = [[ZYProductViewController alloc]init];
            productVC.mainTitle = [itemArray objectAtIndex:1];
            [ZYMobCMSUitil setBFNNavItemForMenu:productVC];
            [viewControllers addObject:productVC];
            [productVC release];
            
        }
        
        if ([[itemArray objectAtIndex:0]isEqualToString:@"ZYCommentViewController"]) {

            ZYCommentViewController *commentVC = [[ZYCommentViewController alloc]init];
            commentVC. mainTitle = [itemArray objectAtIndex:1];
            [ZYMobCMSUitil setBFNNavItemForMenu:commentVC];
            [viewControllers addObject:commentVC];
            [commentVC release];
            
        }

        if ([[itemArray objectAtIndex:0]isEqualToString:@"ZYSettingViewController"]) {
            
            if ([ZYUserManager userIsLogined]) {
                ZYAccountViewController *acountVC = [[ZYAccountViewController alloc]init];
                acountVC.mainTitle = @"账号管理";
                [sysViewControllers addObject:acountVC];
                [ZYMobCMSUitil setBFNNavItemForMenu:acountVC];
                [acountVC release];
            }else{
                ZYLoginViewController *LoginVC = [[ZYLoginViewController alloc]init];
                LoginVC.mainTitle = @"账号管理";
                [LoginVC setSuccessLoginAction:^{
                    ZYMobCMSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
                    
                    ZYAccountViewController *accoutVC = [[ZYAccountViewController alloc]init];
                    accoutVC.mainTitle = @"账号管理";
                    [ZYMobCMSUitil setBFNNavItemForMenu:accoutVC];
                    
                    appDelegate.rootViewController.detailViewController = nil;
                    
                    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:accoutVC];
                    [accoutVC release];
                    
                    if ([BFUitils isIOSVersionOver5]) {
                        [newNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
                    }else {
                        [newNav.navigationBar drawRect:newNav.navigationBar.frame];
                    }
                    newNav.view.frame = appDelegate.rootViewController.view.frame;
                    appDelegate.rootViewController.detailViewController = newNav;
                    [newNav release];
                    
                    [appDelegate hiddenMaster];
                }];
                [sysViewControllers addObject:LoginVC];
                [ZYMobCMSUitil setBFNNavItemForMenu:LoginVC];
                [LoginVC release];
            }
            
            
            ZYAboutViewController *aboutVC = [[ZYAboutViewController alloc]init];
            aboutVC.mainTitle = @"关于我们";
            [ZYMobCMSUitil setBFNNavItemForMenu:aboutVC];
            [sysViewControllers addObject:aboutVC];
            [aboutVC release];
            
        }
        

        // TODO
    }
}

- (void)buildMenuTitleArrayWithFeatureArray:(NSArray*)featureArray
{
    for (int i=0; i<featureArray.count; i++) {
        
        NSArray *itemArray = [featureArray objectAtIndex:i];
        
        if ([[itemArray objectAtIndex:0]isEqualToString:@"ZYSettingViewController"]) {
            
            NSArray *about = [NSArray arrayWithObjects:@"关于我们",@"17",nil];
            NSArray *account = [NSArray arrayWithObjects:@"账号管理",@"18",nil];
            
            [self.tableSysData addObject:account];
            [self.tableSysData addObject:about];

            
        }else {
            [self.tableBasicData addObject:itemArray];
        }
        
    }
    
}


- (void)getMenuSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"] boolValue];
    if (status) {
        
        //        NSLog(@"get menu data ====>%@",[resultDict objectForKey:@"data"]);
        
        //category类型
        NSArray *categoryArray  = [[resultDict objectForKey:@"data"]objectForKey:@"category"];
        NSArray *notcategoryArray = [[resultDict objectForKey:@"data"]objectForKey:@"notcategory"];
        
        NSArray *categorySortArray = [self orderMenuItemWithArray:categoryArray];
        NSArray *notcategorySortArray = [self orderMenuItemWithArray:notcategoryArray];
        
        if (categoryArray.count != 0 || notcategoryArray.count != 0) {
            
            NSMutableArray *featureArray = [NSMutableArray array];
            NSArray *categoryFeatureArray = [self returnFeatureClassArrayWithSortArray:categorySortArray];
            [featureArray addObjectsFromArray:categoryFeatureArray];
            NSArray *notCategoryFeatureArray = [self returnFeatureClassArrayWithSortArray:notcategorySortArray];
            [featureArray addObjectsFromArray:notCategoryFeatureArray];
            
            [self buildMenuTitleArrayWithFeatureArray:featureArray];
            
            [self buildFeaturePagesWithFeatureClassArray:featureArray];
            
            [menuTableView reloadData];
            
            [self shouldSelectVCAtSection:0 rowIndex:0];
            
        }else {
            
            //没有获取到，就留一个退出
            NSArray *account = [NSArray arrayWithObjects:@"账号管理",@"18",nil];
            [self.tableSysData addObject:account];
            
            [menuTableView reloadData];
            
            ZYMobCMSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
            
            [appDelegate showMaster];
            
        }
        
    }
    
}
- (void)getMenuFaild:(NSDictionary*)resultDict
{
    //没有获取到，就留一个退出
    NSArray *account = [NSArray arrayWithObjects:@"账号管理",@"18",nil];
    [self.tableSysData addObject:account];
    
    [menuTableView reloadData];
    
    ZYMobCMSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    [appDelegate showMaster];
        
}
- (void)getMenuDataNow
{
    [[BFNetWorkHelper shareHelper] requestDataWithApplicationType:ZYCMSRequestTypeMenuList
                                                       withParams:nil
                                               withHelperDelegate:self
                                         withSuccessRequestMethod:@"getMenuSuccess:"
                                           withFaildRequestMethod:@"getMenuFaild:"];
    
}

#pragma mark - 退出后默认恢复为选中首页
- (void)reservToHomePage
{
    if (self.tableSysData.count > 0) {
        
        [self.tableSysData removeAllObjects];
        
        if (sysViewControllers.count > 0) {
            [sysViewControllers removeAllObjects];
        }
    }
    
    if (self.tableBasicData.count > 0) {
        [self.tableBasicData removeAllObjects];
        
        if (viewControllers.count > 0 ) {
            [viewControllers removeAllObjects];
        }
    }
    [self shouldSelectVCAtSection:0 rowIndex:0];
}

#pragma makr - 获取新的应用权限
- (void)tryGetNewApplicationRights
{
    [self getMenuDataNow];
}

#pragma mark - tableViewDelegate and tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.tableBasicData.count > 0 && self.tableSysData.count > 0) {
        return 2;
    }else {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableBasicData.count > 0 && self.tableSysData.count > 0) {
        
        if (section == 0) {
            return [self.tableBasicData count];
        }else if(section == 1){
            return [self.tableSysData count];
        }else {
            return 0;
        }
        
    }else if(self.tableBasicData.count > 0 && self.tableSysData.count == 0){
        
        return [self.tableBasicData count];
    }else if(self.tableBasicData.count == 0 && self.tableSysData.count > 0){
        
        return [self.tableSysData count];
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.tableBasicData.count > 0) {
        
        if (indexPath.section == 0) {
            
            static NSString *CustomCellIdentifier = @"MenuCellIdentify";
            MenuCell *cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
            if (cell == nil){
                
                cell = [[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
                cell.iconImgView.frame = CGRectMake(20,9.5,21,21);
                cell.lineView.image = [UIImage imageNamed:@"menu_line.png"];
                cell.lineView.frame = CGRectMake(0,38,320,2);
                cell.titlLabel.highlightedTextColor = [UIColor blackColor];
                cell.titlLabel.textColor = [UIColor blackColor];
                cell.titlLabel.font = [UIFont systemFontOfSize:17];
                CGRect oldTitleFrame = cell.titlLabel.frame;
                cell.titlLabel.frame = CGRectMake(oldTitleFrame.origin.x,oldTitleFrame.origin.y-2.5,oldTitleFrame.size.width,oldTitleFrame.size.height);

                UIImageView *cellNormalBack = [[UIImageView alloc]init];
                cellNormalBack.backgroundColor = [BFUitils rgbColor:246 green:246 blue:246];
                cell.selectedBackgroundView = cellNormalBack;
                [cellNormalBack release];
            }
            
            NSArray *configArray = [self.tableBasicData objectAtIndex:indexPath.row];
    
            cell.iconImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu_item_%d.png",[[configArray objectAtIndex:2]intValue]]];            
            cell.titlLabel.text = [configArray objectAtIndex:1];
            
            return cell;
            
            
        }else {
            
            if (self.tableSysData.count > 0) {
                static NSString *CustomCellIdentifier = @"SysCellIdentify";
                MenuCell *cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
                if (cell == nil)
                {
                    cell = [[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
                    cell.titlLabel.textColor = [UIColor blackColor];
                    cell.titlLabel.highlightedTextColor = [UIColor blackColor];
                    cell.titlLabel.font = [UIFont systemFontOfSize:17];
                    cell.iconImgView.frame = CGRectMake(20,9.5,21,21);
                    cell.lineView.frame = CGRectMake(0,38,320,2);
                    CGRect oldTitleFrame = cell.titlLabel.frame;
                    cell.titlLabel.frame = CGRectMake(oldTitleFrame.origin.x,oldTitleFrame.origin.y-2.5,oldTitleFrame.size.width,oldTitleFrame.size.height);
                    
                    UIImageView *cellNormalBack = [[UIImageView alloc]init];
                    cellNormalBack.backgroundColor = [BFUitils rgbColor:246 green:246 blue:246];
                    cell.selectedBackgroundView = cellNormalBack;
                    [cellNormalBack release];
                    cell.lineView.image = [UIImage imageNamed:@"menu_line.png"];
                }
                cell.titlLabel.text = [[self.tableSysData objectAtIndex:indexPath.row]objectAtIndex:0];
                NSString *imageName = [NSString stringWithFormat:@"menu_item_%d.png",[[[self.tableSysData objectAtIndex:indexPath.row]objectAtIndex:1] intValue]];
                cell.iconImgView.image = [UIImage imageNamed:imageName];
                
                return cell;
                
            }else {
                return nil;
            }
        }
        
    }else {
        
        if (self.tableSysData.count > 0) {
            static NSString *CustomCellIdentifier = @"SysCellIdentify";
            MenuCell *cell = (MenuCell*)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
            if (cell == nil)
            {
                cell = [[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
                cell.titlLabel.textColor = [UIColor blackColor];
                cell.titlLabel.highlightedTextColor = [UIColor blackColor];
                cell.titlLabel.font = [UIFont systemFontOfSize:17];
                cell.lineView.frame = CGRectMake(0,38,320,2);
                cell.iconImgView.frame = CGRectMake(20,9.5,21,21);
                CGRect oldTitleFrame = cell.titlLabel.frame;
                cell.titlLabel.frame = CGRectMake(oldTitleFrame.origin.x,oldTitleFrame.origin.y-2.5,oldTitleFrame.size.width,oldTitleFrame.size.height);
                
                UIImageView *cellNormalBack = [[UIImageView alloc]init];
                cellNormalBack.backgroundColor = [BFUitils rgbColor:246 green:246 blue:246];
                cell.selectedBackgroundView = cellNormalBack;
                [cellNormalBack release];
                
                cell.lineView.image = [UIImage imageNamed:@"menu_line.png"];

            }
            cell.titlLabel.text = [[self.tableSysData objectAtIndex:indexPath.row]objectAtIndex:0];
            NSString *imageName = [NSString stringWithFormat:@"menu_item_%d.png",[[[self.tableSysData objectAtIndex:indexPath.row]objectAtIndex:1] intValue]];
            cell.iconImgView.image = [UIImage imageNamed:imageName];
            
            return cell;
        }else {
            return nil;
        }
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableSysData.count > 1 && self.tableBasicData.count == 0 && section == 0) {
        
        BFNMenuHeaderView *label = [[[BFNMenuHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)]autorelease];
        [label setBackgroundColor:[BFUitils rgbColor:226 green:226 blue:226]];
        UIImage *line = [UIImage imageNamed:@"menu_line.png"];
        label.bottomLine.image = line;
        label.bottomLine.hidden = NO;

        label.titleLabel.text = @"    设置";

        return label;
        
    }else if(self.tableSysData.count > 0 && self.tableBasicData.count > 0 && section == 1) {
        BFNMenuHeaderView *label = [[[BFNMenuHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)]autorelease];
        UIImage *line = [UIImage imageNamed:@"menu_line.png"];
        label.bottomLine.image = line;
        label.bottomLine.hidden = NO;
        [label setBackgroundColor:[BFUitils rgbColor:226 green:226 blue:226]];
        label.titleLabel.text = @"    设置";

        return label;
    }else if(self.tableSysData.count > 0 && self.tableBasicData.count > 0 && section == 0){
        BFNMenuHeaderView *label = [[[BFNMenuHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)]autorelease];
        UIImage *line = [UIImage imageNamed:@"menu_line.png"];
        label.bottomLine.image = line;
        label.bottomLine.hidden = NO;
        [label setBackgroundColor:[BFUitils rgbColor:226 green:226 blue:226]];
        label.titleLabel.text = @"    功能";
    
        return label;
        
    }else{
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tableSysData.count > 1 && self.tableBasicData.count == 0 && section == 0) {
        return 45.f;
    }else if(self.tableSysData.count > 0 && self.tableBasicData.count > 0) {
        return 45.0f;
    }else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self shouldSelectVCAtSection:indexPath.section rowIndex:indexPath.row];
    
}

#pragma mark - 获取应用程序名字
- (void)getApplicationName
{
    [[BFNetWorkHelper shareHelper] requestDataWithApplicationType:ZYCMSRequestTypeApplicationName
                                                       withParams:nil
                                               withHelperDelegate:self
                                         withSuccessRequestMethod:@"getApplicationNameSuccess:"
                                           withFaildRequestMethod:@"getApplicationNameFaild:"];
}
- (void)getApplicationNameSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSDictionary *appDict = [resultDict objectForKey:@"data"];
        
        titleLabel.text = [NSString stringWithFormat:@"   %@",[appDict objectForKey:@"name"]];
        
        if (titleLabel.text) {
            [[NSUserDefaults standardUserDefaults]setObject:titleLabel.text forKey:ApplicationNameUDF];
        }else{
            if ([[NSUserDefaults standardUserDefaults]objectForKey:ApplicationNameUDF]) {
                titleLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:ApplicationNameUDF];
            }else{
                titleLabel.text = @"ZYProSoft移动内容管理";
            }
        }
        
        
    }else{
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:ApplicationNameUDF]) {
            titleLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:ApplicationNameUDF];
        }else{
            titleLabel.text = @"ZYProSoft移动内容管理";
        }
    }
}
- (void)getApplicationNameFaild:(NSDictionary*)resultDict
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:ApplicationNameUDF]) {
        titleLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:ApplicationNameUDF];
    }else{
        titleLabel.text = @"ZYProSoft移动内容管理";
    }
}

#pragma mark - 监视登陆成功
- (void)observeLoginSuccessNoti:(NSNotification*)noti
{
    [sysViewControllers removeObjectAtIndex:0];
    ZYAccountViewController *acountVC = [[ZYAccountViewController alloc]init];
    acountVC.mainTitle = @"账号管理";
    [sysViewControllers insertObject:acountVC atIndex:0];
    [ZYMobCMSUitil setBFNNavItemForMenu:acountVC];
    [acountVC release];
}


@end
