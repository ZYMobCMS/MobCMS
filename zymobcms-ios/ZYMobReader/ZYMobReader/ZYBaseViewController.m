//
//  ZYBaseViewController.m
//  ZYMobReader
//
//  Created by ZYVincent on 13-9-11.
//  Copyright (c) 2013年 ZYProSoft. All rights reserved.
//

#import "ZYBaseViewController.h"

#define ZYBaseNavBarHeight 44
@interface ZYBaseViewController ()

@end

@implementation ZYBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    navBar = [[ZYBaseNavBar alloc]initBaseReturnBarWithFrame:CGRectMake(0,self.view.frame.size.height-ZYBaseNavBarHeight,self.view.frame.size.width,ZYBaseNavBarHeight) withTarget:self withReturnSel:@selector(returnBack)];
    [self.view addSubview:navBar];
    [navBar release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)returnBack
{
    [ZYBaseUitil rootNavPopViewController:self];
}

@end
