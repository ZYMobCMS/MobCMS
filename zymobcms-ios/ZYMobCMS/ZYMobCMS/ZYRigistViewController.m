//
//  ZYRigistViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYRigistViewController.h"
#import "ZYInputCell.h"
#import "ZYButtonCell.h"

@interface ZYRigistViewController ()

@end

@implementation ZYRigistViewController

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
    [sourceArray addObject:[NSArray arrayWithObjects:@"用户名:",@"loginName",@"请输入用户名",nil]];
    [sourceArray addObject:[NSArray arrayWithObjects:@"密码:",@"password",@"请输入密码",nil]];
    [sourceArray addObject:[NSArray arrayWithObjects:@"重复密码:",@"passwordCheck",@"请再次输入密码", nil]];
    
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44) style:UITableViewStyleGrouped];
    UIView *tableBack = [[UIView alloc]initWithFrame:CGRectMake(0,0,listTable.frame.size.width,listTable.frame.size.height)];
    listTable.backgroundView = tableBack;
    [tableBack release];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];
    
    //logo header
    ZYPullHeaderView *headView = [[ZYPullHeaderView alloc]
                                  initWithFrame:
                                  CGRectMake(0.0f, 0.0f - listTable.bounds.size.height, self.view.frame.size.width,listTable.bounds.size.height)];
    [listTable addSubview:headView];
    [headView release];

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
        NSString *rightString = @"注册说明:\n\n  1.用户名长度在0－20位之间，可以采用任意字符组合\n\n 2.密码长度在0－12位之间，可以采用任意字符组合\n";
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
        cell.tagLabel.adjustsFontSizeToFitWidth = YES;
        cell.inputField.placeholder = [[sourceArray objectAtIndex:indexPath.row]objectAtIndex:2];
        
        return cell;
        
    }else if(indexPath.section == 1){
        
        
        static NSString *CellIdentifier = @"Cell";
        ZYButtonCell *cell = (ZYButtonCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[ZYButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withTapOnBtn:^{
                [self rigistNewUser];
            }]autorelease];
        }
        [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        [cell.actionBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (!cell) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
            cell.textLabel.numberOfLines = 0;
        }
        NSString *rightString = @"注册说明:\n\n  1.用户名长度在0－20位之间，可以采用任意字符组合\n\n 2.密码长度在0－12位之间，可以采用任意字符组合\n";
        cell.textLabel.text = rightString;
        CGSize rightSize = [rightString sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(tableView.frame.size.width-30,99999)];
        cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x,cell.textLabel.frame.origin.y,rightSize.width,rightSize.height);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        
        return cell;
        
    }
}

#pragma mark - rigist
- (void)rigistNewUser
{
    [self startLoading];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZYInputCell *nameCell = (ZYInputCell*)[listTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    ZYInputCell *passwordCell = (ZYInputCell*)[listTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    [params setObject:nameCell.inputField.text forKey:@"loginName"];
    [params setObject:passwordCell.inputField.text forKey:@"password"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeRigist withParams:params withHelperDelegate:self withSuccessRequestMethod:@"rigistNewUserSuccess:" withFaildRequestMethod:@"rigistNewUserFaild:"];
}

- (void)rigistNewUserSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSLog(@"resultDict -->%@",resultDict);
        
    }
    [self stopLoading];
}

- (void)rigistNewUserFaild:(NSDictionary*)resultDict
{
    [self stopLoading];
}


@end
