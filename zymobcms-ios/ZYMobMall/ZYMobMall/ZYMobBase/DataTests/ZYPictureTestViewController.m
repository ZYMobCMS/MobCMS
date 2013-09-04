//
//  ZYPictureTestViewController.m
//  ZYMobMall
//
//  Created by barfoo2 on 13-9-4.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYPictureTestViewController.h"

@interface ZYPictureTestViewController ()

@end

@implementation ZYPictureTestViewController
@synthesize mItem;
@synthesize dataCenter,tabTypesArray,picListArray,commentListArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataCenter = [[ZYPictureDataCenter alloc]init];
        self.picListArray = [[NSMutableArray alloc]init];
        self.tabTypesArray = [[NSMutableArray alloc]init];
        self.commentListArray = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)dealloc
{
    self.mItem = nil;
    self.dataCenter = nil;
    self.picListArray = nil;
    self.tabTypesArray = nil;
    self.commentListArray = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pictureTabTypes:(id)sender {
    
    [self.dataCenter startGetPictureTabTypesWithCategoryId:self.mItem.categoryId];
    [self.dataCenter setGetTabTypesSuccessAction:^(NSArray *tabTypeArray) {
        NSLog(@"picture tab types --->%@",tabTypeArray);
        [self.tabTypesArray addObjectsFromArray:tabTypeArray];
    }];
    [self.dataCenter setGetTabTypesFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)pictureList:(id)sender {
    
    ZYTabTypeModel *firstItem = [self.tabTypesArray objectAtIndex:0];
    [self.dataCenter startGetPictureListWithCategoryId:firstItem.categoryId withTabTypeId:firstItem.tabTypeId withPageIndex:1];
    [self.dataCenter setSuccessGetNewPictureListAction:^(NSArray *newDataArray) {
        
        NSLog(@"picture list --->%@",newDataArray);
        [self.picListArray addObjectsFromArray:newDataArray];
        
    }];
    [self.dataCenter setFaildGetNewPictureListAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)pictureDetail:(id)sender {
    
    ZYPictureModel *firstPic = [self.picListArray objectAtIndex:0];
    [self.dataCenter startGetPictureDetailWithPictureId:firstPic.pictureId];
    [self.dataCenter setSuccessGetPictureDetailAction:^(ZYPictureModel *newPicture) {
        NSLog(@"picture detail summary ---->%@",newPicture.summary);
    }];
    [self.dataCenter setFaildGetPictureDetailAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)favoritePicture:(id)sender {
    
    ZYPictureModel *firstPic = [self.picListArray objectAtIndex:0];
    [self.dataCenter favoritePictureWithPictureId:firstPic.pictureId];
    [self.dataCenter setFavoritePictureSuccessAction:^(NSString *successMsg) {
       
        [SVProgressHUD showSuccessWithStatus:successMsg];
        
    }];
    [self.dataCenter setFavoritePictureFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}

- (IBAction)unFavoritePicture:(id)sender {
    
    ZYPictureModel *firstPict = [self.picListArray objectAtIndex:0];
    [self.dataCenter unFavoritePictureWithPictureId:firstPict.pictureId];
    [self.dataCenter setUnFavoritePictureSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.dataCenter setUnFavoritePictureFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}

- (IBAction)pictureCommentList:(id)sender {
    
    ZYPictureModel *firstPic = [self.picListArray objectAtIndex:0];
    [self.dataCenter startGetPictureCommentListWithPictureId:firstPic.pictureId withPageIndex:1];
    [self.dataCenter setGetPictureCommentListSuccess:^(NSArray *modleArray) {
       
        NSLog(@"picture comment list --->%@",modleArray);
        [self.commentListArray addObjectsFromArray:modleArray];
        
    }];
    [self.dataCenter setGetPictureCommentListFaild:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}

- (IBAction)commentPicture:(id)sender {
    
    ZYPictureModel *firstPic = [self.picListArray objectAtIndex:0];
    [self.dataCenter commentPictureWithPictureId:firstPic.pictureId withContent:@"清风拂面"];
    [self.dataCenter setCommentPictureSuccessAction:^(ZYCommentModel *commentModel) {
       
        [SVProgressHUD showSuccessWithStatus:commentModel.createTime];
        
    }];
    [self.dataCenter setCommentPictureFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
    
}

- (IBAction)supportComment:(id)sender {
    
    ZYCommentModel *firstComment = [self.commentListArray objectAtIndex:0];
    [self.dataCenter supportCommentWithCommentId:firstComment.commentId];
    [self.dataCenter setSupportCommentSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.dataCenter setSupportCommentFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}

- (IBAction)unSupportComment:(id)sender {
    ZYCommentModel *firstComment = [self.commentListArray objectAtIndex:0];
    [self.dataCenter unSupportCommentWithCommentId:firstComment.commentId];
    [self.dataCenter setUnSupportCommentSuccessAction:^(NSString *successMsg) {
        [SVProgressHUD showSuccessWithStatus:successMsg];
    }];
    [self.dataCenter setUnSupportCommentFaildAction:^(NSString *errMsg) {
        [SVProgressHUD showErrorWithStatus:errMsg];
    }];
}
@end
