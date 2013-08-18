//
//  ZYPicturePreViewController.m
//  ZYMobCMS
//
//  Created by ZYVincent on 13-8-11.
//  Copyright (c) 2013年 ZYVincent. All rights reserved.
//

#import "ZYPicturePreViewController.h"

@interface ZYPicturePreViewController ()

@end

@implementation ZYPicturePreViewController
@synthesize summaryText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImageString:(NSString *)imageString withSummaryText:(NSString *)summary
{
    if (self = [super initWithImageString:imageString]) {
        
        self.summaryText = summary;
    }
    return self;
}

- (void)dealloc
{
    self.summaryText = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //reset
    backScroller.frame = CGRectMake(backScroller.frame.origin.x,backScroller.frame.origin.y-44,backScroller.frame.size.width,backScroller.frame.size.height-44);
    saveBtn.frame = CGRectMake(saveBtn.frame.origin.x,saveBtn.frame.origin.y-44,saveBtn.frame.size.width,saveBtn.frame.size.height);
    closeBtn.frame = CGRectMake(closeBtn.frame.origin.x,closeBtn.frame.origin.y-44,closeBtn.frame.size.width,closeBtn.frame.size.height);
    pageControlView.frame = CGRectMake(pageControlView.frame.origin.x,pageControlView.frame.origin.y-44,pageControlView.frame.size.width,pageControlView.frame.size.height);
    
    summaryTextView = [[UITextView alloc]init];
    summaryTextView.frame = CGRectMake(20,0,self.view.frame.size.width-40,70);
    summaryTextView.backgroundColor = [UIColor clearColor];
    summaryTextView.textColor = [UIColor whiteColor];
    summaryTextView.editable = NO;
    summaryTextView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    summaryTextView.text = self.summaryText;
    [self.view addSubview:summaryTextView];
    [summaryTextView release];
    [summaryTextView scrollRectToVisible:CGRectMake(0,0,summaryTextView.frame.size.width,summaryTextView.frame.size.height) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
