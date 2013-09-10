//
//  ZYRootNavViewController.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-9.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYRootNavViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ZYRootNavViewController ()

@end

@implementation ZYRootNavViewController
@synthesize panGesture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _detailViewControllers = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)dealloc
{
    [_detailViewControllers release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:self.panGesture];
    [self.panGesture release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushNewDetailViewController:(UIViewController *)detailViewController
{
    
    [_detailViewControllers addObject:detailViewController];
    detailViewController.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.width);
    [self.view addSubview:detailViewController.view];

}

- (void)popDetailViewController:(UIViewController *)detailController
{
    [_detailViewControllers removeObject:detailController];
}

@end
