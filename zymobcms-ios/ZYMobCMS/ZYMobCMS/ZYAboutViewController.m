//
//  ZYAboutViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYAboutViewController.h"
#import "ZYAboutCell.h"

@interface ZYAboutViewController ()

@end

@implementation ZYAboutViewController

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
    
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44) style:UITableViewStyleGrouped];
    UIView *tableBack = [[UIView alloc]initWithFrame:CGRectMake(0,0,listTable.frame.size.width,listTable.frame.size.height)];
    listTable.backgroundView = tableBack;
    [tableBack release];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];

    [self getAboutInfo];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [sourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [ZYAboutCell heightForDict:[sourceArray objectAtIndex:indexPath.row] forTable:tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ZYAboutCell *cell = (ZYAboutCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[ZYAboutCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    [cell setContentDict:[sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - 获取关于信息
- (void)getAboutInfo
{
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeAbout  withParams:nil withHelperDelegate:self withSuccessRequestMethod:@"getAboutInfoSuccess:" withFaildRequestMethod:@"getAboutInfoFaild:"];
}

- (void)getAboutInfoSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        [sourceArray addObjectsFromArray:[resultDict objectForKey:@"data"]];
        [listTable reloadData];
        
    }else{
        
        
    }
}

- (void)getAboutInfoFaild:(NSDictionary*)resultDict
{
    
}


@end
