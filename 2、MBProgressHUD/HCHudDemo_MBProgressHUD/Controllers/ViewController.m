//
//  ViewController.m
//  HCHudDemo-MBProgressHUD
//
//  Created by wz on 16/4/9.
//  Copyright © 2016年 hotchook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showWait:@"wait..."];
    [self performSelector:@selector(hideHud) withObject:nil afterDelay:2];
//    [self showMessage:@"msg..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
