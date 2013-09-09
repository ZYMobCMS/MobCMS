//
//  ZYRootNavViewController.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-9.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYRootNavViewController.h"

@interface ZYRootNavViewController ()

@end

@implementation ZYRootNavViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushNewDetailViewController:(UIViewController *)detailViewController
{
    
}

- (void)popDetailViewController:(UIViewController *)detailController
{
    
}

@end
