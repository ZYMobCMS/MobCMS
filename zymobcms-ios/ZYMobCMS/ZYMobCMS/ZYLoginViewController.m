//
//  ZYLoginViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYLoginViewController.h"
#import "ZYInputCell.h"
#import "ZYButtonCell.h"
#import "ZYRigistViewController.h"
#import "ZYAccountViewController.h"

@interface ZYLoginViewController ()

@end

@implementation ZYLoginViewController

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
    [sourceArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    sourceArray = [[NSMutableArray alloc]init];
    [sourceArray addObject:[NSArray arrayWithObjects:@"账号:",@"loginName",@"请输入用户名",nil]];
    [sourceArray addObject:[NSArray arrayWithObjects:@"密码:",@"password",@"请输入密码",nil]];
    
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44) style:UITableViewStyleGrouped];
    UIView *tableBack = [[UIView alloc]initWithFrame:CGRectMake(0,0,listTable.frame.size.width,listTable.frame.size.height)];
    listTable.backgroundView = tableBack;
    [tableBack release];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];
    
    //跟贴
    UIButton *oveaSeaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oveaSeaBtn.frame = CGRectMake(0,0,60,30);
    oveaSeaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [oveaSeaBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"top_button.png"] forState:UIControlStateNormal];
    [oveaSeaBtn setTitle:@"注册" forState:UIControlStateNormal];
    [oveaSeaBtn addTarget:self action:@selector(rigistAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:oveaSeaBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0) {
        return [sourceArray count];
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44.0f;
    }else if(indexPath.section == 1){
        return 44.0f;
    }else{
        NSString *rightString = @"注册享受更多用户功能和体验哦!\n\n 你可以评论你想评论的任何一篇文章或者咨询;\n\n 你只需要轻轻一点，就能将你喜爱的东西收入库中;\n\n 还在等什么，赶快加入我们吧。";
        CGSize rightSize = [rightString sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(tableView.frame.size.width-30,99999)];
        
        return rightSize.height;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30.0f;
    }else{
        return 0.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"Cell";
        ZYInputCell *cell = (ZYInputCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (!cell) {
            cell = [[[ZYInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        }
        cell.tagLabel.text = [[sourceArray objectAtIndex:indexPath.row]objectAtIndex:0];
        cell.inputField.placeholder = [[sourceArray objectAtIndex:indexPath.row]objectAtIndex:2];
        
        return cell;

    }else if(indexPath.section == 1){
        
        
        static NSString *CellIdentifier = @"Cell";
        ZYButtonCell *cell = (ZYButtonCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[ZYButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withTapOnBtn:^{
                [self loginUserNow];
            }]autorelease];
        }
        [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        [cell.actionBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
        
        return cell;
        
    }else{
       
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (!cell) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
            cell.textLabel.numberOfLines = 0;
        }
        NSString *rightString = @"注册享受更多用户功能和体验哦!\n\n 你可以评论你想评论的任何一篇文章或者咨询;\n\n 你只需要轻轻一点，就能将你喜爱的东西收入库中;\n\n 还在等什么，赶快加入我们吧。";
        cell.textLabel.text = rightString;
        CGSize rightSize = [rightString sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(tableView.frame.size.width-30,99999)];
        cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x,cell.textLabel.frame.origin.y,rightSize.width,rightSize.height);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        
        return cell;

    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 75;
//    }
//}

- (void)rigistAction
{
    ZYRigistViewController *rigistVC = [[ZYRigistViewController alloc]init];
    rigistVC.mainTitle = @"注册新用户";
    [ZYMobCMSUitil setBFNNavItemForReturn:rigistVC];
    
    [self.navigationController pushViewController:rigistVC animated:YES];
    [rigistVC release];
}

#pragma mark - login action
- (void)loginUserNow
{
    [self startLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZYInputCell *nameCell = (ZYInputCell*)[listTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ZYInputCell *passwordCell = (ZYInputCell*)[listTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [nameCell.inputField resignFirstResponder];
    [passwordCell.inputField resignFirstResponder];
    
    [params setObject:nameCell.inputField.text forKey:@"loginName"];
    [params setObject:passwordCell.inputField.text forKey:@"password"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeLogin withParams:params withHelperDelegate:self withSuccessRequestMethod:@"loginSuccess:" withFaildRequestMethod:@"loginFaild:"];

}
- (void)loginSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSLog(@"resultDict -->%@",resultDict);
        
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
        
    }
    [self stopLoading];
}
- (void)loginFaild:(NSDictionary*)resultDict
{
    [self stopLoading];
}

@end
