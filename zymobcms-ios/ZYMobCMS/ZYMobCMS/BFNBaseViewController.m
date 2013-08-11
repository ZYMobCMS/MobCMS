//
//  BFNBaseViewController.m
//  PPFIphone
//
//  Created by barfoo2 on 13-6-25.
//  Copyright (c) 2013年 li sha. All rights reserved.
//

#import "BFNBaseViewController.h"

@interface BFNBaseViewController ()

@end

@implementation BFNBaseViewController
@synthesize mainTitle;
@synthesize isSwipTurnOn;

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
    self.mainTitle = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isSwipTurnOn = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipReturn
{
    ZYMobCMSAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [self.navigationController popViewControllerAnimated:YES];
    
    BFNBaseViewController *topVC = (BFNBaseViewController*)[(UINavigationController*)delegate.rootViewController.detailViewController topViewController];
    if (topVC.isSwipTurnOn) {
        delegate.rootViewController.openTouchRecieve = NO;
    }else{
        delegate.rootViewController.openTouchRecieve = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)enableSwipRightToReturn
{
    //swipToReturn
    UISwipeGestureRecognizer *swipRightToReturn = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipReturn)];
    [self.view addGestureRecognizer:swipRightToReturn];
    [swipRightToReturn release];
    isSwipTurnOn = YES;
}

- (void)desableSwipRightToReturn
{    
    
}

@end
