//
//  CommentListViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "CommentListViewController.h"
#import "ArticleCommentCell.h"
#import "BFNLeftNavBarItem.h"

#define PageSize 10

@interface CommentListViewController ()

@end

@implementation CommentListViewController
@synthesize articleId;
@synthesize sourceArray;
@synthesize listTable;
@synthesize pageIndex;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)dealloc
{
    self.articleId = nil;
    self.sourceArray= nil;
    [super dealloc];
}

- (id)initWithArticleId:(NSString *)aId
{
    if (self = [super init]) {
        
        sourceArray = [[NSMutableArray alloc]init];
        
        self.articleId = aId;
        
        if (self.articleId) {
            [self getCommentList];
        }
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    
    self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-106*2/6)];
    self.listTable.dataSource = self;
    self.listTable.delegate = self;
    [self.view addSubview:self.listTable];
    [self.listTable release];
    
    //add commentBAr
    commentBar = [[ZYCommentBar alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-106*2/6-44,self.view.frame.size.width, 106*2/6) withBeginAction:^{
        
        UIControl *whiteBoard = [[UIControl alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
        whiteBoard.alpha = 0.1;
        whiteBoard.tag = 111222;
        [whiteBoard addTarget:self action:@selector(whilteBoardTouchDown) forControlEvents:UIControlEventTouchDown];
        [self.view insertSubview:whiteBoard belowSubview:commentBar];
        [whiteBoard release];
        
        
    } withEndAction:^{
        
        [[self.view viewWithTag:111222]removeFromSuperview];
        
    }];
    commentBar.layer.cornerRadius = 3.0f;
    commentBar.layer.borderWidth = 2.0f;
    commentBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    commentBar.layer.shadowOpacity = 0.6;
    commentBar.layer.shadowOffset = CGSizeMake(3.0f,-2.0f);
    commentBar.articleId = self.articleId;
    [self.view addSubview:commentBar];
    [commentBar release];


}

- (void)whilteBoardTouchDown
{
    [commentBar commentReset];
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
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *baseView = [[[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,22)]autorelease];
    
    UIImageView *newestView = [[UIImageView alloc]initWithFrame:CGRectMake(0,5,72,22)];
    newestView.image = [UIImage imageNamed:@"last_comment.png"];
    [baseView addSubview:newestView];
    [newestView release];
    
    return baseView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [sourceArray objectAtIndex:indexPath.row];
    
    return [ArticleCommentCell heightForContentDict:item forTable:tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ArticleCommentCell *cell = (ArticleCommentCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[[ArticleCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    [cell setcontentDict:[sourceArray objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)getCommentList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.articleId forKey:@"articleId"];
    [params setObject:[NSNumber numberWithInt:self.pageIndex]  forKey:@"pageIndex"];
    [params setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeArticleComment withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getCommentListSuccess:" withFaildRequestMethod:@"getCommentListFaild:"];
}

- (void)getCommentListSuccess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        [sourceArray addObjectsFromArray:[resultDict objectForKey:@"data"]];
        
        [self.listTable reloadData];
        
    }else{
        
    }
}

- (void)getCommentListFaild:(NSDictionary*)resultDict
{
    
}

@end
