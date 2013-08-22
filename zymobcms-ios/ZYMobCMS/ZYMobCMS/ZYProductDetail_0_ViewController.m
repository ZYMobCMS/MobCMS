//
//  ZYProductDetail_0_ViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-21.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYProductDetail_0_ViewController.h"
#import "ZYAboutCell.h"
#import "ZYProductDetail_0_Header_Cell.h"
#import "ZYProductDetail_0_Control_Cell.h"
#import "ZYProductDetail_0_MutilText_Cell.h"
#import "ZYProductDetail_0_Text_Cell.h"
#import "CommentListViewController.h"
#import "ZYProductCommentViewController.h"

@interface ZYProductDetail_0_ViewController ()

@end

@implementation ZYProductDetail_0_ViewController
@synthesize productId;
@synthesize isFavorited;

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
    self.productId = nil;
    [listArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if(!listArray){
        listArray = [[NSMutableArray alloc]init];
    }
    listTable = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44) style:UITableViewStyleGrouped];
    listTable.dataSource = self;
    listTable.delegate = self;
    [self.view addSubview:listTable];
    [listTable release];
    
    //跟贴
    UIButton *oveaSeaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oveaSeaBtn.frame = CGRectMake(0,0,30,30);
    oveaSeaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [oveaSeaBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"comment_btn_normal.png"] forState:UIControlStateNormal];
    [oveaSeaBtn setBackgroundImage:[UIImage imageNamed:@"commnet_btn_selected.png"] forState:UIControlStateSelected];
    [oveaSeaBtn addTarget:self action:@selector(commentListAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:oveaSeaBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    [self getProductDetail];
}

- (void)commentListAction
{
    ZYProductCommentViewController *commentVC = [[ZYProductCommentViewController alloc]initWithArticleId:self.productId];
    commentVC.mainTitle = @"跟贴";
    [ZYMobCMSUitil setBFNNavItemForReturn:commentVC];
    [self.navigationController pushViewController:commentVC animated:YES];
    commentVC.commentBar.favoriteType = ZYFavoriteProduct;
    commentVC.commentBar.commentType = ZYCommentProduct;
    [commentVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate and source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (listArray.count>0) {
        return [[listArray objectAtIndex:section] count];
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0.f;
    switch (indexPath.section) {
        case 0:
        {
            cellHeight = ZYProductDetail_0_Header_CellHeight;
        }
            break;
        case 1:
        {
            cellHeight = ZYProductDetail_0_ControllCellHeight;
        }
            break;
        case 2:
        {
            cellHeight = [ZYProductDetail_0_MutilText_Cell heightForDict:[[listArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]  forTable:tableView];
        }
            break;
        case 3:
        {
            cellHeight = [ZYProductDetail_0_Text_Cell heightForContent:[[listArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] forTable:tableView];
        }
            break;
        default:
            cellHeight = 44.0f;
            break;
    }
    return cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString * myCell = @"HeaderCell";
            ZYProductDetail_0_Header_Cell * cell = (ZYProductDetail_0_Header_Cell*)[tableView dequeueReusableCellWithIdentifier:myCell];
            if (cell == nil) {
                cell = [[[ZYProductDetail_0_Header_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
            }
            [cell setProductImageUrl:[[listArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
            
            return cell;
        }
            break;
        case 1:
        {
            static NSString * myCell = @"ControlCell";
            ZYProductDetail_0_Control_Cell * cell = (ZYProductDetail_0_Control_Cell*)[tableView dequeueReusableCellWithIdentifier:myCell];
            if (cell == nil) {
                cell = [[[ZYProductDetail_0_Control_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell setTapBeginFavAction:^{
                    if (![ZYUserManager userIsLogined]) {
                        ZYLoginViewController *loginVC = [[ZYLoginViewController alloc]init];
                        loginVC.mainTitle = @"登录";
                        [ZYMobCMSUitil setBFNNavItemForReturn:loginVC];
                        [loginVC setSuccessLoginAction:^{
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        [self.navigationController pushViewController:loginVC animated:YES];
                        [loginVC release];
                        return;
                    }
                }];
                [cell setTapBeginCommentAction:^{
                    [self commentListAction];
                }];
            }
            [cell setContentDict:[[listArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
            
            return cell;
        }
            break;
        case 2:
        {
            static NSString * myCell = @"MutilCell";
            ZYProductDetail_0_MutilText_Cell * cell = (ZYProductDetail_0_MutilText_Cell*)[tableView dequeueReusableCellWithIdentifier:myCell];
            if (cell == nil) {
                cell = [[[ZYProductDetail_0_MutilText_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
                UIImageView *cellNormalBack = [[UIImageView alloc]init];
                cellNormalBack.backgroundColor = [BFUitils rgbColor:212 green:212 blue:212];
                cell.selectedBackgroundView = cellNormalBack;
                [cellNormalBack release];
            }
            NSDictionary *item = [[listArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            [cell setContentDict:item];
            if ([[item objectForKey:ZYCellActionKey]intValue]!=ZYCellActionNone) {
                if (![[item objectForKey:ZYCellActionOpenKey]boolValue]) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }else{
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            return cell;
        }
            break;
        case 3:
        {
            static NSString * myCell = @"TextCell";
            ZYProductDetail_0_Text_Cell * cell = (ZYProductDetail_0_Text_Cell*)[tableView dequeueReusableCellWithIdentifier:myCell];
            if (cell == nil) {
                cell = [[[ZYProductDetail_0_Text_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
            }
            [cell setContentString:[[listArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
            
            return cell;
        }
            break;
        default:
        {
            static NSString * myCell = @"DefaultCell";
            UITableViewCell * cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:myCell];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell]autorelease];
            }

            return cell;
        }
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getProductDetail
{
    //set params
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setObject:self.productId forKey:@"productId"];
    
    [[BFNetWorkHelper shareHelper]requestDataWithApplicationType:ZYCMSRequestTypeProductDetail withParams:params withHelperDelegate:self withSuccessRequestMethod:@"getProductDetailSucess:" withFaildRequestMethod:@"getProductDetailFaild:"];
}

- (void)getProductDetailSucess:(NSDictionary*)resultDict
{
    BOOL status = [[resultDict objectForKey:@"status"]boolValue];
    if (status) {
        
        NSDictionary *productItem = [resultDict objectForKey:@"data"];
        NSLog(@"product --->%@",productItem);
        
        //头部图片
        [listArray addObject:[NSArray arrayWithObject:[productItem objectForKey:@"images"]]];
        
        //中部喜欢与评论数量
        NSMutableDictionary *favAndComments = [NSMutableDictionary dictionary];
        [favAndComments setObject:[productItem objectForKey:@"favorite_count"] forKey:@"favorite_count"];
        [favAndComments setObject:[productItem objectForKey:@"comment_count"] forKey:@"comment_count"];
        [favAndComments setObject:self.productId forKey:@"product_id"];
        [favAndComments setObject:[NSNumber numberWithBool:self.isFavorited] forKey:@"isFavorite"];
        [listArray addObject:[NSArray arrayWithObject:favAndComments]];
        
        //底部各种参数
        NSMutableArray *tagAndValues = [NSMutableArray array];
        NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
        [titleDict setObject:@"产品名称" forKey:@"tag"];
        [titleDict setObject:[self replaceNullString:[productItem objectForKey:@"title"]] forKey:@"value"];
        [titleDict setObject:[NSNumber numberWithInt:ZYCellActionNone] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:titleDict];
        
        NSMutableDictionary *priceDict = [NSMutableDictionary dictionary];
        [priceDict setObject:@"产品价格" forKey:@"tag"];
        [priceDict setObject:[self replaceNullString:[productItem objectForKey:@"price"]]  forKey:@"value"];
        [priceDict setObject:[NSNumber numberWithInt:ZYCellActionNone] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:priceDict];
        
        NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
        [sourceDict setObject:@"产品产地" forKey:@"tag"];
        [sourceDict setObject:[self replaceNullString:[productItem objectForKey:@"source"]] forKey:@"value"];
        [sourceDict setObject:[NSNumber numberWithInt:ZYCellActionNone] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:sourceDict];
        
        NSMutableDictionary *countDict = [NSMutableDictionary dictionary];
        [countDict setObject:@"产品数量" forKey:@"tag"];
        [countDict setObject:[self replaceNullString:[productItem objectForKey:@"count"]] forKey:@"value"];
        [countDict setObject:[NSNumber numberWithInt:ZYCellActionNone] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:countDict];
        
        NSMutableDictionary *contactNameDict = [NSMutableDictionary dictionary];
        [contactNameDict setObject:@"联系人" forKey:@"tag"];
        [contactNameDict setObject:[self replaceNullString:[productItem objectForKey:@"contact_name"]] forKey:@"value"];
        [contactNameDict setObject:[NSNumber numberWithInt:ZYCellActionNone] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:contactNameDict];
        
        NSMutableDictionary *contactPhoneDict = [NSMutableDictionary dictionary];
        [contactPhoneDict setObject:@"联系座机" forKey:@"tag"];
        [contactPhoneDict setObject:[self replaceNullString:[productItem objectForKey:@"contact_phone"]] forKey:@"value"];
        [contactPhoneDict setObject:[NSNumber numberWithInt:0] forKey:ZYCellActionOpenKey];
        [contactPhoneDict setObject:[NSNumber numberWithInt:ZYCellActionPhoneCall] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:contactPhoneDict];
        
        NSMutableDictionary *contactMobileDict = [NSMutableDictionary dictionary];
        [contactMobileDict setObject:@"联系手机" forKey:@"tag"];
        [contactMobileDict setObject:[self replaceNullString:[productItem objectForKey:@"contact_mobile"]]  forKey:@"value"];
        [contactMobileDict setObject:[NSNumber numberWithInt:0] forKey:ZYCellActionOpenKey];
        [contactMobileDict setObject:[NSNumber numberWithInt:ZYCellActionMobileCall] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:contactMobileDict];
        
        NSMutableDictionary *contactUrlDict = [NSMutableDictionary dictionary];
        [contactUrlDict setObject:@"联系主页" forKey:@"tag"];
        [contactUrlDict setObject:[self replaceNullString:[productItem objectForKey:@"contact_url"]] forKey:@"value"];
        [contactUrlDict setObject:[NSNumber numberWithInt:0] forKey:ZYCellActionOpenKey];
        [contactUrlDict setObject:[NSNumber numberWithInt:ZYCellActionOpenUrl] forKey:ZYCellActionKey];
        
        [tagAndValues addObject:contactUrlDict];
        
        [listArray addObject:tagAndValues];
        
        //简介
        [listArray addObject:[NSArray arrayWithObject:[self replaceNullString: [productItem objectForKey:@"content"]]]];
                
        [listTable reloadData];
    }
    
}

- (void)getProductDetailFaild:(NSDictionary*)resultDict
{
    
    
}

- (NSString*)replaceNullString:(NSObject*)source
{
    if ([source isKindOfClass:[NSNull class]]||[(NSString*)source isEqualToString:@""]||source==nil) {
        return @"暂未填写";
    }else{
        return (NSString*)source;
    }
    
}

@end
