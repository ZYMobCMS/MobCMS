
//
//  BFNImagePreViewController.m
//  PPFIphone
//
//  Created by barfoo2 on 13-7-8.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNImagePreViewController.h"
#import "BFImageScroller.h"

#define Left_Right_Margin 30
#define Top_BottoM_Margin 50

#define SubScrollerBaseTag 3999999

@interface BFNImagePreViewController ()

@end

@implementation BFNImagePreViewController
@synthesize imgString;
@synthesize superVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageString:(NSString *)imageString
{
    if (self = [super init]) {

        self.imgString = imageString;
        
        
    }
    return self;
}
- (void)dealloc
{
    self.imgString = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    backScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    backScroller.delegate = self;
    [self.view addSubview:backScroller];
    [backScroller release];
 
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(20,self.view.frame.size.height-60, 40,40);
    [saveBtn addTarget:self action:@selector(saveCurrentImage) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setBackgroundImage:[UIImage imageNamed:@"pre_image_save.png"] forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    
    pageControlView = [[UILabel alloc]initWithFrame:CGRectMake(100,self.view.frame.size.height-60,120,40)];
    pageControlView.textColor = [UIColor whiteColor];
    [pageControlView setText:@"1/1"];
    pageControlView.backgroundColor = [UIColor clearColor];
    pageControlView.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:pageControlView];
    [pageControlView release];
    pageControlView.userInteractionEnabled = NO;
    
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(260,self.view.frame.size.height-60, 40,40);
    [closeBtn addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"pre_image_close.png"] forState:UIControlStateNormal];
    [self.view addSubview:closeBtn];
    
    [self getAllImagesNow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - show ImageView
- (void)getAllImagesNow
{
    NSArray *images = [self.imgString componentsSeparatedByString:@"|"];
    
    for (int i=0; i<images.count; i++) {
        
        CGRect newRect = CGRectMake(backScroller.frame.size.width*i,0,backScroller.frame.size.width,backScroller.frame.size.height);
        
        BFImageScroller *subScroller = [[BFImageScroller alloc]initWithFrame:newRect];
        subScroller.contentSize = CGSizeMake(newRect.size.width,newRect.size.height);
        subScroller.maximumZoomScale = 3.0f;
        subScroller.minimumZoomScale = 1.0f;
        subScroller.delegate = self;
        subScroller.tag = SubScrollerBaseTag+i;
        [[BFImageDownloader shareLoader]downloadImageWithUrl:[images objectAtIndex:i] forView:subScroller.contentImageView shouldResize:NO];
        [backScroller addSubview:subScroller];
        [subScroller release];
    }
    backScroller.contentSize = CGSizeMake(self.view.frame.size.width*images.count,self.view.frame.size.height);
    backScroller.pagingEnabled = YES;
    
    NSString *pageText = [NSString stringWithFormat:@"%d/%d",1,images.count];
    [pageControlView setText:pageText];
}

#pragma mark - scrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == backScroller) {
        NSArray *images = [self.imgString componentsSeparatedByString:@"|"];
        
        int currentPage = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) /  scrollView.frame.size.width) + 1;
        
        NSString *pageText = [NSString stringWithFormat:@"%d/%d",currentPage+1,images.count];
        
        [pageControlView setText:pageText];
    }
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView.tag>=SubScrollerBaseTag) {
        
        BFImageScroller *scroller = (BFImageScroller*)scrollView;
        
        return scroller.contentImageView;
        
    }else{
        return nil;
    }
}


- (void)saveCurrentImage
{
    int currentPage = floor((backScroller.contentOffset.x - backScroller.frame.size.width / 2) /  backScroller.frame.size.width) + 1;

    NSArray *images = [self.imgString componentsSeparatedByString:@"|"];

    if ([BFImageCache imageForUrl:[images objectAtIndex:currentPage]]) {
       
        UIImageWriteToSavedPhotosAlbum([BFImageCache imageForUrl:[images objectAtIndex:currentPage]], self, @selector(image:didFinishWithSaveError:withContext:), nil);

    }
}

- (void)image:(UIImage*)image didFinishWithSaveError:(NSError*)error withContext:(void*)context
{
    if (error!=nil) {
        
        if ([BFUitils  isIOSVersionOver6]) {
            
            UIAlertView *alertWarning = [[UIAlertView alloc]initWithTitle:@"保存失败" message:@"您需要在系统设置中打开此应用的照片保存权限" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alertWarning show];
            [alertWarning release];
            
            
        }else{
            NSString *errorMsg = error.localizedDescription;
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
        
    }else{
        
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

- (void)closeSelf
{
    [self.superVC dismissModalViewControllerAnimated:YES];
}

@end
