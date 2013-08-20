//
//  ZYAboutViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-10.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYAboutViewController.h"
#import "ZYAboutCell.h"
#import "ZYButtonCell.h"
#import "ZYReplyViewController.h"
#import "BFNPreviewViewController.h"


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
    
    //logo header
    ZYPullHeaderView *headView = [[ZYPullHeaderView alloc]
                          initWithFrame:
                          CGRectMake(0.0f, 0.0f - listTable.bounds.size.height, self.view.frame.size.width,listTable.bounds.size.height)];
    [listTable addSubview:headView];
    [headView release];

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
    return 2;
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
        return [ZYAboutCell heightForDict:[sourceArray objectAtIndex:indexPath.row] forTable:tableView];
    }else{
        return 44.0f;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell";
        ZYAboutCell *cell = (ZYAboutCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (!cell) {
            cell = [[[ZYAboutCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
            UIImageView *cellNormalBack = [[UIImageView alloc]init];
            cellNormalBack.backgroundColor = [BFUitils rgbColor:212 green:212 blue:212];
            cell.selectedBackgroundView = cellNormalBack;
            [cellNormalBack release];
        }
        [cell setContentDict:[sourceArray objectAtIndex:indexPath.row]];
        if ([[[sourceArray objectAtIndex:indexPath.row]objectForKey:@"type_name"]isEqualToString:@"主页"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"ButtonCell";
        ZYButtonCell *cell = (ZYButtonCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[ZYButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withTapOnBtn:^{
                [self contactUsNow];
            }]autorelease];
        }
        [cell.actionBtn setBackgroundImage:[UIImage imageNamed:@"red_button.png"] forState:UIControlStateNormal];
        [cell.actionBtn setTitle:@"联系我们" forState:UIControlStateNormal];
        
        
        return cell;

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [sourceArray objectAtIndex:indexPath.row];
    NSString *typeName = [item objectForKey:@"type_name"];
    
    if ([typeName isEqualToString:@"主页"]) {
        
        BFNPreviewViewController *preVC = [[BFNPreviewViewController alloc]init];
        preVC.url = [item objectForKey:@"value"];
        if ([preVC.url rangeOfString:@"http://"].location == NSNotFound) {
            preVC.url = [NSString stringWithFormat:@"http://%@",preVC.url];
        }
        preVC.mainTitle = [item objectForKey:@"tag"];
        preVC.isLoadUrl = YES;
        [ZYMobCMSUitil setBFNNavItemForReturn:preVC];
        [self.navigationController pushViewController:preVC animated:YES];
        [preVC release];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (void)contactUsNow
{
    UIActionSheet *chooseSheet = [[UIActionSheet alloc]initWithTitle:@"选择方式" delegate:self cancelButtonTitle:@"退出" destructiveButtonTitle:@"呼叫座机" otherButtonTitles:@"呼叫手机",@"留言反馈",@"邮件提醒",@"短信通知",nil];
    [chooseSheet showInView:self.view];
    [chooseSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"title for index:%d %@--->",buttonIndex,[actionSheet buttonTitleAtIndex:buttonIndex]);

    NSString *tile = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    switch (buttonIndex) {
        case 0:
        {
            for (NSDictionary *item in sourceArray) {
                if ([tile rangeOfString:[item objectForKey:@"type_name"]].location != NSNotFound) {
                    
                    UIDevice *device = [UIDevice currentDevice];
                    if ([[device model] isEqualToString:@"iPhone"] ) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[item objectForKey:@"value"]]]];
                    } else {
                        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不支持通话" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [Notpermitted show];
                        [Notpermitted release];
                    }
                    
                    break;
                    
                }
            }
        }
            break;
        case 1:
        {
            for (NSDictionary *item in sourceArray) {
                if ([tile rangeOfString:[item objectForKey:@"type_name"]].location != NSNotFound) {
                    
                    UIDevice *device = [UIDevice currentDevice];
                    if ([[device model] isEqualToString:@"iPhone"] ) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[item objectForKey:@"value"]]]];
                    } else {
                        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不支持通话" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [Notpermitted show];
                        [Notpermitted release];
                    }
                    
                    break;
                    
                }
            }
            
        }
            break;
        case 2:
        {
            ZYReplyViewController *replyVC = [[ZYReplyViewController alloc]init];
            replyVC.mainTitle = @"给我们反馈";
            [ZYMobCMSUitil setBFNNavItemForReturn:replyVC];
            [self.navigationController pushViewController:replyVC animated:YES];
            [replyVC release];
        }
            break;
        case 3:
        {
            for (NSDictionary *item in sourceArray) {
                if ([tile rangeOfString:[item objectForKey:@"type_name"]].location != NSNotFound) {
                    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc]init];
                    mailVC.mailComposeDelegate = self;
                    [mailVC setToRecipients:[NSArray arrayWithObject:[item objectForKey:@"value"]]];
                    [mailVC setSubject:@"给我们反馈"];
                    [mailVC setMessageBody:@"请给我们您的建议" isHTML:NO];
                    [self presentModalViewController:mailVC animated:YES];
                    [mailVC release];
                    
                    break;
                    
                }
            }

        }
            break;
        case 4:
        {
            if (![MFMessageComposeViewController canSendText]) {
                UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"提示" message:@"此设备不支持短信" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [Notpermitted show];
                [Notpermitted release];
            }else{
                for (NSDictionary *item in sourceArray) {
                    if ([tile rangeOfString:[item objectForKey:@"type_name"]].location != NSNotFound) {
                        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]init];
                        messageVC.messageComposeDelegate = self;
                        [messageVC setRecipients:[NSArray arrayWithObject:[item objectForKey:@"value"]]];
                        [messageVC setBody:@"请给我们您的建议"];
                        [self presentModalViewController:messageVC animated:YES];
                        [messageVC release];
                        
                        break;
                        
                    }
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
        {
            [self dismissModalViewControllerAnimated:YES];
        }
            break;
        case MessageComposeResultFailed:
        {
            [SVProgressHUD showErrorWithStatus:@"发送短信失败"];
        }
            break;
        case MessageComposeResultSent:
        {
            [SVProgressHUD showErrorWithStatus:@"发送短信成功，感谢您的反馈"];
            [self dismissModalViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            [self dismissModalViewControllerAnimated:YES];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [SVProgressHUD showErrorWithStatus:@"发送邮件失败"];
        }
            break;
        case MFMailComposeResultSaved:
        {
            [SVProgressHUD showSuccessWithStatus:@"保存邮件成功"];
            [self dismissModalViewControllerAnimated:YES];
        }
            break;
        case MFMailComposeResultSent:
        {
            [SVProgressHUD showSuccessWithStatus:@"发送邮件成功,感谢您的反馈"];
            [self dismissModalViewControllerAnimated:YES];

        }
            break;
            
        default:
            break;
    }
}
@end
